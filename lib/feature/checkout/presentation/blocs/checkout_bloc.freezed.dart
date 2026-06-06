// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CheckoutEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutEvent()';
}


}

/// @nodoc
class $CheckoutEventCopyWith<$Res>  {
$CheckoutEventCopyWith(CheckoutEvent _, $Res Function(CheckoutEvent) __);
}


/// Adds pattern-matching-related methods to [CheckoutEvent].
extension CheckoutEventPatterns on CheckoutEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CheckoutStarted value)?  started,TResult Function( CheckoutPlaceOrderTapped value)?  placeOrderTapped,TResult Function( CheckoutVerifyRequested value)?  verifyRequested,TResult Function( CheckoutPaymentCanceled value)?  paymentCanceled,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CheckoutStarted() when started != null:
return started(_that);case CheckoutPlaceOrderTapped() when placeOrderTapped != null:
return placeOrderTapped(_that);case CheckoutVerifyRequested() when verifyRequested != null:
return verifyRequested(_that);case CheckoutPaymentCanceled() when paymentCanceled != null:
return paymentCanceled(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CheckoutStarted value)  started,required TResult Function( CheckoutPlaceOrderTapped value)  placeOrderTapped,required TResult Function( CheckoutVerifyRequested value)  verifyRequested,required TResult Function( CheckoutPaymentCanceled value)  paymentCanceled,}){
final _that = this;
switch (_that) {
case CheckoutStarted():
return started(_that);case CheckoutPlaceOrderTapped():
return placeOrderTapped(_that);case CheckoutVerifyRequested():
return verifyRequested(_that);case CheckoutPaymentCanceled():
return paymentCanceled(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CheckoutStarted value)?  started,TResult? Function( CheckoutPlaceOrderTapped value)?  placeOrderTapped,TResult? Function( CheckoutVerifyRequested value)?  verifyRequested,TResult? Function( CheckoutPaymentCanceled value)?  paymentCanceled,}){
final _that = this;
switch (_that) {
case CheckoutStarted() when started != null:
return started(_that);case CheckoutPlaceOrderTapped() when placeOrderTapped != null:
return placeOrderTapped(_that);case CheckoutVerifyRequested() when verifyRequested != null:
return verifyRequested(_that);case CheckoutPaymentCanceled() when paymentCanceled != null:
return paymentCanceled(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String eventId,  List<CartItem> items,  BuyerDto buyer)?  started,TResult Function()?  placeOrderTapped,TResult Function( String orderId,  String pidx)?  verifyRequested,TResult Function()?  paymentCanceled,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CheckoutStarted() when started != null:
return started(_that.eventId,_that.items,_that.buyer);case CheckoutPlaceOrderTapped() when placeOrderTapped != null:
return placeOrderTapped();case CheckoutVerifyRequested() when verifyRequested != null:
return verifyRequested(_that.orderId,_that.pidx);case CheckoutPaymentCanceled() when paymentCanceled != null:
return paymentCanceled();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String eventId,  List<CartItem> items,  BuyerDto buyer)  started,required TResult Function()  placeOrderTapped,required TResult Function( String orderId,  String pidx)  verifyRequested,required TResult Function()  paymentCanceled,}) {final _that = this;
switch (_that) {
case CheckoutStarted():
return started(_that.eventId,_that.items,_that.buyer);case CheckoutPlaceOrderTapped():
return placeOrderTapped();case CheckoutVerifyRequested():
return verifyRequested(_that.orderId,_that.pidx);case CheckoutPaymentCanceled():
return paymentCanceled();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String eventId,  List<CartItem> items,  BuyerDto buyer)?  started,TResult? Function()?  placeOrderTapped,TResult? Function( String orderId,  String pidx)?  verifyRequested,TResult? Function()?  paymentCanceled,}) {final _that = this;
switch (_that) {
case CheckoutStarted() when started != null:
return started(_that.eventId,_that.items,_that.buyer);case CheckoutPlaceOrderTapped() when placeOrderTapped != null:
return placeOrderTapped();case CheckoutVerifyRequested() when verifyRequested != null:
return verifyRequested(_that.orderId,_that.pidx);case CheckoutPaymentCanceled() when paymentCanceled != null:
return paymentCanceled();case _:
  return null;

}
}

}

/// @nodoc


class CheckoutStarted implements CheckoutEvent {
  const CheckoutStarted({required this.eventId, required final  List<CartItem> items, required this.buyer}): _items = items;
  

 final  String eventId;
 final  List<CartItem> _items;
 List<CartItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  BuyerDto buyer;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutStartedCopyWith<CheckoutStarted> get copyWith => _$CheckoutStartedCopyWithImpl<CheckoutStarted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutStarted&&(identical(other.eventId, eventId) || other.eventId == eventId)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.buyer, buyer) || other.buyer == buyer));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,const DeepCollectionEquality().hash(_items),buyer);

