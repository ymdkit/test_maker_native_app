// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workbooks_state_key.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WorkbooksStateKey {
  AppDataLocation get location => throw _privateConstructorUsedError;
  String? get folderId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WorkbooksStateKeyCopyWith<WorkbooksStateKey> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkbooksStateKeyCopyWith<$Res> {
  factory $WorkbooksStateKeyCopyWith(
          WorkbooksStateKey value, $Res Function(WorkbooksStateKey) then) =
      _$WorkbooksStateKeyCopyWithImpl<$Res, WorkbooksStateKey>;
  @useResult
  $Res call({AppDataLocation location, String? folderId});
}

/// @nodoc
class _$WorkbooksStateKeyCopyWithImpl<$Res, $Val extends WorkbooksStateKey>
    implements $WorkbooksStateKeyCopyWith<$Res> {
  _$WorkbooksStateKeyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? folderId = freezed,
  }) {
    return _then(_value.copyWith(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as AppDataLocation,
      folderId: freezed == folderId
          ? _value.folderId
          : folderId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WorkbooksStateKeyCopyWith<$Res>
    implements $WorkbooksStateKeyCopyWith<$Res> {
  factory _$$_WorkbooksStateKeyCopyWith(_$_WorkbooksStateKey value,
          $Res Function(_$_WorkbooksStateKey) then) =
      __$$_WorkbooksStateKeyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AppDataLocation location, String? folderId});
}

/// @nodoc
class __$$_WorkbooksStateKeyCopyWithImpl<$Res>
    extends _$WorkbooksStateKeyCopyWithImpl<$Res, _$_WorkbooksStateKey>
    implements _$$_WorkbooksStateKeyCopyWith<$Res> {
  __$$_WorkbooksStateKeyCopyWithImpl(
      _$_WorkbooksStateKey _value, $Res Function(_$_WorkbooksStateKey) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? folderId = freezed,
  }) {
    return _then(_$_WorkbooksStateKey(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as AppDataLocation,
      folderId: freezed == folderId
          ? _value.folderId
          : folderId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_WorkbooksStateKey extends _WorkbooksStateKey {
  const _$_WorkbooksStateKey({required this.location, required this.folderId})
      : super._();

  @override
  final AppDataLocation location;
  @override
  final String? folderId;

  @override
  String toString() {
    return 'WorkbooksStateKey(location: $location, folderId: $folderId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WorkbooksStateKey &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.folderId, folderId) ||
                other.folderId == folderId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, location, folderId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WorkbooksStateKeyCopyWith<_$_WorkbooksStateKey> get copyWith =>
      __$$_WorkbooksStateKeyCopyWithImpl<_$_WorkbooksStateKey>(
          this, _$identity);
}

abstract class _WorkbooksStateKey extends WorkbooksStateKey {
  const factory _WorkbooksStateKey(
      {required final AppDataLocation location,
      required final String? folderId}) = _$_WorkbooksStateKey;
  const _WorkbooksStateKey._() : super._();

  @override
  AppDataLocation get location;
  @override
  String? get folderId;
  @override
  @JsonKey(ignore: true)
  _$$_WorkbooksStateKeyCopyWith<_$_WorkbooksStateKey> get copyWith =>
      throw _privateConstructorUsedError;
}
