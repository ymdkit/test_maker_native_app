// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Question {
  String get questionId => throw _privateConstructorUsedError;
  QuestionType get questionType => throw _privateConstructorUsedError;
  String get problem => throw _privateConstructorUsedError;
  String? get problemImageUrl => throw _privateConstructorUsedError;
  List<String> get answers => throw _privateConstructorUsedError;
  String? get explanation => throw _privateConstructorUsedError;
  String? get explanationImageUrl => throw _privateConstructorUsedError;
  bool get isAutoGenerateWrongChoices => throw _privateConstructorUsedError;
  bool get isCheckAnswerOrder => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  AnswerStatus get answerStatus => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QuestionCopyWith<Question> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionCopyWith<$Res> {
  factory $QuestionCopyWith(Question value, $Res Function(Question) then) =
      _$QuestionCopyWithImpl<$Res, Question>;
  @useResult
  $Res call(
      {String questionId,
      QuestionType questionType,
      String problem,
      String? problemImageUrl,
      List<String> answers,
      String? explanation,
      String? explanationImageUrl,
      bool isAutoGenerateWrongChoices,
      bool isCheckAnswerOrder,
      int order,
      AnswerStatus answerStatus});
}

/// @nodoc
class _$QuestionCopyWithImpl<$Res, $Val extends Question>
    implements $QuestionCopyWith<$Res> {
  _$QuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? questionType = null,
    Object? problem = null,
    Object? problemImageUrl = freezed,
    Object? answers = null,
    Object? explanation = freezed,
    Object? explanationImageUrl = freezed,
    Object? isAutoGenerateWrongChoices = null,
    Object? isCheckAnswerOrder = null,
    Object? order = null,
    Object? answerStatus = null,
  }) {
    return _then(_value.copyWith(
      questionId: null == questionId
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as String,
      questionType: null == questionType
          ? _value.questionType
          : questionType // ignore: cast_nullable_to_non_nullable
              as QuestionType,
      problem: null == problem
          ? _value.problem
          : problem // ignore: cast_nullable_to_non_nullable
              as String,
      problemImageUrl: freezed == problemImageUrl
          ? _value.problemImageUrl
          : problemImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      answers: null == answers
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      explanation: freezed == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String?,
      explanationImageUrl: freezed == explanationImageUrl
          ? _value.explanationImageUrl
          : explanationImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isAutoGenerateWrongChoices: null == isAutoGenerateWrongChoices
          ? _value.isAutoGenerateWrongChoices
          : isAutoGenerateWrongChoices // ignore: cast_nullable_to_non_nullable
              as bool,
      isCheckAnswerOrder: null == isCheckAnswerOrder
          ? _value.isCheckAnswerOrder
          : isCheckAnswerOrder // ignore: cast_nullable_to_non_nullable
              as bool,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      answerStatus: null == answerStatus
          ? _value.answerStatus
          : answerStatus // ignore: cast_nullable_to_non_nullable
              as AnswerStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_QuestionCopyWith<$Res> implements $QuestionCopyWith<$Res> {
  factory _$$_QuestionCopyWith(
          _$_Question value, $Res Function(_$_Question) then) =
      __$$_QuestionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String questionId,
      QuestionType questionType,
      String problem,
      String? problemImageUrl,
      List<String> answers,
      String? explanation,
      String? explanationImageUrl,
      bool isAutoGenerateWrongChoices,
      bool isCheckAnswerOrder,
      int order,
      AnswerStatus answerStatus});
}

/// @nodoc
class __$$_QuestionCopyWithImpl<$Res>
    extends _$QuestionCopyWithImpl<$Res, _$_Question>
    implements _$$_QuestionCopyWith<$Res> {
  __$$_QuestionCopyWithImpl(
      _$_Question _value, $Res Function(_$_Question) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? questionType = null,
    Object? problem = null,
    Object? problemImageUrl = freezed,
    Object? answers = null,
    Object? explanation = freezed,
    Object? explanationImageUrl = freezed,
    Object? isAutoGenerateWrongChoices = null,
    Object? isCheckAnswerOrder = null,
    Object? order = null,
    Object? answerStatus = null,
  }) {
    return _then(_$_Question(
      questionId: null == questionId
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as String,
      questionType: null == questionType
          ? _value.questionType
          : questionType // ignore: cast_nullable_to_non_nullable
              as QuestionType,
      problem: null == problem
          ? _value.problem
          : problem // ignore: cast_nullable_to_non_nullable
              as String,
      problemImageUrl: freezed == problemImageUrl
          ? _value.problemImageUrl
          : problemImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      answers: null == answers
          ? _value._answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      explanation: freezed == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String?,
      explanationImageUrl: freezed == explanationImageUrl
          ? _value.explanationImageUrl
          : explanationImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isAutoGenerateWrongChoices: null == isAutoGenerateWrongChoices
          ? _value.isAutoGenerateWrongChoices
          : isAutoGenerateWrongChoices // ignore: cast_nullable_to_non_nullable
              as bool,
      isCheckAnswerOrder: null == isCheckAnswerOrder
          ? _value.isCheckAnswerOrder
          : isCheckAnswerOrder // ignore: cast_nullable_to_non_nullable
              as bool,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      answerStatus: null == answerStatus
          ? _value.answerStatus
          : answerStatus // ignore: cast_nullable_to_non_nullable
              as AnswerStatus,
    ));
  }
}