@override
String toString() {
  return 'CheckoutEvent.started(eventId: $eventId, items: $items, buyer: $buyer)';
}


}

/// @nodoc
abstract mixin class $CheckoutStartedCopyWith<$Res> implements $CheckoutEventCopyWith<$Res> {
  factory $CheckoutStartedCopyWith(CheckoutStarted value, $Res Function(CheckoutStarted) _then) = _$CheckoutStartedCopyWithImpl;
@useResult
$Res call({
 String eventId, List<CartItem> items, BuyerDto buyer
});




}
/// @nodoc
class _$CheckoutStartedCopyWithImpl<$Res>
    implements $CheckoutStartedCopyWith<$Res> {
  _$CheckoutStartedCopyWithImpl(this._self, this._then);

  final CheckoutStarted _self;
  final $Res Function(CheckoutStarted) _then;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? items = null,Object? buyer = null,}) {
  return _then(CheckoutStarted(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CartItem>,buyer: null == buyer ? _self.buyer : buyer // ignore: cast_nullable_to_non_nullable
as BuyerDto,
  ));
}


}

/// @nodoc


class CheckoutPlaceOrderTapped implements CheckoutEvent {
  const CheckoutPlaceOrderTapped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutPlaceOrderTapped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutEvent.placeOrderTapped()';
}


}




/// @nodoc


class CheckoutVerifyRequested implements CheckoutEvent {
  const CheckoutVerifyRequested({required this.orderId, required this.pidx});
  

 final  String orderId;
 final  String pidx;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutVerifyRequestedCopyWith<CheckoutVerifyRequested> get copyWith => _$CheckoutVerifyRequestedCopyWithImpl<CheckoutVerifyRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutVerifyRequested&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.pidx, pidx) || other.pidx == pidx));
}


@override
int get hashCode => Object.hash(runtimeType,orderId,pidx);

@override
String toString() {
  return 'CheckoutEvent.verifyRequested(orderId: $orderId, pidx: $pidx)';
}


}

/// @nodoc
abstract mixin class $CheckoutVerifyRequestedCopyWith<$Res> implements $CheckoutEventCopyWith<$Res> {
  factory $CheckoutVerifyRequestedCopyWith(CheckoutVerifyRequested value, $Res Function(CheckoutVerifyRequested) _then) = _$CheckoutVerifyRequestedCopyWithImpl;
@useResult
$Res call({
 String orderId, String pidx
});




}
/// @nodoc
class _$CheckoutVerifyRequestedCopyWithImpl<$Res>
    implements $CheckoutVerifyRequestedCopyWith<$Res> {
  _$CheckoutVerifyRequestedCopyWithImpl(this._self, this._then);

  final CheckoutVerifyRequested _self;
  final $Res Function(CheckoutVerifyRequested) _then;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orderId = null,Object? pidx = null,}) {
  return _then(CheckoutVerifyRequested(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,pidx: null == pidx ? _self.pidx : pidx // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CheckoutPaymentCanceled implements CheckoutEvent {
  const CheckoutPaymentCanceled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutPaymentCanceled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutEvent.paymentCanceled()';
}


}




/// @nodoc
mixin _$CheckoutState {

 String get eventId; List<CartItem> get items; BuyerDto? get buyer; CheckoutStatus get status; CheckoutSession? get session; List<IssuedTicket> get tickets; String? get error;
/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutStateCopyWith<CheckoutState> get copyWith => _$CheckoutStateCopyWithImpl<CheckoutState>(this as CheckoutState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutState&&(identical(other.eventId, eventId) || other.eventId == eventId)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.buyer, buyer) || other.buyer == buyer)&&(identical(other.status, status) || other.status == status)&&(identical(other.session, session) || other.session == session)&&const DeepCollectionEquality().equals(other.tickets, tickets)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,const DeepCollectionEquality().hash(items),buyer,status,session,const DeepCollectionEquality().hash(tickets),error);

@override
String toString() {
  return 'CheckoutState(eventId: $eventId, items: $items, buyer: $buyer, status: $status, session: $session, tickets: $tickets, error: $error)';
}


}

