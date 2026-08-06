// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfileModel {

 int get id; String get email; String get username; UserNameModel get name; String get phone; UserAddressModel get address;
/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileModelCopyWith<UserProfileModel> get copyWith => _$UserProfileModelCopyWithImpl<UserProfileModel>(this as UserProfileModel, _$identity);

  /// Serializes this UserProfileModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.username, username) || other.username == username)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,username,name,phone,address);

@override
String toString() {
  return 'UserProfileModel(id: $id, email: $email, username: $username, name: $name, phone: $phone, address: $address)';
}


}

/// @nodoc
abstract mixin class $UserProfileModelCopyWith<$Res>  {
  factory $UserProfileModelCopyWith(UserProfileModel value, $Res Function(UserProfileModel) _then) = _$UserProfileModelCopyWithImpl;
@useResult
$Res call({
 int id, String email, String username, UserNameModel name, String phone, UserAddressModel address
});


$UserNameModelCopyWith<$Res> get name;$UserAddressModelCopyWith<$Res> get address;

}
/// @nodoc
class _$UserProfileModelCopyWithImpl<$Res>
    implements $UserProfileModelCopyWith<$Res> {
  _$UserProfileModelCopyWithImpl(this._self, this._then);

  final UserProfileModel _self;
  final $Res Function(UserProfileModel) _then;

/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? username = null,Object? name = null,Object? phone = null,Object? address = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as UserNameModel,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as UserAddressModel,
  ));
}
/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserNameModelCopyWith<$Res> get name {
  
  return $UserNameModelCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserAddressModelCopyWith<$Res> get address {
  
  return $UserAddressModelCopyWith<$Res>(_self.address, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserProfileModel].
extension UserProfileModelPatterns on UserProfileModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfileModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfileModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfileModel value)  $default,){
final _that = this;
switch (_that) {
case _UserProfileModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfileModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfileModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String email,  String username,  UserNameModel name,  String phone,  UserAddressModel address)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfileModel() when $default != null:
return $default(_that.id,_that.email,_that.username,_that.name,_that.phone,_that.address);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String email,  String username,  UserNameModel name,  String phone,  UserAddressModel address)  $default,) {final _that = this;
switch (_that) {
case _UserProfileModel():
return $default(_that.id,_that.email,_that.username,_that.name,_that.phone,_that.address);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String email,  String username,  UserNameModel name,  String phone,  UserAddressModel address)?  $default,) {final _that = this;
switch (_that) {
case _UserProfileModel() when $default != null:
return $default(_that.id,_that.email,_that.username,_that.name,_that.phone,_that.address);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfileModel implements UserProfileModel {
  const _UserProfileModel({required this.id, required this.email, required this.username, required this.name, required this.phone, required this.address});
  factory _UserProfileModel.fromJson(Map<String, dynamic> json) => _$UserProfileModelFromJson(json);

@override final  int id;
@override final  String email;
@override final  String username;
@override final  UserNameModel name;
@override final  String phone;
@override final  UserAddressModel address;

/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileModelCopyWith<_UserProfileModel> get copyWith => __$UserProfileModelCopyWithImpl<_UserProfileModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.username, username) || other.username == username)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,username,name,phone,address);

@override
String toString() {
  return 'UserProfileModel(id: $id, email: $email, username: $username, name: $name, phone: $phone, address: $address)';
}


}

/// @nodoc
abstract mixin class _$UserProfileModelCopyWith<$Res> implements $UserProfileModelCopyWith<$Res> {
  factory _$UserProfileModelCopyWith(_UserProfileModel value, $Res Function(_UserProfileModel) _then) = __$UserProfileModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String email, String username, UserNameModel name, String phone, UserAddressModel address
});


@override $UserNameModelCopyWith<$Res> get name;@override $UserAddressModelCopyWith<$Res> get address;

}
/// @nodoc
class __$UserProfileModelCopyWithImpl<$Res>
    implements _$UserProfileModelCopyWith<$Res> {
  __$UserProfileModelCopyWithImpl(this._self, this._then);

  final _UserProfileModel _self;
  final $Res Function(_UserProfileModel) _then;

/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? username = null,Object? name = null,Object? phone = null,Object? address = null,}) {
  return _then(_UserProfileModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as UserNameModel,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as UserAddressModel,
  ));
}

