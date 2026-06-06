// ==============================================================================
// lib/core/base/base_repository.dart
// Base class for all repositories. Catches exceptions and turns them into
// typed Failure values.
// ==============================================================================

import 'package:dartz/dartz.dart';

import '../errors/error_handler.dart';
import '../errors/failures.dart';
import '../utils/logger.dart';

/// Shorthand for the return type of repository methods.
typedef EitherFailure<T> = Future<Either<Failure, T>>;

/// Base class for all repositories.
///
/// Helpers for the common patterns:
///   - [execute]            run a single operation (usually remote)
///   - [executeLocal]       run a local-only operation (cache, DB, file)
///   - [executeVoid]        run an operation that returns nothing
///   - [executeIfOnline]    run only when the device is online
///   - [executeWithCache]   try remote first, use cache if remote fails
///   - [executeCacheFirst]  try cache first, hit remote on miss
///   - [executeAll]         run a list of operations in order, stop on first error
///   - [mapResult]          transform the success value
///   - [flatMapResult]      chain another repository call onto a success
abstract class BaseRepository {
  const BaseRepository();

  /// Run [operation]. Returns Right on success, Left on any thrown error.
  /// The error is mapped to a Failure by [ErrorHandler].
  Future<Either<Failure, T>> execute<T>({
    required final Future<T> Function() operation,
  }) async {
    try {
      final T result = await operation();
      return Right<Failure, T>(result);
    } on Object catch (e, s) {
      return Left<Failure, T>(ErrorHandler.instance.handleException(e, s));
    }
  }

  /// Run a local-only operation (cache / DB / file system).
  ///
  /// Same as [execute], but logs a warning if the error looks like a network
  /// failure. A NetworkFailure here usually means a bug (a remote call
  /// leaked into a local code path).
  Future<Either<Failure, T>> executeLocal<T>({
    required final Future<T> Function() operation,
  }) async {
    try {
      final T result = await operation();
      return Right<Failure, T>(result);
    } on Object catch (e, s) {
      final Failure failure = ErrorHandler.instance.handleException(e, s);
      if (failure is NetworkFailure) {
        AppLogger.instance.warning(
          'Local operation produced a NetworkFailure '
          '(${failure.runtimeType}). Check the call path.',
          category: 'Repository',
          error: e,
        );
      }
      return Left<Failure, T>(failure);
    }
  }

  /// Run an operation that returns nothing. Returns Right(unit) on success.
  /// Use for writes like logout, delete, save.
  Future<Either<Failure, Unit>> executeVoid({
    required final Future<void> Function() operation,
  }) async {
    try {
      await operation();
      return const Right<Failure, Unit>(unit);
    } on Object catch (e, s) {
      return Left<Failure, Unit>(
        ErrorHandler.instance.handleException(e, s),
      );
    }
  }

  /// Run [operation] only when [isOnline] returns true.
  /// If offline, returns Left(NoInternetFailure) without calling [operation].
  ///
  /// ```dart
  /// executeIfOnline(
  ///   isOnline: () => _networkInfo.isConnected,
  ///   operation: () => _remote.fetch(),
  /// );
  /// ```
  Future<Either<Failure, T>> executeIfOnline<T>({
    required final Future<bool> Function() isOnline,
    required final Future<T> Function() operation,
  }) async {
    try {
      if (!await isOnline()) {
        return Left<Failure, T>(const NoInternetFailure());
      }
    } on Object catch (e, s) {
      // If the online check itself fails, treat it as a real failure
      // instead of pretending we are online.
      AppLogger.instance.warning(
        'isOnline check threw an error',
        category: 'Repository',
        error: e,
      );
      return Left<Failure, T>(
        ErrorHandler.instance.handleException(e, s),
      );
    }
    return execute(operation: operation);
  }