/// @nodoc
abstract mixin class $CheckoutStateCopyWith<$Res>  {
  factory $CheckoutStateCopyWith(CheckoutState value, $Res Function(CheckoutState) _then) = _$CheckoutStateCopyWithImpl;
@useResult
$Res call({
 String eventId, List<CartItem> items, BuyerDto? buyer, CheckoutStatus status, CheckoutSession? session, List<IssuedTicket> tickets, String? error
});




}
/// @nodoc
class _$CheckoutStateCopyWithImpl<$Res>
    implements $CheckoutStateCopyWith<$Res> {
  _$CheckoutStateCopyWithImpl(this._self, this._then);

  final CheckoutState _self;
  final $Res Function(CheckoutState) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? items = null,Object? buyer = freezed,Object? status = null,Object? session = freezed,Object? tickets = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CartItem>,buyer: freezed == buyer ? _self.buyer : buyer // ignore: cast_nullable_to_non_nullable
as BuyerDto?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CheckoutStatus,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as CheckoutSession?,tickets: null == tickets ? _self.tickets : tickets // ignore: cast_nullable_to_non_nullable
as List<IssuedTicket>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckoutState].
extension CheckoutStatePatterns on CheckoutState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckoutState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckoutState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckoutState value)  $default,){
final _that = this;
switch (_that) {
case _CheckoutState():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckoutState value)?  $default,){
final _that = this;
switch (_that) {
case _CheckoutState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  List<CartItem> items,  BuyerDto? buyer,  CheckoutStatus status,  CheckoutSession? session,  List<IssuedTicket> tickets,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckoutState() when $default != null:
return $default(_that.eventId,_that.items,_that.buyer,_that.status,_that.session,_that.tickets,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  List<CartItem> items,  BuyerDto? buyer,  CheckoutStatus status,  CheckoutSession? session,  List<IssuedTicket> tickets,  String? error)  $default,) {final _that = this;
switch (_that) {
case _CheckoutState():
return $default(_that.eventId,_that.items,_that.buyer,_that.status,_that.session,_that.tickets,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  List<CartItem> items,  BuyerDto? buyer,  CheckoutStatus status,  CheckoutSession? session,  List<IssuedTicket> tickets,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _CheckoutState() when $default != null:
return $default(_that.eventId,_that.items,_that.buyer,_that.status,_that.session,_that.tickets,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _CheckoutState extends CheckoutState {
  const _CheckoutState({this.eventId = '', final  List<CartItem> items = const <CartItem>[], this.buyer, this.status = CheckoutStatus.idle, this.session, final  List<IssuedTicket> tickets = const <IssuedTicket>[], this.error}): _items = items,_tickets = tickets,super._();
  

@override@JsonKey() final  String eventId;
 final  List<CartItem> _items;
@override@JsonKey() List<CartItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  BuyerDto? buyer;
@override@JsonKey() final  CheckoutStatus status;
@override final  CheckoutSession? session;
 final  List<IssuedTicket> _tickets;
@override@JsonKey() List<IssuedTicket> get tickets {
  if (_tickets is EqualUnmodifiableListView) return _tickets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tickets);
}

@override final  String? error;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutStateCopyWith<_CheckoutState> get copyWith => __$CheckoutStateCopyWithImpl<_CheckoutState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutState&&(identical(other.eventId, eventId) || other.eventId == eventId)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.buyer, buyer) || other.buyer == buyer)&&(identical(other.status, status) || other.status == status)&&(identical(other.session, session) || other.session == session)&&const DeepCollectionEquality().equals(other._tickets, _tickets)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,const DeepCollectionEquality().hash(_items),buyer,status,session,const DeepCollectionEquality().hash(_tickets),error);

@override
String toString() {
  return 'CheckoutState(eventId: $eventId, items: $items, buyer: $buyer, status: $status, session: $session, tickets: $tickets, error: $error)';
}


}

/// @nodoc
abstract mixin class _$CheckoutStateCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory _$CheckoutStateCopyWith(_CheckoutState value, $Res Function(_CheckoutState) _then) = __$CheckoutStateCopyWithImpl;
@override @useResult
$Res call({
 String eventId, List<CartItem> items, BuyerDto? buyer, CheckoutStatus status, CheckoutSession? session, List<IssuedTicket> tickets, String? error
});




}
/// @nodoc
class __$CheckoutStateCopyWithImpl<$Res>
    implements _$CheckoutStateCopyWith<$Res> {
  __$CheckoutStateCopyWithImpl(this._self, this._then);

  final _CheckoutState _self;
  final $Res Function(_CheckoutState) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? items = null,Object? buyer = freezed,Object? status = null,Object? session = freezed,Object? tickets = null,Object? error = freezed,}) {
  return _then(_CheckoutState(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CartItem>,buyer: freezed == buyer ? _self.buyer : buyer // ignore: cast_nullable_to_non_nullable
as BuyerDto?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CheckoutStatus,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as CheckoutSession?,tickets: null == tickets ? _self._tickets : tickets // ignore: cast_nullable_to_non_nullable
as List<IssuedTicket>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