/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserNameModelCopyWith<$Res> get name {
  
  return $UserNameModelCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserAddressModelCopyWith<$Res> get address {
  
  return $UserAddressModelCopyWith<$Res>(_self.address, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}


/// @nodoc
mixin _$UserNameModel {

 String get firstname; String get lastname;
/// Create a copy of UserNameModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserNameModelCopyWith<UserNameModel> get copyWith => _$UserNameModelCopyWithImpl<UserNameModel>(this as UserNameModel, _$identity);

  /// Serializes this UserNameModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserNameModel&&(identical(other.firstname, firstname) || other.firstname == firstname)&&(identical(other.lastname, lastname) || other.lastname == lastname));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstname,lastname);

@override
String toString() {
  return 'UserNameModel(firstname: $firstname, lastname: $lastname)';
}


}

/// @nodoc
abstract mixin class $UserNameModelCopyWith<$Res>  {
  factory $UserNameModelCopyWith(UserNameModel value, $Res Function(UserNameModel) _then) = _$UserNameModelCopyWithImpl;
@useResult
$Res call({
 String firstname, String lastname
});




}
/// @nodoc
class _$UserNameModelCopyWithImpl<$Res>
    implements $UserNameModelCopyWith<$Res> {
  _$UserNameModelCopyWithImpl(this._self, this._then);

  final UserNameModel _self;
  final $Res Function(UserNameModel) _then;

/// Create a copy of UserNameModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstname = null,Object? lastname = null,}) {
  return _then(_self.copyWith(
firstname: null == firstname ? _self.firstname : firstname // ignore: cast_nullable_to_non_nullable
as String,lastname: null == lastname ? _self.lastname : lastname // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserNameModel].
extension UserNameModelPatterns on UserNameModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserNameModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserNameModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserNameModel value)  $default,){
final _that = this;
switch (_that) {
case _UserNameModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserNameModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserNameModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String firstname,  String lastname)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserNameModel() when $default != null:
return $default(_that.firstname,_that.lastname);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String firstname,  String lastname)  $default,) {final _that = this;
switch (_that) {
case _UserNameModel():
return $default(_that.firstname,_that.lastname);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String firstname,  String lastname)?  $default,) {final _that = this;
switch (_that) {
case _UserNameModel() when $default != null:
return $default(_that.firstname,_that.lastname);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserNameModel implements UserNameModel {
  const _UserNameModel({required this.firstname, required this.lastname});
  factory _UserNameModel.fromJson(Map<String, dynamic> json) => _$UserNameModelFromJson(json);

@override final  String firstname;
@override final  String lastname;

/// Create a copy of UserNameModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserNameModelCopyWith<_UserNameModel> get copyWith => __$UserNameModelCopyWithImpl<_UserNameModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserNameModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserNameModel&&(identical(other.firstname, firstname) || other.firstname == firstname)&&(identical(other.lastname, lastname) || other.lastname == lastname));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstname,lastname);

@override
String toString() {
  return 'UserNameModel(firstname: $firstname, lastname: $lastname)';
}


}

/// @nodoc
abstract mixin class _$UserNameModelCopyWith<$Res> implements $UserNameModelCopyWith<$Res> {
  factory _$UserNameModelCopyWith(_UserNameModel value, $Res Function(_UserNameModel) _then) = __$UserNameModelCopyWithImpl;
@override @useResult
$Res call({
 String firstname, String lastname
});




}
/// @nodoc
class __$UserNameModelCopyWithImpl<$Res>
    implements _$UserNameModelCopyWith<$Res> {
  __$UserNameModelCopyWithImpl(this._self, this._then);

  final _UserNameModel _self;
  final $Res Function(_UserNameModel) _then;

/// Create a copy of UserNameModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstname = null,Object? lastname = null,}) {
  return _then(_UserNameModel(
firstname: null == firstname ? _self.firstname : firstname // ignore: cast_nullable_to_non_nullable
as String,lastname: null == lastname ? _self.lastname : lastname // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$UserAddressModel {

 String get city; String get street; int get number; String get zipcode; UserGeolocationModel get geolocation;
/// Create a copy of UserAddressModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserAddressModelCopyWith<UserAddressModel> get copyWith => _$UserAddressModelCopyWithImpl<UserAddressModel>(this as UserAddressModel, _$identity);

  /// Serializes this UserAddressModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserAddressModel&&(identical(other.city, city) || other.city == city)&&(identical(other.street, street) || other.street == street)&&(identical(other.number, number) || other.number == number)&&(identical(other.zipcode, zipcode) || other.zipcode == zipcode)&&(identical(other.geolocation, geolocation) || other.geolocation == geolocation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,city,street,number,zipcode,geolocation);

@override
String toString() {
  return 'UserAddressModel(city: $city, street: $street, number: $number, zipcode: $zipcode, geolocation: $geolocation)';
}


}

/// @nodoc
abstract mixin class $UserAddressModelCopyWith<$Res>  {
  factory $UserAddressModelCopyWith(UserAddressModel value, $Res Function(UserAddressModel) _then) = _$UserAddressModelCopyWithImpl;
@useResult
$Res call({
 String city, String street, int number, String zipcode, UserGeolocationModel geolocation
});


$UserGeolocationModelCopyWith<$Res> get geolocation;

}
/// @nodoc
class _$UserAddressModelCopyWithImpl<$Res>
    implements $UserAddressModelCopyWith<$Res> {
  _$UserAddressModelCopyWithImpl(this._self, this._then);

  final UserAddressModel _self;
  final $Res Function(UserAddressModel) _then;

/// Create a copy of UserAddressModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? city = null,Object? street = null,Object? number = null,Object? zipcode = null,Object? geolocation = null,}) {
  return _then(_self.copyWith(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,street: null == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,zipcode: null == zipcode ? _self.zipcode : zipcode // ignore: cast_nullable_to_non_nullable
as String,geolocation: null == geolocation ? _self.geolocation : geolocation // ignore: cast_nullable_to_non_nullable
as UserGeolocationModel,
  ));
}
/// Create a copy of UserAddressModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserGeolocationModelCopyWith<$Res> get geolocation {
  
  return $UserGeolocationModelCopyWith<$Res>(_self.geolocation, (value) {
    return _then(_self.copyWith(geolocation: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserAddressModel].
extension UserAddressModelPatterns on UserAddressModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserAddressModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserAddressModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserAddressModel value)  $default,){
final _that = this;
switch (_that) {
case _UserAddressModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserAddressModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserAddressModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String city,  String street,  int number,  String zipcode,  UserGeolocationModel geolocation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserAddressModel() when $default != null:
return $default(_that.city,_that.street,_that.number,_that.zipcode,_that.geolocation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String city,  String street,  int number,  String zipcode,  UserGeolocationModel geolocation)  $default,) {final _that = this;
switch (_that) {
case _UserAddressModel():
return $default(_that.city,_that.street,_that.number,_that.zipcode,_that.geolocation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String city,  String street,  int number,  String zipcode,  UserGeolocationModel geolocation)?  $default,) {final _that = this;
switch (_that) {
case _UserAddressModel() when $default != null:
return $default(_that.city,_that.street,_that.number,_that.zipcode,_that.geolocation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserAddressModel implements UserAddressModel {
  const _UserAddressModel({required this.city, required this.street, required this.number, required this.zipcode, required this.geolocation});
  factory _UserAddressModel.fromJson(Map<String, dynamic> json) => _$UserAddressModelFromJson(json);

@override final  String city;
@override final  String street;
@override final  int number;
@override final  String zipcode;
@override final  UserGeolocationModel geolocation;

/// Create a copy of UserAddressModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserAddressModelCopyWith<_UserAddressModel> get copyWith => __$UserAddressModelCopyWithImpl<_UserAddressModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserAddressModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserAddressModel&&(identical(other.city, city) || other.city == city)&&(identical(other.street, street) || other.street == street)&&(identical(other.number, number) || other.number == number)&&(identical(other.zipcode, zipcode) || other.zipcode == zipcode)&&(identical(other.geolocation, geolocation) || other.geolocation == geolocation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,city,street,number,zipcode,geolocation);

@override
String toString() {
  return 'UserAddressModel(city: $city, street: $street, number: $number, zipcode: $zipcode, geolocation: $geolocation)';
}


}

/// @nodoc
abstract mixin class _$UserAddressModelCopyWith<$Res> implements $UserAddressModelCopyWith<$Res> {
  factory _$UserAddressModelCopyWith(_UserAddressModel value, $Res Function(_UserAddressModel) _then) = __$UserAddressModelCopyWithImpl;
@override @useResult
$Res call({
 String city, String street, int number, String zipcode, UserGeolocationModel geolocation
});


@override $UserGeolocationModelCopyWith<$Res> get geolocation;

}
/// @nodoc
class __$UserAddressModelCopyWithImpl<$Res>
    implements _$UserAddressModelCopyWith<$Res> {
  __$UserAddressModelCopyWithImpl(this._self, this._then);

  final _UserAddressModel _self;
  final $Res Function(_UserAddressModel) _then;

/// Create a copy of UserAddressModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? city = null,Object? street = null,Object? number = null,Object? zipcode = null,Object? geolocation = null,}) {
  return _then(_UserAddressModel(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,street: null == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,zipcode: null == zipcode ? _self.zipcode : zipcode // ignore: cast_nullable_to_non_nullable
as String,geolocation: null == geolocation ? _self.geolocation : geolocation // ignore: cast_nullable_to_non_nullable
as UserGeolocationModel,
  ));
}

/// Create a copy of UserAddressModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserGeolocationModelCopyWith<$Res> get geolocation {
  
  return $UserGeolocationModelCopyWith<$Res>(_self.geolocation, (value) {
    return _then(_self.copyWith(geolocation: value));
  });
}
}


/// @nodoc
mixin _$UserGeolocationModel {

 String get lat; String get long;
/// Create a copy of UserGeolocationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserGeolocationModelCopyWith<UserGeolocationModel> get copyWith => _$UserGeolocationModelCopyWithImpl<UserGeolocationModel>(this as UserGeolocationModel, _$identity);

  /// Serializes this UserGeolocationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserGeolocationModel&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.long, long) || other.long == long));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lat,long);

@override
String toString() {
  return 'UserGeolocationModel(lat: $lat, long: $long)';
}


}

/// @nodoc
abstract mixin class $UserGeolocationModelCopyWith<$Res>  {
  factory $UserGeolocationModelCopyWith(UserGeolocationModel value, $Res Function(UserGeolocationModel) _then) = _$UserGeolocationModelCopyWithImpl;
@useResult
$Res call({
 String lat, String long
});




}
/// @nodoc
class _$UserGeolocationModelCopyWithImpl<$Res>
    implements $UserGeolocationModelCopyWith<$Res> {
  _$UserGeolocationModelCopyWithImpl(this._self, this._then);

  final UserGeolocationModel _self;
  final $Res Function(UserGeolocationModel) _then;

/// Create a copy of UserGeolocationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lat = null,Object? long = null,}) {
  return _then(_self.copyWith(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as String,long: null == long ? _self.long : long // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserGeolocationModel].
extension UserGeolocationModelPatterns on UserGeolocationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserGeolocationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserGeolocationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserGeolocationModel value)  $default,){
final _that = this;
switch (_that) {
case _UserGeolocationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserGeolocationModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserGeolocationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String lat,  String long)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserGeolocationModel() when $default != null:
return $default(_that.lat,_that.long);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String lat,  String long)  $default,) {final _that = this;
switch (_that) {
case _UserGeolocationModel():
return $default(_that.lat,_that.long);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String lat,  String long)?  $default,) {final _that = this;
switch (_that) {
case _UserGeolocationModel() when $default != null:
return $default(_that.lat,_that.long);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserGeolocationModel implements UserGeolocationModel {
  const _UserGeolocationModel({required this.lat, required this.long});
  factory _UserGeolocationModel.fromJson(Map<String, dynamic> json) => _$UserGeolocationModelFromJson(json);

@override final  String lat;
@override final  String long;

/// Create a copy of UserGeolocationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserGeolocationModelCopyWith<_UserGeolocationModel> get copyWith => __$UserGeolocationModelCopyWithImpl<_UserGeolocationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserGeolocationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserGeolocationModel&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.long, long) || other.long == long));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lat,long);

@override
String toString() {
  return 'UserGeolocationModel(lat: $lat, long: $long)';
}


}

/// @nodoc
abstract mixin class _$UserGeolocationModelCopyWith<$Res> implements $UserGeolocationModelCopyWith<$Res> {
  factory _$UserGeolocationModelCopyWith(_UserGeolocationModel value, $Res Function(_UserGeolocationModel) _then) = __$UserGeolocationModelCopyWithImpl;
@override @useResult
$Res call({
 String lat, String long
});




}
/// @nodoc
class __$UserGeolocationModelCopyWithImpl<$Res>
    implements _$UserGeolocationModelCopyWith<$Res> {
  __$UserGeolocationModelCopyWithImpl(this._self, this._then);

  final _UserGeolocationModel _self;
  final $Res Function(_UserGeolocationModel) _then;

/// Create a copy of UserGeolocationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lat = null,Object? long = null,}) {
  return _then(_UserGeolocationModel(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as String,long: null == long ? _self.long : long // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
