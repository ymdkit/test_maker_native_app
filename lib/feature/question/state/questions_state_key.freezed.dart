// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'questions_state_key.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$QuestionsStateKey {
  AppDataLocation get location => throw _privateConstructorUsedError;
  String get workbookId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QuestionsStateKeyCopyWith<QuestionsStateKey> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionsStateKeyCopyWith<$Res> {
  factory $QuestionsStateKeyCopyWith(
          QuestionsStateKey value, $Res Function(QuestionsStateKey) then) =
      _$QuestionsStateKeyCopyWithImpl<$Res, QuestionsStateKey>;
  @useResult
  $Res call({AppDataLocation location, String workbookId});
}

/// @nodoc
class _$QuestionsStateKeyCopyWithImpl<$Res, $Val extends QuestionsStateKey>
    implements $QuestionsStateKeyCopyWith<$Res> {
  _$QuestionsStateKeyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? workbookId = null,
  }) {
    return _then(_value.copyWith(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as AppDataLocation,
      workbookId: null == workbookId
          ? _value.workbookId
          : workbookId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_QuestionsStateKeyCopyWith<$Res>
    implements $QuestionsStateKeyCopyWith<$Res> {
  factory _$$_QuestionsStateKeyCopyWith(_$_QuestionsStateKey value,
          $Res Function(_$_QuestionsStateKey) then) =
      __$$_QuestionsStateKeyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AppDataLocation location, String workbookId});
}

/// @nodoc
class __$$_QuestionsStateKeyCopyWithImpl<$Res>
    extends _$QuestionsStateKeyCopyWithImpl<$Res, _$_QuestionsStateKey>
    implements _$$_QuestionsStateKeyCopyWith<$Res> {
  __$$_QuestionsStateKeyCopyWithImpl(
      _$_QuestionsStateKey _value, $Res Function(_$_QuestionsStateKey) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? workbookId = null,
  }) {
    return _then(_$_QuestionsStateKey(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as AppDataLocation,
      workbookId: null == workbookId
          ? _value.workbookId
          : workbookId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_QuestionsStateKey extends _QuestionsStateKey {
  const _$_QuestionsStateKey({required this.location, required this.workbookId})
      : super._();

  @override
  final AppDataLocation location;
  @override
  final String workbookId;

  @override
  String toString() {
    return 'QuestionsStateKey(location: $location, workbookId: $workbookId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QuestionsStateKey &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.workbookId, workbookId) ||
                other.workbookId == workbookId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, location, workbookId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QuestionsStateKeyCopyWith<_$_QuestionsStateKey> get copyWith =>
      __$$_QuestionsStateKeyCopyWithImpl<_$_QuestionsStateKey>(
          this, _$identity);
}

abstract class _QuestionsStateKey extends QuestionsStateKey {
  const factory _QuestionsStateKey(
      {required final AppDataLocation location,
      required final String workbookId}) = _$_QuestionsStateKey;
  const _QuestionsStateKey._() : super._();

  @override
  AppDataLocation get location;
  @override
  String get workbookId;
  @override
  @JsonKey(ignore: true)
  _$$_QuestionsStateKeyCopyWith<_$_QuestionsStateKey> get copyWith =>
      throw _privateConstructorUsedError;
}
