// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workbooks_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WorkbooksState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Workbook> workbooks) success,
    required TResult Function(AppException exception) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Workbook> workbooks)? success,
    TResult? Function(AppException exception)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Workbook> workbooks)? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WorkbooksState_Loading value) loading,
    required TResult Function(WorkbooksState_Success value) success,
    required TResult Function(WorkbooksState_Failure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WorkbooksState_Loading value)? loading,
    TResult? Function(WorkbooksState_Success value)? success,
    TResult? Function(WorkbooksState_Failure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WorkbooksState_Loading value)? loading,
    TResult Function(WorkbooksState_Success value)? success,
    TResult Function(WorkbooksState_Failure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkbooksStateCopyWith<$Res> {
  factory $WorkbooksStateCopyWith(
          WorkbooksState value, $Res Function(WorkbooksState) then) =
      _$WorkbooksStateCopyWithImpl<$Res, WorkbooksState>;
}

/// @nodoc
class _$WorkbooksStateCopyWithImpl<$Res, $Val extends WorkbooksState>
    implements $WorkbooksStateCopyWith<$Res> {
  _$WorkbooksStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$WorkbooksState_LoadingCopyWith<$Res> {
  factory _$$WorkbooksState_LoadingCopyWith(_$WorkbooksState_Loading value,
          $Res Function(_$WorkbooksState_Loading) then) =
      __$$WorkbooksState_LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WorkbooksState_LoadingCopyWithImpl<$Res>
    extends _$WorkbooksStateCopyWithImpl<$Res, _$WorkbooksState_Loading>
    implements _$$WorkbooksState_LoadingCopyWith<$Res> {
  __$$WorkbooksState_LoadingCopyWithImpl(_$WorkbooksState_Loading _value,
      $Res Function(_$WorkbooksState_Loading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$WorkbooksState_Loading implements WorkbooksState_Loading {
  const _$WorkbooksState_Loading();

  @override
  String toString() {
    return 'WorkbooksState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WorkbooksState_Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Workbook> workbooks) success,
    required TResult Function(AppException exception) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Workbook> workbooks)? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Workbook> workbooks)? success,
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
    required TResult Function(WorkbooksState_Loading value) loading,
    required TResult Function(WorkbooksState_Success value) success,
    required TResult Function(WorkbooksState_Failure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WorkbooksState_Loading value)? loading,
    TResult? Function(WorkbooksState_Success value)? success,
    TResult? Function(WorkbooksState_Failure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WorkbooksState_Loading value)? loading,
    TResult Function(WorkbooksState_Success value)? success,
    TResult Function(WorkbooksState_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class WorkbooksState_Loading implements WorkbooksState {
  const factory WorkbooksState_Loading() = _$WorkbooksState_Loading;
}

/// @nodoc
abstract class _$$WorkbooksState_SuccessCopyWith<$Res> {
  factory _$$WorkbooksState_SuccessCopyWith(_$WorkbooksState_Success value,
          $Res Function(_$WorkbooksState_Success) then) =
      __$$WorkbooksState_SuccessCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Workbook> workbooks});
}

/// @nodoc
class __$$WorkbooksState_SuccessCopyWithImpl<$Res>
    extends _$WorkbooksStateCopyWithImpl<$Res, _$WorkbooksState_Success>
    implements _$$WorkbooksState_SuccessCopyWith<$Res> {
  __$$WorkbooksState_SuccessCopyWithImpl(_$WorkbooksState_Success _value,
      $Res Function(_$WorkbooksState_Success) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workbooks = null,
  }) {
    return _then(_$WorkbooksState_Success(
      workbooks: null == workbooks
          ? _value._workbooks
          : workbooks // ignore: cast_nullable_to_non_nullable
              as List<Workbook>,
    ));
  }
}

/// @nodoc

class _$WorkbooksState_Success implements WorkbooksState_Success {
  const _$WorkbooksState_Success({required final List<Workbook> workbooks})
      : _workbooks = workbooks;

  final List<Workbook> _workbooks;
  @override
  List<Workbook> get workbooks {
    if (_workbooks is EqualUnmodifiableListView) return _workbooks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workbooks);
  }

  @override
  String toString() {
    return 'WorkbooksState.success(workbooks: $workbooks)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkbooksState_Success &&
            const DeepCollectionEquality()
                .equals(other._workbooks, _workbooks));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_workbooks));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkbooksState_SuccessCopyWith<_$WorkbooksState_Success> get copyWith =>
      __$$WorkbooksState_SuccessCopyWithImpl<_$WorkbooksState_Success>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Workbook> workbooks) success,
    required TResult Function(AppException exception) failure,
  }) {
    return success(workbooks);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Workbook> workbooks)? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return success?.call(workbooks);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Workbook> workbooks)? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(workbooks);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WorkbooksState_Loading value) loading,
    required TResult Function(WorkbooksState_Success value) success,
    required TResult Function(WorkbooksState_Failure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WorkbooksState_Loading value)? loading,
    TResult? Function(WorkbooksState_Success value)? success,
    TResult? Function(WorkbooksState_Failure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WorkbooksState_Loading value)? loading,
    TResult Function(WorkbooksState_Success value)? success,
    TResult Function(WorkbooksState_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class WorkbooksState_Success implements WorkbooksState {
  const factory WorkbooksState_Success(
      {required final List<Workbook> workbooks}) = _$WorkbooksState_Success;

  List<Workbook> get workbooks;
  @JsonKey(ignore: true)
  _$$WorkbooksState_SuccessCopyWith<_$WorkbooksState_Success> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WorkbooksState_FailureCopyWith<$Res> {
  factory _$$WorkbooksState_FailureCopyWith(_$WorkbooksState_Failure value,
          $Res Function(_$WorkbooksState_Failure) then) =
      __$$WorkbooksState_FailureCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException exception});

  $AppExceptionCopyWith<$Res> get exception;
}

