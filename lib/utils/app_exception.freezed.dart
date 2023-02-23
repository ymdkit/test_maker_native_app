// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppException {
  String get message => throw _privateConstructorUsedError;
  AppExceptionCode get code => throw _privateConstructorUsedError;
  Exception? get rawException => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppExceptionCopyWith<AppException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppExceptionCopyWith<$Res> {
  factory $AppExceptionCopyWith(
          AppException value, $Res Function(AppException) then) =
      _$AppExceptionCopyWithImpl<$Res, AppException>;
  @useResult
  $Res call({String message, AppExceptionCode code, Exception? rawException});
}

/// @nodoc
class _$AppExceptionCopyWithImpl<$Res, $Val extends AppException>
    implements $AppExceptionCopyWith<$Res> {
  _$AppExceptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? code = null,
    Object? rawException = freezed,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as AppExceptionCode,
      rawException: freezed == rawException
          ? _value.rawException
          : rawException // ignore: cast_nullable_to_non_nullable
              as Exception?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppExceptionCopyWith<$Res>
    implements $AppExceptionCopyWith<$Res> {
  factory _$$_AppExceptionCopyWith(
          _$_AppException value, $Res Function(_$_AppException) then) =
      __$$_AppExceptionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, AppExceptionCode code, Exception? rawException});
}

/// @nodoc
class __$$_AppExceptionCopyWithImpl<$Res>
    extends _$AppExceptionCopyWithImpl<$Res, _$_AppException>
    implements _$$_AppExceptionCopyWith<$Res> {
  __$$_AppExceptionCopyWithImpl(
      _$_AppException _value, $Res Function(_$_AppException) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? code = null,
    Object? rawException = freezed,
  }) {
    return _then(_$_AppException(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as AppExceptionCode,
      rawException: freezed == rawException
          ? _value.rawException
          : rawException // ignore: cast_nullable_to_non_nullable
              as Exception?,
    ));
  }
}

/// @nodoc

class _$_AppException extends _AppException {
  const _$_AppException(
      {this.message = 'システムエラーが発生しました。ご迷惑をおかけしますがしばらく時間を置いてから再度お試しください',
      this.code = AppExceptionCode.unknown,
      this.rawException})
      : super._();

  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final AppExceptionCode code;
  @override
  final Exception? rawException;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppException &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.rawException, rawException) ||
                other.rawException == rawException));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, code, rawException);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppExceptionCopyWith<_$_AppException> get copyWith =>
      __$$_AppExceptionCopyWithImpl<_$_AppException>(this, _$identity);
}

abstract class _AppException extends AppException {
  const factory _AppException(
      {final String message,
      final AppExceptionCode code,
      final Exception? rawException}) = _$_AppException;
  const _AppException._() : super._();

  @override
  String get message;
  @override
  AppExceptionCode get code;
  @override
  Exception? get rawException;
  @override
  @JsonKey(ignore: true)
  _$$_AppExceptionCopyWith<_$_AppException> get copyWith =>
      throw _privateConstructorUsedError;
}
