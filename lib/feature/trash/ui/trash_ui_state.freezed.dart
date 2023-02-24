// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trash_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TrashUiState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(List<Folder> folders, List<Workbook> workbooks,
            List<Question> questions)
        success,
    required TResult Function(AppException exception) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(List<Folder> folders, List<Workbook> workbooks,
            List<Question> questions)?
        success,
    TResult? Function(AppException exception)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(List<Folder> folders, List<Workbook> workbooks,
            List<Question> questions)?
        success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TrashUiState_Loading value) loading,
    required TResult Function(TrashUiState_Empty value) empty,
    required TResult Function(TrashUiState_Success value) success,
    required TResult Function(TrashUiState_Failure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TrashUiState_Loading value)? loading,
    TResult? Function(TrashUiState_Empty value)? empty,
    TResult? Function(TrashUiState_Success value)? success,
    TResult? Function(TrashUiState_Failure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TrashUiState_Loading value)? loading,
    TResult Function(TrashUiState_Empty value)? empty,
    TResult Function(TrashUiState_Success value)? success,
    TResult Function(TrashUiState_Failure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrashUiStateCopyWith<$Res> {
  factory $TrashUiStateCopyWith(
          TrashUiState value, $Res Function(TrashUiState) then) =
      _$TrashUiStateCopyWithImpl<$Res, TrashUiState>;
}

/// @nodoc
class _$TrashUiStateCopyWithImpl<$Res, $Val extends TrashUiState>
    implements $TrashUiStateCopyWith<$Res> {
  _$TrashUiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$TrashUiState_LoadingCopyWith<$Res> {
  factory _$$TrashUiState_LoadingCopyWith(_$TrashUiState_Loading value,
          $Res Function(_$TrashUiState_Loading) then) =
      __$$TrashUiState_LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TrashUiState_LoadingCopyWithImpl<$Res>
    extends _$TrashUiStateCopyWithImpl<$Res, _$TrashUiState_Loading>
    implements _$$TrashUiState_LoadingCopyWith<$Res> {
  __$$TrashUiState_LoadingCopyWithImpl(_$TrashUiState_Loading _value,
      $Res Function(_$TrashUiState_Loading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TrashUiState_Loading implements TrashUiState_Loading {
  const _$TrashUiState_Loading();

  @override
  String toString() {
    return 'TrashUiState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TrashUiState_Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(List<Folder> folders, List<Workbook> workbooks,
            List<Question> questions)
        success,
    required TResult Function(AppException exception) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(List<Folder> folders, List<Workbook> workbooks,
            List<Question> questions)?
        success,
    TResult? Function(AppException exception)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(List<Folder> folders, List<Workbook> workbooks,
            List<Question> questions)?
        success,
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
    required TResult Function(TrashUiState_Loading value) loading,
    required TResult Function(TrashUiState_Empty value) empty,
    required TResult Function(TrashUiState_Success value) success,
    required TResult Function(TrashUiState_Failure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TrashUiState_Loading value)? loading,
    TResult? Function(TrashUiState_Empty value)? empty,
    TResult? Function(TrashUiState_Success value)? success,
    TResult? Function(TrashUiState_Failure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TrashUiState_Loading value)? loading,
    TResult Function(TrashUiState_Empty value)? empty,
    TResult Function(TrashUiState_Success value)? success,
    TResult Function(TrashUiState_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class TrashUiState_Loading implements TrashUiState {
  const factory TrashUiState_Loading() = _$TrashUiState_Loading;
}

/// @nodoc
abstract class _$$TrashUiState_EmptyCopyWith<$Res> {
  factory _$$TrashUiState_EmptyCopyWith(_$TrashUiState_Empty value,
          $Res Function(_$TrashUiState_Empty) then) =
      __$$TrashUiState_EmptyCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TrashUiState_EmptyCopyWithImpl<$Res>
    extends _$TrashUiStateCopyWithImpl<$Res, _$TrashUiState_Empty>
    implements _$$TrashUiState_EmptyCopyWith<$Res> {
  __$$TrashUiState_EmptyCopyWithImpl(
      _$TrashUiState_Empty _value, $Res Function(_$TrashUiState_Empty) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TrashUiState_Empty implements TrashUiState_Empty {
  const _$TrashUiState_Empty();

  @override
  String toString() {
    return 'TrashUiState.empty()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TrashUiState_Empty);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(List<Folder> folders, List<Workbook> workbooks,
            List<Question> questions)
        success,
    required TResult Function(AppException exception) failure,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(List<Folder> folders, List<Workbook> workbooks,
            List<Question> questions)?
        success,
    TResult? Function(AppException exception)? failure,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(List<Folder> folders, List<Workbook> workbooks,
            List<Question> questions)?
        success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TrashUiState_Loading value) loading,
    required TResult Function(TrashUiState_Empty value) empty,
    required TResult Function(TrashUiState_Success value) success,
    required TResult Function(TrashUiState_Failure value) failure,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TrashUiState_Loading value)? loading,
    TResult? Function(TrashUiState_Empty value)? empty,
    TResult? Function(TrashUiState_Success value)? success,
    TResult? Function(TrashUiState_Failure value)? failure,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TrashUiState_Loading value)? loading,
    TResult Function(TrashUiState_Empty value)? empty,
    TResult Function(TrashUiState_Success value)? success,
    TResult Function(TrashUiState_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class TrashUiState_Empty implements TrashUiState {
  const factory TrashUiState_Empty() = _$TrashUiState_Empty;
}

/// @nodoc
abstract class _$$TrashUiState_SuccessCopyWith<$Res> {
  factory _$$TrashUiState_SuccessCopyWith(_$TrashUiState_Success value,
          $Res Function(_$TrashUiState_Success) then) =
      __$$TrashUiState_SuccessCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<Folder> folders,
      List<Workbook> workbooks,
      List<Question> questions});
}

/// @nodoc
class __$$TrashUiState_SuccessCopyWithImpl<$Res>
    extends _$TrashUiStateCopyWithImpl<$Res, _$TrashUiState_Success>
    implements _$$TrashUiState_SuccessCopyWith<$Res> {
  __$$TrashUiState_SuccessCopyWithImpl(_$TrashUiState_Success _value,
      $Res Function(_$TrashUiState_Success) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? folders = null,
    Object? workbooks = null,
    Object? questions = null,
  }) {
    return _then(_$TrashUiState_Success(
      folders: null == folders
          ? _value._folders
          : folders // ignore: cast_nullable_to_non_nullable
              as List<Folder>,
      workbooks: null == workbooks
          ? _value._workbooks
          : workbooks // ignore: cast_nullable_to_non_nullable
              as List<Workbook>,
      questions: null == questions
          ? _value._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Question>,
    ));
  }
}

/// @nodoc

class _$TrashUiState_Success implements TrashUiState_Success {
  const _$TrashUiState_Success(
      {required final List<Folder> folders,
      required final List<Workbook> workbooks,
      required final List<Question> questions})
      : _folders = folders,
        _workbooks = workbooks,
        _questions = questions;

  final List<Folder> _folders;
  @override
  List<Folder> get folders {
    if (_folders is EqualUnmodifiableListView) return _folders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_folders);
  }

  final List<Workbook> _workbooks;
  @override
  List<Workbook> get workbooks {
    if (_workbooks is EqualUnmodifiableListView) return _workbooks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workbooks);
  }

  final List<Question> _questions;
  @override
  List<Question> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @override
  String toString() {
    return 'TrashUiState.success(folders: $folders, workbooks: $workbooks, questions: $questions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrashUiState_Success &&
            const DeepCollectionEquality().equals(other._folders, _folders) &&
            const DeepCollectionEquality()
                .equals(other._workbooks, _workbooks) &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_folders),
      const DeepCollectionEquality().hash(_workbooks),
      const DeepCollectionEquality().hash(_questions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrashUiState_SuccessCopyWith<_$TrashUiState_Success> get copyWith =>
      __$$TrashUiState_SuccessCopyWithImpl<_$TrashUiState_Success>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(List<Folder> folders, List<Workbook> workbooks,
            List<Question> questions)
        success,
    required TResult Function(AppException exception) failure,
  }) {
    return success(folders, workbooks, questions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(List<Folder> folders, List<Workbook> workbooks,
            List<Question> questions)?
        success,
    TResult? Function(AppException exception)? failure,
  }) {
    return success?.call(folders, workbooks, questions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(List<Folder> folders, List<Workbook> workbooks,
            List<Question> questions)?
        success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(folders, workbooks, questions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TrashUiState_Loading value) loading,
    required TResult Function(TrashUiState_Empty value) empty,
    required TResult Function(TrashUiState_Success value) success,
    required TResult Function(TrashUiState_Failure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TrashUiState_Loading value)? loading,
    TResult? Function(TrashUiState_Empty value)? empty,
    TResult? Function(TrashUiState_Success value)? success,
    TResult? Function(TrashUiState_Failure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TrashUiState_Loading value)? loading,
    TResult Function(TrashUiState_Empty value)? empty,
    TResult Function(TrashUiState_Success value)? success,
    TResult Function(TrashUiState_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class TrashUiState_Success implements TrashUiState {
  const factory TrashUiState_Success(
      {required final List<Folder> folders,
      required final List<Workbook> workbooks,
      required final List<Question> questions}) = _$TrashUiState_Success;

  List<Folder> get folders;
  List<Workbook> get workbooks;
  List<Question> get questions;
  @JsonKey(ignore: true)
  _$$TrashUiState_SuccessCopyWith<_$TrashUiState_Success> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TrashUiState_FailureCopyWith<$Res> {
  factory _$$TrashUiState_FailureCopyWith(_$TrashUiState_Failure value,
          $Res Function(_$TrashUiState_Failure) then) =
      __$$TrashUiState_FailureCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException exception});

  $AppExceptionCopyWith<$Res> get exception;
}

/// @nodoc
class __$$TrashUiState_FailureCopyWithImpl<$Res>
    extends _$TrashUiStateCopyWithImpl<$Res, _$TrashUiState_Failure>
    implements _$$TrashUiState_FailureCopyWith<$Res> {
  __$$TrashUiState_FailureCopyWithImpl(_$TrashUiState_Failure _value,
      $Res Function(_$TrashUiState_Failure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$TrashUiState_Failure(
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

class _$TrashUiState_Failure implements TrashUiState_Failure {
  const _$TrashUiState_Failure({required this.exception});

  @override
  final AppException exception;

  @override
  String toString() {
    return 'TrashUiState.failure(exception: $exception)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrashUiState_Failure &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrashUiState_FailureCopyWith<_$TrashUiState_Failure> get copyWith =>
      __$$TrashUiState_FailureCopyWithImpl<_$TrashUiState_Failure>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(List<Folder> folders, List<Workbook> workbooks,
            List<Question> questions)
        success,
    required TResult Function(AppException exception) failure,
  }) {
    return failure(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(List<Folder> folders, List<Workbook> workbooks,
            List<Question> questions)?
        success,
    TResult? Function(AppException exception)? failure,
  }) {
    return failure?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(List<Folder> folders, List<Workbook> workbooks,
            List<Question> questions)?
        success,
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
    required TResult Function(TrashUiState_Loading value) loading,
    required TResult Function(TrashUiState_Empty value) empty,
    required TResult Function(TrashUiState_Success value) success,
    required TResult Function(TrashUiState_Failure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TrashUiState_Loading value)? loading,
    TResult? Function(TrashUiState_Empty value)? empty,
    TResult? Function(TrashUiState_Success value)? success,
    TResult? Function(TrashUiState_Failure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TrashUiState_Loading value)? loading,
    TResult Function(TrashUiState_Empty value)? empty,
    TResult Function(TrashUiState_Success value)? success,
    TResult Function(TrashUiState_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class TrashUiState_Failure implements TrashUiState {
  const factory TrashUiState_Failure({required final AppException exception}) =
      _$TrashUiState_Failure;

  AppException get exception;
  @JsonKey(ignore: true)
  _$$TrashUiState_FailureCopyWith<_$TrashUiState_Failure> get copyWith =>
      throw _privateConstructorUsedError;
}
