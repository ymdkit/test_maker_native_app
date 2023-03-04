// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'answer_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AnswerHistory {
  String get answerHistoryId => throw _privateConstructorUsedError;
  String get questionId => throw _privateConstructorUsedError;
  String get workbookId => throw _privateConstructorUsedError;
  bool get isCorrect => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AnswerHistoryCopyWith<AnswerHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnswerHistoryCopyWith<$Res> {
  factory $AnswerHistoryCopyWith(
          AnswerHistory value, $Res Function(AnswerHistory) then) =
      _$AnswerHistoryCopyWithImpl<$Res, AnswerHistory>;
  @useResult
  $Res call(
      {String answerHistoryId,
      String questionId,
      String workbookId,
      bool isCorrect,
      DateTime createdAt});
}

/// @nodoc
class _$AnswerHistoryCopyWithImpl<$Res, $Val extends AnswerHistory>
    implements $AnswerHistoryCopyWith<$Res> {
  _$AnswerHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? answerHistoryId = null,
    Object? questionId = null,
    Object? workbookId = null,
    Object? isCorrect = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      answerHistoryId: null == answerHistoryId
          ? _value.answerHistoryId
          : answerHistoryId // ignore: cast_nullable_to_non_nullable
              as String,
      questionId: null == questionId
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as String,
      workbookId: null == workbookId
          ? _value.workbookId
          : workbookId // ignore: cast_nullable_to_non_nullable
              as String,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AnswerHistoryCopyWith<$Res>
    implements $AnswerHistoryCopyWith<$Res> {
  factory _$$_AnswerHistoryCopyWith(
          _$_AnswerHistory value, $Res Function(_$_AnswerHistory) then) =
      __$$_AnswerHistoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String answerHistoryId,
      String questionId,
      String workbookId,
      bool isCorrect,
      DateTime createdAt});
}

/// @nodoc
class __$$_AnswerHistoryCopyWithImpl<$Res>
    extends _$AnswerHistoryCopyWithImpl<$Res, _$_AnswerHistory>
    implements _$$_AnswerHistoryCopyWith<$Res> {
  __$$_AnswerHistoryCopyWithImpl(
      _$_AnswerHistory _value, $Res Function(_$_AnswerHistory) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? answerHistoryId = null,
    Object? questionId = null,
    Object? workbookId = null,
    Object? isCorrect = null,
    Object? createdAt = null,
  }) {
    return _then(_$_AnswerHistory(
      answerHistoryId: null == answerHistoryId
          ? _value.answerHistoryId
          : answerHistoryId // ignore: cast_nullable_to_non_nullable
              as String,
      questionId: null == questionId
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as String,
      workbookId: null == workbookId
          ? _value.workbookId
          : workbookId // ignore: cast_nullable_to_non_nullable
              as String,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$_AnswerHistory extends _AnswerHistory {
  const _$_AnswerHistory(
      {required this.answerHistoryId,
      required this.questionId,
      required this.workbookId,
      required this.isCorrect,
      required this.createdAt})
      : super._();

  @override
  final String answerHistoryId;
  @override
  final String questionId;
  @override
  final String workbookId;
  @override
  final bool isCorrect;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'AnswerHistory(answerHistoryId: $answerHistoryId, questionId: $questionId, workbookId: $workbookId, isCorrect: $isCorrect, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AnswerHistory &&
            (identical(other.answerHistoryId, answerHistoryId) ||
                other.answerHistoryId == answerHistoryId) &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.workbookId, workbookId) ||
                other.workbookId == workbookId) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, answerHistoryId, questionId,
      workbookId, isCorrect, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AnswerHistoryCopyWith<_$_AnswerHistory> get copyWith =>
      __$$_AnswerHistoryCopyWithImpl<_$_AnswerHistory>(this, _$identity);
}

abstract class _AnswerHistory extends AnswerHistory {
  const factory _AnswerHistory(
      {required final String answerHistoryId,
      required final String questionId,
      required final String workbookId,
      required final bool isCorrect,
      required final DateTime createdAt}) = _$_AnswerHistory;
  const _AnswerHistory._() : super._();

  @override
  String get answerHistoryId;
  @override
  String get questionId;
  @override
  String get workbookId;
  @override
  bool get isCorrect;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_AnswerHistoryCopyWith<_$_AnswerHistory> get copyWith =>
      throw _privateConstructorUsedError;
}