/// @nodoc
class __$$WorkbooksState_FailureCopyWithImpl<$Res>
    extends _$WorkbooksStateCopyWithImpl<$Res, _$WorkbooksState_Failure>
    implements _$$WorkbooksState_FailureCopyWith<$Res> {
  __$$WorkbooksState_FailureCopyWithImpl(_$WorkbooksState_Failure _value,
      $Res Function(_$WorkbooksState_Failure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$WorkbooksState_Failure(
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

class _$WorkbooksState_Failure implements WorkbooksState_Failure {
  const _$WorkbooksState_Failure({required this.exception});

  @override
  final AppException exception;

  @override
  String toString() {
    return 'WorkbooksState.failure(exception: $exception)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkbooksState_Failure &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkbooksState_FailureCopyWith<_$WorkbooksState_Failure> get copyWith =>
      __$$WorkbooksState_FailureCopyWithImpl<_$WorkbooksState_Failure>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Workbook> workbooks) success,
    required TResult Function(AppException exception) failure,
  }) {
    return failure(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Workbook> workbooks)? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return failure?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Workbook> workbooks)? success,
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
    required TResult Function(WorkbooksState_Loading value) loading,
    required TResult Function(WorkbooksState_Success value) success,
    required TResult Function(WorkbooksState_Failure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WorkbooksState_Loading value)? loading,
    TResult? Function(WorkbooksState_Success value)? success,
    TResult? Function(WorkbooksState_Failure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WorkbooksState_Loading value)? loading,
    TResult Function(WorkbooksState_Success value)? success,
    TResult Function(WorkbooksState_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class WorkbooksState_Failure implements WorkbooksState {
  const factory WorkbooksState_Failure(
      {required final AppException exception}) = _$WorkbooksState_Failure;

  AppException get exception;
  @JsonKey(ignore: true)
  _$$WorkbooksState_FailureCopyWith<_$WorkbooksState_Failure> get copyWith =>
      throw _privateConstructorUsedError;
}
