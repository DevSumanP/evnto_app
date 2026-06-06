// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BaseState<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BaseState<$T>()';
}


}

/// @nodoc
class $BaseStateCopyWith<T,$Res>  {
$BaseStateCopyWith(BaseState<T> _, $Res Function(BaseState<T>) __);
}


/// Adds pattern-matching-related methods to [BaseState].
extension BaseStatePatterns<T> on BaseState<T> {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BaseInitial<T> value)?  initial,TResult Function( BaseLoading<T> value)?  loading,TResult Function( BaseSuccess<T> value)?  success,TResult Function( BaseError<T> value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BaseInitial() when initial != null:
return initial(_that);case BaseLoading() when loading != null:
return loading(_that);case BaseSuccess() when success != null:
return success(_that);case BaseError() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BaseInitial<T> value)  initial,required TResult Function( BaseLoading<T> value)  loading,required TResult Function( BaseSuccess<T> value)  success,required TResult Function( BaseError<T> value)  error,}){
final _that = this;
switch (_that) {
case BaseInitial():
return initial(_that);case BaseLoading():
return loading(_that);case BaseSuccess():
return success(_that);case BaseError():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BaseInitial<T> value)?  initial,TResult? Function( BaseLoading<T> value)?  loading,TResult? Function( BaseSuccess<T> value)?  success,TResult? Function( BaseError<T> value)?  error,}){
final _that = this;
switch (_that) {
case BaseInitial() when initial != null:
return initial(_that);case BaseLoading() when loading != null:
return loading(_that);case BaseSuccess() when success != null:
return success(_that);case BaseError() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( String? message)?  loading,TResult Function( T data,  String? message)?  success,TResult Function( String? message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BaseInitial() when initial != null:
return initial();case BaseLoading() when loading != null:
return loading(_that.message);case BaseSuccess() when success != null:
return success(_that.data,_that.message);case BaseError() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( String? message)  loading,required TResult Function( T data,  String? message)  success,required TResult Function( String? message)  error,}) {final _that = this;
switch (_that) {
case BaseInitial():
return initial();case BaseLoading():
return loading(_that.message);case BaseSuccess():
return success(_that.data,_that.message);case BaseError():
return error(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( String? message)?  loading,TResult? Function( T data,  String? message)?  success,TResult? Function( String? message)?  error,}) {final _that = this;
switch (_that) {
case BaseInitial() when initial != null:
return initial();case BaseLoading() when loading != null:
return loading(_that.message);case BaseSuccess() when success != null:
return success(_that.data,_that.message);case BaseError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class BaseInitial<T> implements BaseState<T> {
  const BaseInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseInitial<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BaseState<$T>.initial()';
}


}




/// @nodoc


class BaseLoading<T> implements BaseState<T> {
  const BaseLoading({this.message});
  

 final  String? message;

/// Create a copy of BaseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BaseLoadingCopyWith<T, BaseLoading<T>> get copyWith => _$BaseLoadingCopyWithImpl<T, BaseLoading<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseLoading<T>&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'BaseState<$T>.loading(message: $message)';
}


}

/// @nodoc
abstract mixin class $BaseLoadingCopyWith<T,$Res> implements $BaseStateCopyWith<T, $Res> {
  factory $BaseLoadingCopyWith(BaseLoading<T> value, $Res Function(BaseLoading<T>) _then) = _$BaseLoadingCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$BaseLoadingCopyWithImpl<T,$Res>
    implements $BaseLoadingCopyWith<T, $Res> {
  _$BaseLoadingCopyWithImpl(this._self, this._then);

  final BaseLoading<T> _self;
  final $Res Function(BaseLoading<T>) _then;

/// Create a copy of BaseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(BaseLoading<T>(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class BaseSuccess<T> implements BaseState<T> {
  const BaseSuccess({required this.data, this.message});
  

 final  T data;
 final  String? message;

/// Create a copy of BaseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BaseSuccessCopyWith<T, BaseSuccess<T>> get copyWith => _$BaseSuccessCopyWithImpl<T, BaseSuccess<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseSuccess<T>&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),message);

@override
String toString() {
  return 'BaseState<$T>.success(data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class $BaseSuccessCopyWith<T,$Res> implements $BaseStateCopyWith<T, $Res> {
  factory $BaseSuccessCopyWith(BaseSuccess<T> value, $Res Function(BaseSuccess<T>) _then) = _$BaseSuccessCopyWithImpl;
@useResult
$Res call({
 T data, String? message
});




}
/// @nodoc
class _$BaseSuccessCopyWithImpl<T,$Res>
    implements $BaseSuccessCopyWith<T, $Res> {
  _$BaseSuccessCopyWithImpl(this._self, this._then);

  final BaseSuccess<T> _self;
  final $Res Function(BaseSuccess<T>) _then;

/// Create a copy of BaseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,Object? message = freezed,}) {
  return _then(BaseSuccess<T>(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class BaseError<T> implements BaseState<T> {
  const BaseError({this.message});
  

 final  String? message;

/// Create a copy of BaseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BaseErrorCopyWith<T, BaseError<T>> get copyWith => _$BaseErrorCopyWithImpl<T, BaseError<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseError<T>&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'BaseState<$T>.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $BaseErrorCopyWith<T,$Res> implements $BaseStateCopyWith<T, $Res> {
  factory $BaseErrorCopyWith(BaseError<T> value, $Res Function(BaseError<T>) _then) = _$BaseErrorCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$BaseErrorCopyWithImpl<T,$Res>
    implements $BaseErrorCopyWith<T, $Res> {
  _$BaseErrorCopyWithImpl(this._self, this._then);

  final BaseError<T> _self;
  final $Res Function(BaseError<T>) _then;

/// Create a copy of BaseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(BaseError<T>(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$PaginatedState<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginatedState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaginatedState<$T>()';
}


}

/// @nodoc
class $PaginatedStateCopyWith<T,$Res>  {
$PaginatedStateCopyWith(PaginatedState<T> _, $Res Function(PaginatedState<T>) __);
}


/// Adds pattern-matching-related methods to [PaginatedState].
extension PaginatedStatePatterns<T> on PaginatedState<T> {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PaginatedInitial<T> value)?  initial,TResult Function( PaginatedLoading<T> value)?  loading,TResult Function( PaginatedSucess<T> value)?  success,TResult Function( PaginatedLoadingMore<T> value)?  loadingMore,TResult Function( PaginatedError<T> value)?  error,TResult Function( PaginatedEmpty<T> value)?  empty,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PaginatedInitial() when initial != null:
return initial(_that);case PaginatedLoading() when loading != null:
return loading(_that);case PaginatedSucess() when success != null:
return success(_that);case PaginatedLoadingMore() when loadingMore != null:
return loadingMore(_that);case PaginatedError() when error != null:
return error(_that);case PaginatedEmpty() when empty != null:
return empty(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PaginatedInitial<T> value)  initial,required TResult Function( PaginatedLoading<T> value)  loading,required TResult Function( PaginatedSucess<T> value)  success,required TResult Function( PaginatedLoadingMore<T> value)  loadingMore,required TResult Function( PaginatedError<T> value)  error,required TResult Function( PaginatedEmpty<T> value)  empty,}){
final _that = this;
switch (_that) {
case PaginatedInitial():
return initial(_that);case PaginatedLoading():
return loading(_that);case PaginatedSucess():
return success(_that);case PaginatedLoadingMore():
return loadingMore(_that);case PaginatedError():
return error(_that);case PaginatedEmpty():
return empty(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PaginatedInitial<T> value)?  initial,TResult? Function( PaginatedLoading<T> value)?  loading,TResult? Function( PaginatedSucess<T> value)?  success,TResult? Function( PaginatedLoadingMore<T> value)?  loadingMore,TResult? Function( PaginatedError<T> value)?  error,TResult? Function( PaginatedEmpty<T> value)?  empty,}){
final _that = this;
switch (_that) {
case PaginatedInitial() when initial != null:
return initial(_that);case PaginatedLoading() when loading != null:
return loading(_that);case PaginatedSucess() when success != null:
return success(_that);case PaginatedLoadingMore() when loadingMore != null:
return loadingMore(_that);case PaginatedError() when error != null:
return error(_that);case PaginatedEmpty() when empty != null:
return empty(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( bool isFirstPage,  List<T> currentData)?  loading,TResult Function( List<T> data,  int currentPage,  int totalPages,  bool hasMore)?  success,TResult Function( List<T> data,  int currentPage)?  loadingMore,TResult Function( String message,  List<T> currentData)?  error,TResult Function()?  empty,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PaginatedInitial() when initial != null:
return initial();case PaginatedLoading() when loading != null:
return loading(_that.isFirstPage,_that.currentData);case PaginatedSucess() when success != null:
return success(_that.data,_that.currentPage,_that.totalPages,_that.hasMore);case PaginatedLoadingMore() when loadingMore != null:
return loadingMore(_that.data,_that.currentPage);case PaginatedError() when error != null:
return error(_that.message,_that.currentData);case PaginatedEmpty() when empty != null:
return empty();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( bool isFirstPage,  List<T> currentData)  loading,required TResult Function( List<T> data,  int currentPage,  int totalPages,  bool hasMore)  success,required TResult Function( List<T> data,  int currentPage)  loadingMore,required TResult Function( String message,  List<T> currentData)  error,required TResult Function()  empty,}) {final _that = this;
switch (_that) {
case PaginatedInitial():
return initial();case PaginatedLoading():
return loading(_that.isFirstPage,_that.currentData);case PaginatedSucess():
return success(_that.data,_that.currentPage,_that.totalPages,_that.hasMore);case PaginatedLoadingMore():
return loadingMore(_that.data,_that.currentPage);case PaginatedError():
return error(_that.message,_that.currentData);case PaginatedEmpty():
return empty();case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( bool isFirstPage,  List<T> currentData)?  loading,TResult? Function( List<T> data,  int currentPage,  int totalPages,  bool hasMore)?  success,TResult? Function( List<T> data,  int currentPage)?  loadingMore,TResult? Function( String message,  List<T> currentData)?  error,TResult? Function()?  empty,}) {final _that = this;
switch (_that) {
case PaginatedInitial() when initial != null:
return initial();case PaginatedLoading() when loading != null:
return loading(_that.isFirstPage,_that.currentData);case PaginatedSucess() when success != null:
return success(_that.data,_that.currentPage,_that.totalPages,_that.hasMore);case PaginatedLoadingMore() when loadingMore != null:
return loadingMore(_that.data,_that.currentPage);case PaginatedError() when error != null:
return error(_that.message,_that.currentData);case PaginatedEmpty() when empty != null:
return empty();case _:
  return null;

}
}

}

/// @nodoc


class PaginatedInitial<T> implements PaginatedState<T> {
  const PaginatedInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginatedInitial<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaginatedState<$T>.initial()';
}


}




/// @nodoc


class PaginatedLoading<T> implements PaginatedState<T> {
  const PaginatedLoading({this.isFirstPage = false, final  List<T> currentData = const []}): _currentData = currentData;
  

@JsonKey() final  bool isFirstPage;
 final  List<T> _currentData;
@JsonKey() List<T> get currentData {
  if (_currentData is EqualUnmodifiableListView) return _currentData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_currentData);
}


/// Create a copy of PaginatedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginatedLoadingCopyWith<T, PaginatedLoading<T>> get copyWith => _$PaginatedLoadingCopyWithImpl<T, PaginatedLoading<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginatedLoading<T>&&(identical(other.isFirstPage, isFirstPage) || other.isFirstPage == isFirstPage)&&const DeepCollectionEquality().equals(other._currentData, _currentData));
}


@override
int get hashCode => Object.hash(runtimeType,isFirstPage,const DeepCollectionEquality().hash(_currentData));

@override
String toString() {
  return 'PaginatedState<$T>.loading(isFirstPage: $isFirstPage, currentData: $currentData)';
}


}

/// @nodoc
abstract mixin class $PaginatedLoadingCopyWith<T,$Res> implements $PaginatedStateCopyWith<T, $Res> {
  factory $PaginatedLoadingCopyWith(PaginatedLoading<T> value, $Res Function(PaginatedLoading<T>) _then) = _$PaginatedLoadingCopyWithImpl;
@useResult
$Res call({
 bool isFirstPage, List<T> currentData
});




}
/// @nodoc
class _$PaginatedLoadingCopyWithImpl<T,$Res>
    implements $PaginatedLoadingCopyWith<T, $Res> {
  _$PaginatedLoadingCopyWithImpl(this._self, this._then);

  final PaginatedLoading<T> _self;
  final $Res Function(PaginatedLoading<T>) _then;

/// Create a copy of PaginatedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isFirstPage = null,Object? currentData = null,}) {
  return _then(PaginatedLoading<T>(
isFirstPage: null == isFirstPage ? _self.isFirstPage : isFirstPage // ignore: cast_nullable_to_non_nullable
as bool,currentData: null == currentData ? _self._currentData : currentData // ignore: cast_nullable_to_non_nullable
as List<T>,
  ));
}


}

/// @nodoc


class PaginatedSucess<T> implements PaginatedState<T> {
  const PaginatedSucess({required final  List<T> data, required this.currentPage, required this.totalPages, required this.hasMore}): _data = data;
  

 final  List<T> _data;
 List<T> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}

 final  int currentPage;
 final  int totalPages;
 final  bool hasMore;

/// Create a copy of PaginatedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginatedSucessCopyWith<T, PaginatedSucess<T>> get copyWith => _$PaginatedSucessCopyWithImpl<T, PaginatedSucess<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginatedSucess<T>&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),currentPage,totalPages,hasMore);

@override
String toString() {
  return 'PaginatedState<$T>.success(data: $data, currentPage: $currentPage, totalPages: $totalPages, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class $PaginatedSucessCopyWith<T,$Res> implements $PaginatedStateCopyWith<T, $Res> {
  factory $PaginatedSucessCopyWith(PaginatedSucess<T> value, $Res Function(PaginatedSucess<T>) _then) = _$PaginatedSucessCopyWithImpl;
@useResult
$Res call({
 List<T> data, int currentPage, int totalPages, bool hasMore
});




}
/// @nodoc
class _$PaginatedSucessCopyWithImpl<T,$Res>
    implements $PaginatedSucessCopyWith<T, $Res> {
  _$PaginatedSucessCopyWithImpl(this._self, this._then);

  final PaginatedSucess<T> _self;
  final $Res Function(PaginatedSucess<T>) _then;

/// Create a copy of PaginatedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,Object? currentPage = null,Object? totalPages = null,Object? hasMore = null,}) {
  return _then(PaginatedSucess<T>(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<T>,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class PaginatedLoadingMore<T> implements PaginatedState<T> {
  const PaginatedLoadingMore({required final  List<T> data, required this.currentPage}): _data = data;
  

 final  List<T> _data;
 List<T> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}

 final  int currentPage;

/// Create a copy of PaginatedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginatedLoadingMoreCopyWith<T, PaginatedLoadingMore<T>> get copyWith => _$PaginatedLoadingMoreCopyWithImpl<T, PaginatedLoadingMore<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginatedLoadingMore<T>&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),currentPage);

@override
String toString() {
  return 'PaginatedState<$T>.loadingMore(data: $data, currentPage: $currentPage)';
}


}

/// @nodoc
abstract mixin class $PaginatedLoadingMoreCopyWith<T,$Res> implements $PaginatedStateCopyWith<T, $Res> {
  factory $PaginatedLoadingMoreCopyWith(PaginatedLoadingMore<T> value, $Res Function(PaginatedLoadingMore<T>) _then) = _$PaginatedLoadingMoreCopyWithImpl;
@useResult
$Res call({
 List<T> data, int currentPage
});




}
/// @nodoc
class _$PaginatedLoadingMoreCopyWithImpl<T,$Res>
    implements $PaginatedLoadingMoreCopyWith<T, $Res> {
  _$PaginatedLoadingMoreCopyWithImpl(this._self, this._then);

  final PaginatedLoadingMore<T> _self;
  final $Res Function(PaginatedLoadingMore<T>) _then;

/// Create a copy of PaginatedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,Object? currentPage = null,}) {
  return _then(PaginatedLoadingMore<T>(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<T>,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class PaginatedError<T> implements PaginatedState<T> {
  const PaginatedError({required this.message, final  List<T> currentData = const []}): _currentData = currentData;
  

 final  String message;
 final  List<T> _currentData;
@JsonKey() List<T> get currentData {
  if (_currentData is EqualUnmodifiableListView) return _currentData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_currentData);
}


/// Create a copy of PaginatedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginatedErrorCopyWith<T, PaginatedError<T>> get copyWith => _$PaginatedErrorCopyWithImpl<T, PaginatedError<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginatedError<T>&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._currentData, _currentData));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(_currentData));

@override
String toString() {
  return 'PaginatedState<$T>.error(message: $message, currentData: $currentData)';
}


}

/// @nodoc
abstract mixin class $PaginatedErrorCopyWith<T,$Res> implements $PaginatedStateCopyWith<T, $Res> {
  factory $PaginatedErrorCopyWith(PaginatedError<T> value, $Res Function(PaginatedError<T>) _then) = _$PaginatedErrorCopyWithImpl;
@useResult
$Res call({
 String message, List<T> currentData
});




}
/// @nodoc
class _$PaginatedErrorCopyWithImpl<T,$Res>
    implements $PaginatedErrorCopyWith<T, $Res> {
  _$PaginatedErrorCopyWithImpl(this._self, this._then);

  final PaginatedError<T> _self;
  final $Res Function(PaginatedError<T>) _then;

/// Create a copy of PaginatedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? currentData = null,}) {
  return _then(PaginatedError<T>(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,currentData: null == currentData ? _self._currentData : currentData // ignore: cast_nullable_to_non_nullable
as List<T>,
  ));
}


}

/// @nodoc


class PaginatedEmpty<T> implements PaginatedState<T> {
  const PaginatedEmpty();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginatedEmpty<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaginatedState<$T>.empty()';
}


}




/// @nodoc
mixin _$FormState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FormState()';
}


}

/// @nodoc
class $FormStateCopyWith<$Res>  {
$FormStateCopyWith(FormState _, $Res Function(FormState) __);
}


/// Adds pattern-matching-related methods to [FormState].
extension FormStatePatterns on FormState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FormInitial value)?  initial,TResult Function( FormEditing value)?  editing,TResult Function( FormValidating value)?  validating,TResult Function( FormValid value)?  valid,TResult Function( FormInvalid value)?  invalid,TResult Function( FormSubmitting value)?  submitting,TResult Function( FormSubmitted value)?  submitted,TResult Function( FormError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FormInitial() when initial != null:
return initial(_that);case FormEditing() when editing != null:
return editing(_that);case FormValidating() when validating != null:
return validating(_that);case FormValid() when valid != null:
return valid(_that);case FormInvalid() when invalid != null:
return invalid(_that);case FormSubmitting() when submitting != null:
return submitting(_that);case FormSubmitted() when submitted != null:
return submitted(_that);case FormError() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FormInitial value)  initial,required TResult Function( FormEditing value)  editing,required TResult Function( FormValidating value)  validating,required TResult Function( FormValid value)  valid,required TResult Function( FormInvalid value)  invalid,required TResult Function( FormSubmitting value)  submitting,required TResult Function( FormSubmitted value)  submitted,required TResult Function( FormError value)  error,}){
final _that = this;
switch (_that) {
case FormInitial():
return initial(_that);case FormEditing():
return editing(_that);case FormValidating():
return validating(_that);case FormValid():
return valid(_that);case FormInvalid():
return invalid(_that);case FormSubmitting():
return submitting(_that);case FormSubmitted():
return submitted(_that);case FormError():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FormInitial value)?  initial,TResult? Function( FormEditing value)?  editing,TResult? Function( FormValidating value)?  validating,TResult? Function( FormValid value)?  valid,TResult? Function( FormInvalid value)?  invalid,TResult? Function( FormSubmitting value)?  submitting,TResult? Function( FormSubmitted value)?  submitted,TResult? Function( FormError value)?  error,}){
final _that = this;
switch (_that) {
case FormInitial() when initial != null:
return initial(_that);case FormEditing() when editing != null:
return editing(_that);case FormValidating() when validating != null:
return validating(_that);case FormValid() when valid != null:
return valid(_that);case FormInvalid() when invalid != null:
return invalid(_that);case FormSubmitting() when submitting != null:
return submitting(_that);case FormSubmitted() when submitted != null:
return submitted(_that);case FormError() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( Map<String, dynamic>? formData,  Map<String, String>? errors)?  editing,TResult Function()?  validating,TResult Function( Map<String, dynamic> formData)?  valid,TResult Function( Map<String, String> errors)?  invalid,TResult Function()?  submitting,TResult Function( String? message)?  submitted,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FormInitial() when initial != null:
return initial();case FormEditing() when editing != null:
return editing(_that.formData,_that.errors);case FormValidating() when validating != null:
return validating();case FormValid() when valid != null:
return valid(_that.formData);case FormInvalid() when invalid != null:
return invalid(_that.errors);case FormSubmitting() when submitting != null:
return submitting();case FormSubmitted() when submitted != null:
return submitted(_that.message);case FormError() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( Map<String, dynamic>? formData,  Map<String, String>? errors)  editing,required TResult Function()  validating,required TResult Function( Map<String, dynamic> formData)  valid,required TResult Function( Map<String, String> errors)  invalid,required TResult Function()  submitting,required TResult Function( String? message)  submitted,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case FormInitial():
return initial();case FormEditing():
return editing(_that.formData,_that.errors);case FormValidating():
return validating();case FormValid():
return valid(_that.formData);case FormInvalid():
return invalid(_that.errors);case FormSubmitting():
return submitting();case FormSubmitted():
return submitted(_that.message);case FormError():
return error(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( Map<String, dynamic>? formData,  Map<String, String>? errors)?  editing,TResult? Function()?  validating,TResult? Function( Map<String, dynamic> formData)?  valid,TResult? Function( Map<String, String> errors)?  invalid,TResult? Function()?  submitting,TResult? Function( String? message)?  submitted,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case FormInitial() when initial != null:
return initial();case FormEditing() when editing != null:
return editing(_that.formData,_that.errors);case FormValidating() when validating != null:
return validating();case FormValid() when valid != null:
return valid(_that.formData);case FormInvalid() when invalid != null:
return invalid(_that.errors);case FormSubmitting() when submitting != null:
return submitting();case FormSubmitted() when submitted != null:
return submitted(_that.message);case FormError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class FormInitial implements FormState {
  const FormInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FormState.initial()';
}


}




/// @nodoc


class FormEditing implements FormState {
  const FormEditing({final  Map<String, dynamic>? formData, final  Map<String, String>? errors}): _formData = formData,_errors = errors;
  

 final  Map<String, dynamic>? _formData;
 Map<String, dynamic>? get formData {
  final value = _formData;
  if (value == null) return null;
  if (_formData is EqualUnmodifiableMapView) return _formData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, String>? _errors;
 Map<String, String>? get errors {
  final value = _errors;
  if (value == null) return null;
  if (_errors is EqualUnmodifiableMapView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of FormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormEditingCopyWith<FormEditing> get copyWith => _$FormEditingCopyWithImpl<FormEditing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormEditing&&const DeepCollectionEquality().equals(other._formData, _formData)&&const DeepCollectionEquality().equals(other._errors, _errors));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_formData),const DeepCollectionEquality().hash(_errors));

@override
String toString() {
  return 'FormState.editing(formData: $formData, errors: $errors)';
}


}

/// @nodoc
abstract mixin class $FormEditingCopyWith<$Res> implements $FormStateCopyWith<$Res> {
  factory $FormEditingCopyWith(FormEditing value, $Res Function(FormEditing) _then) = _$FormEditingCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic>? formData, Map<String, String>? errors
});




}
/// @nodoc
class _$FormEditingCopyWithImpl<$Res>
    implements $FormEditingCopyWith<$Res> {
  _$FormEditingCopyWithImpl(this._self, this._then);

  final FormEditing _self;
  final $Res Function(FormEditing) _then;

/// Create a copy of FormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? formData = freezed,Object? errors = freezed,}) {
  return _then(FormEditing(
formData: freezed == formData ? _self._formData : formData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,errors: freezed == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}


}

/// @nodoc


class FormValidating implements FormState {
  const FormValidating();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormValidating);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FormState.validating()';
}


}




