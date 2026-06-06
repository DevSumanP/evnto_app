// ==============================================================================
// lib/core/base/base_state.dart
// Base state classes using Freezed for immutability
// Provides type-safe state management
// ==============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_state.freezed.dart';

/// Base state sealed class
/// All BLoC states should implement this
abstract class BaseBlocState {
  const BaseBlocState();
}

/// Generic base state with freezed
/// Can be used for simple BLoCs with consistent state structure
@freezed
class BaseState<T> with _$BaseState<T> implements BaseBlocState {
  const factory BaseState.initial() = BaseInitial<T>;

  const factory BaseState.loading({final String? message}) = BaseLoading<T>;

  const factory BaseState.success({
    required final T data,
    final String? message,
  }) = BaseSuccess<T>;

  const factory BaseState.error({final String? message}) = BaseError<T>;
}

/// Paginated state wiht freezed
@freezed
class PaginatedState<T> with _$PaginatedState<T> implements BaseBlocState {
  const factory PaginatedState.initial() = PaginatedInitial<T>;

  const factory PaginatedState.loading({
    @Default(false) final bool isFirstPage,
    @Default([]) final List<T> currentData,
  }) = PaginatedLoading<T>;

  const factory PaginatedState.success({
    required final List<T> data,
    required final int currentPage,
    required final int totalPages,
    required final bool hasMore,
  }) = PaginatedSucess<T>;

  const factory PaginatedState.loadingMore({
    required final List<T> data,
    required final int currentPage,
  }) = PaginatedLoadingMore<T>;

  const factory PaginatedState.error({
    required final String message,
    @Default([]) final List<T> currentData,
  }) = PaginatedError<T>;

  const factory PaginatedState.empty() = PaginatedEmpty<T>;
}

/// Form state for form validation
@freezed
class FormState with _$FormState implements BaseBlocState {
  const factory FormState.initial() = FormInitial;

  const factory FormState.editing({
    final Map<String, dynamic>? formData,
    final Map<String, String>? errors,
  }) = FormEditing;

  const factory FormState.validating() = FormValidating;

  const factory FormState.valid({
    required final Map<String, dynamic> formData,
  }) = FormValid;

  const factory FormState.invalid({required final Map<String, String> errors}) =
      FormInvalid;

  const factory FormState.submitting() = FormSubmitting;

  const factory FormState.submitted({final String? message}) = FormSubmitted;

  const factory FormState.error({required final String message}) = FormError;
}