/// @nodoc

class _$_Question implements _Question {
  const _$_Question(
      {required this.questionId,
      required this.questionType,
      required this.problem,
      required this.problemImageUrl,
      required final List<String> answers,
      required this.explanation,
      required this.explanationImageUrl,
      required this.isAutoGenerateWrongChoices,
      required this.isCheckAnswerOrder,
      required this.order,
      required this.answerStatus})
      : _answers = answers;

  @override
  final String questionId;
  @override
  final QuestionType questionType;
  @override
  final String problem;
  @override
  final String? problemImageUrl;
  final List<String> _answers;
  @override
  List<String> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  @override
  final String? explanation;
  @override
  final String? explanationImageUrl;
  @override
  final bool isAutoGenerateWrongChoices;
  @override
  final bool isCheckAnswerOrder;
  @override
  final int order;
  @override
  final AnswerStatus answerStatus;

  @override
  String toString() {
    return 'Question(questionId: $questionId, questionType: $questionType, problem: $problem, problemImageUrl: $problemImageUrl, answers: $answers, explanation: $explanation, explanationImageUrl: $explanationImageUrl, isAutoGenerateWrongChoices: $isAutoGenerateWrongChoices, isCheckAnswerOrder: $isCheckAnswerOrder, order: $order, answerStatus: $answerStatus)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Question &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.questionType, questionType) ||
                other.questionType == questionType) &&
            (identical(other.problem, problem) || other.problem == problem) &&
            (identical(other.problemImageUrl, problemImageUrl) ||
                other.problemImageUrl == problemImageUrl) &&
            const DeepCollectionEquality().equals(other._answers, _answers) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            (identical(other.explanationImageUrl, explanationImageUrl) ||
                other.explanationImageUrl == explanationImageUrl) &&
            (identical(other.isAutoGenerateWrongChoices,
                    isAutoGenerateWrongChoices) ||
                other.isAutoGenerateWrongChoices ==
                    isAutoGenerateWrongChoices) &&
            (identical(other.isCheckAnswerOrder, isCheckAnswerOrder) ||
                other.isCheckAnswerOrder == isCheckAnswerOrder) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.answerStatus, answerStatus) ||
                other.answerStatus == answerStatus));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      questionId,
      questionType,
      problem,
      problemImageUrl,
      const DeepCollectionEquality().hash(_answers),
      explanation,
      explanationImageUrl,
      isAutoGenerateWrongChoices,
      isCheckAnswerOrder,
      order,
      answerStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QuestionCopyWith<_$_Question> get copyWith =>
      __$$_QuestionCopyWithImpl<_$_Question>(this, _$identity);
}

abstract class _Question implements Question {
  const factory _Question(
      {required final String questionId,
      required final QuestionType questionType,
      required final String problem,
      required final String? problemImageUrl,
      required final List<String> answers,
      required final String? explanation,
      required final String? explanationImageUrl,
      required final bool isAutoGenerateWrongChoices,
      required final bool isCheckAnswerOrder,
      required final int order,
      required final AnswerStatus answerStatus}) = _$_Question;

  @override
  String get questionId;
  @override
  QuestionType get questionType;
  @override
  String get problem;
  @override
  String? get problemImageUrl;
  @override
  List<String> get answers;
  @override
  String? get explanation;
  @override
  String? get explanationImageUrl;
  @override
  bool get isAutoGenerateWrongChoices;
  @override
  bool get isCheckAnswerOrder;
  @override
  int get order;
  @override
  AnswerStatus get answerStatus;
  @override
  @JsonKey(ignore: true)
  _$$_QuestionCopyWith<_$_Question> get copyWith =>
      throw _privateConstructorUsedError;
}