  /// Try [remote] first, fall back to [readCache] if [remote] fails.
  ///
  /// Steps:
  ///   1. Call [remote]. On success, save to cache with [writeCache] and
  ///      return the fresh value.
  ///   2. On failure, call [readCache]. If it returns a value, return that.
  ///      Otherwise return the original remote error.
  ///
  /// A failed [writeCache] is logged but does not fail the call.
  /// Use this when you want fresh data but stale data is acceptable.
  Future<Either<Failure, T>> executeWithCache<T>({
    required final Future<T> Function() remote,
    required final Future<T?> Function() readCache,
    required final Future<void> Function(T data) writeCache,
  }) async {
    try {
      final T fresh = await remote();
      await _writeCacheSafely(fresh, writeCache);
      return Right<Failure, T>(fresh);
    } on Object catch (e, s) {
      try {
        final T? cached = await readCache();
        if (cached != null) {
          AppLogger.instance.info(
            'Remote failed (${e.runtimeType}); returning cached value',
            category: 'Repository',
          );
          return Right<Failure, T>(cached);
        }
      } on Object catch (cacheError, cacheStack) {
        AppLogger.instance.warning(
          'Cache read failed during fallback',
          category: 'Repository',
          error: cacheError,
        );
        // Report the cache error, but still return the remote error to the
        // caller (it is the real reason the call failed).
        ErrorHandler.instance.handleException(cacheError, cacheStack);
      }
      return Left<Failure, T>(ErrorHandler.instance.handleException(e, s));
    }
  }

  /// Try [readCache] first, fall back to [remote] on a cache miss.
  ///
  /// Steps:
  ///   1. If [forceRefresh] is false, call [readCache]. If it returns a
  ///      value, return that.
  ///   2. Otherwise (or on force refresh), call [remote] and save the
  ///      result with [writeCache].
  ///
  /// A failed [writeCache] is logged but does not fail the call.
  /// Use this when speed matters more than freshness.
  Future<Either<Failure, T>> executeCacheFirst<T>({
    required final Future<T?> Function() readCache,
    required final Future<T> Function() remote,
    required final Future<void> Function(T data) writeCache,
    final bool forceRefresh = false,
  }) async {
    if (!forceRefresh) {
      try {
        final T? cached = await readCache();
        if (cached != null) {
          return Right<Failure, T>(cached);
        }
      } on Object catch (e, s) {
        // A broken cache should not stop the remote call.
        AppLogger.instance.warning(
          'Cache read failed; will try remote',
          category: 'Repository',
          error: e,
        );
        ErrorHandler.instance.handleException(e, s);
      }
    }
    try {
      final T fresh = await remote();
      await _writeCacheSafely(fresh, writeCache);
      return Right<Failure, T>(fresh);
    } on Object catch (e, s) {
      return Left<Failure, T>(ErrorHandler.instance.handleException(e, s));
    }
  }

  /// Run [operations] one after another. Stop and return Left on the first
  /// error. On success, return Right with all results in the same order.
  ///
  /// Use this for steps that depend on each other. For independent parallel
  /// work, use `Future.wait` directly.
  Future<Either<Failure, List<T>>> executeAll<T>({
    required final List<Future<T> Function()> operations,
  }) async {
    try {
      final List<T> results = <T>[];
      for (final Future<T> Function() op in operations) {
        results.add(await op());
      }
      return Right<Failure, List<T>>(results);
    } on Object catch (e, s) {
      return Left<Failure, List<T>>(
        ErrorHandler.instance.handleException(e, s),
      );
    }
  }

  /// Transform the success value of an Either. Failures pass through unchanged.
  Future<Either<Failure, R>> mapResult<T, R>(
    final Future<Either<Failure, T>> source,
    final R Function(T value) transform,
  ) async {
    final Either<Failure, T> result = await source;
    return result.map(transform);
  }

  /// Chain another repository call onto a success. Failures pass through.
  /// Use for "load A, then load B from A".
  Future<Either<Failure, R>> flatMapResult<T, R>(
    final Future<Either<Failure, T>> source,
    final Future<Either<Failure, R>> Function(T value) next,
  ) async {
    final Either<Failure, T> result = await source;
    return result.fold(
      (final Failure f) async => Left<Failure, R>(f),
      next,
    );
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  /// Write to the cache. If it throws, log the error and continue. A broken
  /// cache should not fail a successful remote read.
  Future<void> _writeCacheSafely<T>(
    final T value,
    final Future<void> Function(T data) writeCache,
  ) async {
    try {
      await writeCache(value);
    } on Object catch (e, s) {
      AppLogger.instance.warning(
        'Cache write failed; returning the fresh value anyway',
        category: 'Repository',
        error: e,
      );
      ErrorHandler.instance.handleException(e, s);
    }
  }
}
