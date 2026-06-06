// ==============================================================================
// lib/core/base/base_event.dart
// Base event classes using Freezed
// Provides type-safe event management
// ==============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_event.freezed.dart';

/// Base event abstract class
abstract class BaseBlocEvent {
  const BaseBlocEvent();
}

/// Generic base events with freezed
@freezed
class BaseEvent with _$BaseEvent implements BaseBlocEvent {
  const factory BaseEvent.fetch({@Default(false) final bool forceRefresh}) =
      BaseFetchEvent;

  const factory BaseEvent.refresh() = BaseRefreshEvent;

  const factory BaseEvent.retry() = BaseRetryEvent;

  const factory BaseEvent.clear() = BaseClearEvent;

  const factory BaseEvent.reset() = BaseResetEvent;
}

/// CRUD events with freezed
@freezed
class CrudEvent<T> with _$CrudEvent<T> implements BaseBlocEvent {
  const factory CrudEvent.create({required final T data}) = CrudCreateEvent<T>;

  const factory CrudEvent.read({required final String id}) = CrudReadEvent<T>;

  const factory CrudEvent.update({
    required final String id,
    required final T data,
  }) = CrudUpdateEvent<T>;

  const factory CrudEvent.delete({required final String id}) =
      CrudDeleteEvent<T>;

  const factory CrudEvent.list() = CrudListEvent<T>;
}

/// Search and filter events
@freezed
class SearchEvent with _$SearchEvent implements BaseBlocEvent {
  const factory SearchEvent.search({required final String query}) =
      SearchQueryEvent;

  const factory SearchEvent.filter({
    required final Map<String, dynamic> filters,
  }) = SearchFilterEvent;

  const factory SearchEvent.sort({
    required final String sortBy,
    @Default(true) final bool ascending,
  }) = SearchSortEvent;

  const factory SearchEvent.clear() = SearchClearEvent;
}

/// Pagination events
@freezed
class PaginationEvent with _$PaginationEvent implements BaseBlocEvent {
  const factory PaginationEvent.fetchPage({
    required final int page,
    @Default(20) final int pageSize,
  }) = PaginationFetchPageEvent;

  const factory PaginationEvent.loadMore() = PaginationLoadMoreEvent;

  const factory PaginationEvent.refresh() = PaginationRefreshEvent;
}

/// Form events
@freezed
class FormEvent with _$FormEvent implements BaseBlocEvent {
  const factory FormEvent.fieldChanged({
    required final String fieldName,
    required final dynamic value,
  }) = FormFieldChangedEvent;

  const factory FormEvent.validate() = FormValidateEvent;

  const factory FormEvent.submit() = FormSubmitEvent;

  const factory FormEvent.reset() = FormResetEvent;

  const factory FormEvent.clear() = FormClearEvent;
}
