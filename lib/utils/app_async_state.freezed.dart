// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_async_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppAsyncState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(T value) success,
    required TResult Function(AppException exception) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(T value)? success,
    TResult? Function(AppException exception)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(T value)? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppAsyncState_Loading<T> value) loading,
    required TResult Function(AppAsyncState_Success<T> value) success,
    required TResult Function(AppAsyncState_Failure<T> value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppAsyncState_Loading<T> value)? loading,
    TResult? Function(AppAsyncState_Success<T> value)? success,
    TResult? Function(AppAsyncState_Failure<T> value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppAsyncState_Loading<T> value)? loading,
    TResult Function(AppAsyncState_Success<T> value)? success,
    TResult Function(AppAsyncState_Failure<T> value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppAsyncStateCopyWith<T, $Res> {
  factory $AppAsyncStateCopyWith(
          AppAsyncState<T> value, $Res Function(AppAsyncState<T>) then) =
      _$AppAsyncStateCopyWithImpl<T, $Res, AppAsyncState<T>>;
}

/// @nodoc
class _$AppAsyncStateCopyWithImpl<T, $Res, $Val extends AppAsyncState<T>>
    implements $AppAsyncStateCopyWith<T, $Res> {
  _$AppAsyncStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AppAsyncState_LoadingCopyWith<T, $Res> {
  factory _$$AppAsyncState_LoadingCopyWith(_$AppAsyncState_Loading<T> value,
          $Res Function(_$AppAsyncState_Loading<T>) then) =
      __$$AppAsyncState_LoadingCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$AppAsyncState_LoadingCopyWithImpl<T, $Res>
    extends _$AppAsyncStateCopyWithImpl<T, $Res, _$AppAsyncState_Loading<T>>
    implements _$$AppAsyncState_LoadingCopyWith<T, $Res> {
  __$$AppAsyncState_LoadingCopyWithImpl(_$AppAsyncState_Loading<T> _value,
      $Res Function(_$AppAsyncState_Loading<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AppAsyncState_Loading<T> implements AppAsyncState_Loading<T> {
  const _$AppAsyncState_Loading();

  @override
  String toString() {
    return 'AppAsyncState<$T>.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppAsyncState_Loading<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(T value) success,
    required TResult Function(AppException exception) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(T value)? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(T value)? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppAsyncState_Loading<T> value) loading,
    required TResult Function(AppAsyncState_Success<T> value) success,
    required TResult Function(AppAsyncState_Failure<T> value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppAsyncState_Loading<T> value)? loading,
    TResult? Function(AppAsyncState_Success<T> value)? success,
    TResult? Function(AppAsyncState_Failure<T> value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppAsyncState_Loading<T> value)? loading,
    TResult Function(AppAsyncState_Success<T> value)? success,
    TResult Function(AppAsyncState_Failure<T> value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AppAsyncState_Loading<T> implements AppAsyncState<T> {
  const factory AppAsyncState_Loading() = _$AppAsyncState_Loading<T>;
}

/// @nodoc
abstract class _$$AppAsyncState_SuccessCopyWith<T, $Res> {
  factory _$$AppAsyncState_SuccessCopyWith(_$AppAsyncState_Success<T> value,
          $Res Function(_$AppAsyncState_Success<T>) then) =
      __$$AppAsyncState_SuccessCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T value});
}

/// @nodoc
class __$$AppAsyncState_SuccessCopyWithImpl<T, $Res>
    extends _$AppAsyncStateCopyWithImpl<T, $Res, _$AppAsyncState_Success<T>>
    implements _$$AppAsyncState_SuccessCopyWith<T, $Res> {
  __$$AppAsyncState_SuccessCopyWithImpl(_$AppAsyncState_Success<T> _value,
      $Res Function(_$AppAsyncState_Success<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_$AppAsyncState_Success<T>(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$AppAsyncState_Success<T> implements AppAsyncState_Success<T> {
  const _$AppAsyncState_Success({required this.value});

  @override
  final T value;

  @override
  String toString() {
    return 'AppAsyncState<$T>.success(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppAsyncState_Success<T> &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppAsyncState_SuccessCopyWith<T, _$AppAsyncState_Success<T>>
      get copyWith =>
          __$$AppAsyncState_SuccessCopyWithImpl<T, _$AppAsyncState_Success<T>>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(T value) success,
    required TResult Function(AppException exception) failure,
  }) {
    return success(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(T value)? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return success?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(T value)? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppAsyncState_Loading<T> value) loading,
    required TResult Function(AppAsyncState_Success<T> value) success,
    required TResult Function(AppAsyncState_Failure<T> value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppAsyncState_Loading<T> value)? loading,
    TResult? Function(AppAsyncState_Success<T> value)? success,
    TResult? Function(AppAsyncState_Failure<T> value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppAsyncState_Loading<T> value)? loading,
    TResult Function(AppAsyncState_Success<T> value)? success,
    TResult Function(AppAsyncState_Failure<T> value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class AppAsyncState_Success<T> implements AppAsyncState<T> {
  const factory AppAsyncState_Success({required final T value}) =
      _$AppAsyncState_Success<T>;

  T get value;
  @JsonKey(ignore: true)
  _$$AppAsyncState_SuccessCopyWith<T, _$AppAsyncState_Success<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AppAsyncState_FailureCopyWith<T, $Res> {
  factory _$$AppAsyncState_FailureCopyWith(_$AppAsyncState_Failure<T> value,
          $Res Function(_$AppAsyncState_Failure<T>) then) =
      __$$AppAsyncState_FailureCopyWithImpl<T, $Res>;
  @useResult
  $Res call({AppException exception});

  $AppExceptionCopyWith<$Res> get exception;
}

/// @nodoc
class __$$AppAsyncState_FailureCopyWithImpl<T, $Res>
    extends _$AppAsyncStateCopyWithImpl<T, $Res, _$AppAsyncState_Failure<T>>
    implements _$$AppAsyncState_FailureCopyWith<T, $Res> {
  __$$AppAsyncState_FailureCopyWithImpl(_$AppAsyncState_Failure<T> _value,
      $Res Function(_$AppAsyncState_Failure<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$AppAsyncState_Failure<T>(
      exception: null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $AppExceptionCopyWith<$Res> get exception {
    return $AppExceptionCopyWith<$Res>(_value.exception, (value) {
      return _then(_value.copyWith(exception: value));
    });
  }
}

/// @nodoc

class _$AppAsyncState_Failure<T> implements AppAsyncState_Failure<T> {
  const _$AppAsyncState_Failure({required this.exception});

  @override
  final AppException exception;

  @override
  String toString() {
    return 'AppAsyncState<$T>.failure(exception: $exception)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppAsyncState_Failure<T> &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppAsyncState_FailureCopyWith<T, _$AppAsyncState_Failure<T>>
      get copyWith =>
          __$$AppAsyncState_FailureCopyWithImpl<T, _$AppAsyncState_Failure<T>>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(T value) success,
    required TResult Function(AppException exception) failure,
  }) {
    return failure(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(T value)? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return failure?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(T value)? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(exception);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppAsyncState_Loading<T> value) loading,
    required TResult Function(AppAsyncState_Success<T> value) success,
    required TResult Function(AppAsyncState_Failure<T> value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppAsyncState_Loading<T> value)? loading,
    TResult? Function(AppAsyncState_Success<T> value)? success,
    TResult? Function(AppAsyncState_Failure<T> value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppAsyncState_Loading<T> value)? loading,
    TResult Function(AppAsyncState_Success<T> value)? success,
    TResult Function(AppAsyncState_Failure<T> value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class AppAsyncState_Failure<T> implements AppAsyncState<T> {
  const factory AppAsyncState_Failure({required final AppException exception}) =
      _$AppAsyncState_Failure<T>;

  AppException get exception;
  @JsonKey(ignore: true)
  _$$AppAsyncState_FailureCopyWith<T, _$AppAsyncState_Failure<T>>
      get copyWith => throw _privateConstructorUsedError;
}