/// @nodoc


class FormValid implements FormState {
  const FormValid({required final  Map<String, dynamic> formData}): _formData = formData;
  

 final  Map<String, dynamic> _formData;
 Map<String, dynamic> get formData {
  if (_formData is EqualUnmodifiableMapView) return _formData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_formData);
}


/// Create a copy of FormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormValidCopyWith<FormValid> get copyWith => _$FormValidCopyWithImpl<FormValid>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormValid&&const DeepCollectionEquality().equals(other._formData, _formData));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_formData));

@override
String toString() {
  return 'FormState.valid(formData: $formData)';
}


}

/// @nodoc
abstract mixin class $FormValidCopyWith<$Res> implements $FormStateCopyWith<$Res> {
  factory $FormValidCopyWith(FormValid value, $Res Function(FormValid) _then) = _$FormValidCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> formData
});




}
/// @nodoc
class _$FormValidCopyWithImpl<$Res>
    implements $FormValidCopyWith<$Res> {
  _$FormValidCopyWithImpl(this._self, this._then);

  final FormValid _self;
  final $Res Function(FormValid) _then;

/// Create a copy of FormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? formData = null,}) {
  return _then(FormValid(
formData: null == formData ? _self._formData : formData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

/// @nodoc


class FormInvalid implements FormState {
  const FormInvalid({required final  Map<String, String> errors}): _errors = errors;
  

 final  Map<String, String> _errors;
 Map<String, String> get errors {
  if (_errors is EqualUnmodifiableMapView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_errors);
}


/// Create a copy of FormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormInvalidCopyWith<FormInvalid> get copyWith => _$FormInvalidCopyWithImpl<FormInvalid>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormInvalid&&const DeepCollectionEquality().equals(other._errors, _errors));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_errors));

@override
String toString() {
  return 'FormState.invalid(errors: $errors)';
}


}

/// @nodoc
abstract mixin class $FormInvalidCopyWith<$Res> implements $FormStateCopyWith<$Res> {
  factory $FormInvalidCopyWith(FormInvalid value, $Res Function(FormInvalid) _then) = _$FormInvalidCopyWithImpl;
@useResult
$Res call({
 Map<String, String> errors
});




}
/// @nodoc
class _$FormInvalidCopyWithImpl<$Res>
    implements $FormInvalidCopyWith<$Res> {
  _$FormInvalidCopyWithImpl(this._self, this._then);

  final FormInvalid _self;
  final $Res Function(FormInvalid) _then;

/// Create a copy of FormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errors = null,}) {
  return _then(FormInvalid(
errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}

/// @nodoc


class FormSubmitting implements FormState {
  const FormSubmitting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormSubmitting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FormState.submitting()';
}


}




/// @nodoc


class FormSubmitted implements FormState {
  const FormSubmitted({this.message});
  

 final  String? message;

/// Create a copy of FormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormSubmittedCopyWith<FormSubmitted> get copyWith => _$FormSubmittedCopyWithImpl<FormSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormSubmitted&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'FormState.submitted(message: $message)';
}


}

/// @nodoc
abstract mixin class $FormSubmittedCopyWith<$Res> implements $FormStateCopyWith<$Res> {
  factory $FormSubmittedCopyWith(FormSubmitted value, $Res Function(FormSubmitted) _then) = _$FormSubmittedCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$FormSubmittedCopyWithImpl<$Res>
    implements $FormSubmittedCopyWith<$Res> {
  _$FormSubmittedCopyWithImpl(this._self, this._then);

  final FormSubmitted _self;
  final $Res Function(FormSubmitted) _then;

/// Create a copy of FormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(FormSubmitted(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class FormError implements FormState {
  const FormError({required this.message});
  

 final  String message;

/// Create a copy of FormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormErrorCopyWith<FormError> get copyWith => _$FormErrorCopyWithImpl<FormError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'FormState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $FormErrorCopyWith<$Res> implements $FormStateCopyWith<$Res> {
  factory $FormErrorCopyWith(FormError value, $Res Function(FormError) _then) = _$FormErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$FormErrorCopyWithImpl<$Res>
    implements $FormErrorCopyWith<$Res> {
  _$FormErrorCopyWithImpl(this._self, this._then);

  final FormError _self;
  final $Res Function(FormError) _then;

/// Create a copy of FormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(FormError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
