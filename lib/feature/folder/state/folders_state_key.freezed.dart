// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'folders_state_key.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FoldersStateKey {
  AppDataLocation get location => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FoldersStateKeyCopyWith<FoldersStateKey> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoldersStateKeyCopyWith<$Res> {
  factory $FoldersStateKeyCopyWith(
          FoldersStateKey value, $Res Function(FoldersStateKey) then) =
      _$FoldersStateKeyCopyWithImpl<$Res, FoldersStateKey>;
  @useResult
  $Res call({AppDataLocation location});
}

/// @nodoc
class _$FoldersStateKeyCopyWithImpl<$Res, $Val extends FoldersStateKey>
    implements $FoldersStateKeyCopyWith<$Res> {
  _$FoldersStateKeyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
  }) {
    return _then(_value.copyWith(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as AppDataLocation,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FoldersStateKeyCopyWith<$Res>
    implements $FoldersStateKeyCopyWith<$Res> {
  factory _$$_FoldersStateKeyCopyWith(
          _$_FoldersStateKey value, $Res Function(_$_FoldersStateKey) then) =
      __$$_FoldersStateKeyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AppDataLocation location});
}

/// @nodoc
class __$$_FoldersStateKeyCopyWithImpl<$Res>
    extends _$FoldersStateKeyCopyWithImpl<$Res, _$_FoldersStateKey>
    implements _$$_FoldersStateKeyCopyWith<$Res> {
  __$$_FoldersStateKeyCopyWithImpl(
      _$_FoldersStateKey _value, $Res Function(_$_FoldersStateKey) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
  }) {
    return _then(_$_FoldersStateKey(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as AppDataLocation,
    ));
  }
}

/// @nodoc

class _$_FoldersStateKey extends _FoldersStateKey {
  const _$_FoldersStateKey({required this.location}) : super._();

  @override
  final AppDataLocation location;

  @override
  String toString() {
    return 'FoldersStateKey(location: $location)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FoldersStateKey &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @override
  int get hashCode => Object.hash(runtimeType, location);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FoldersStateKeyCopyWith<_$_FoldersStateKey> get copyWith =>
      __$$_FoldersStateKeyCopyWithImpl<_$_FoldersStateKey>(this, _$identity);
}

abstract class _FoldersStateKey extends FoldersStateKey {
  const factory _FoldersStateKey({required final AppDataLocation location}) =
      _$_FoldersStateKey;
  const _FoldersStateKey._() : super._();

  @override
  AppDataLocation get location;
  @override
  @JsonKey(ignore: true)
  _$$_FoldersStateKeyCopyWith<_$_FoldersStateKey> get copyWith =>
      throw _privateConstructorUsedError;
}
