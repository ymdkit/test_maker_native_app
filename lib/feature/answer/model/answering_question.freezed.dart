// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'answering_question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AnsweringQuestion {
  String get questionId => throw _privateConstructorUsedError;
  QuestionType get questionType => throw _privateConstructorUsedError;
  String get problem => throw _privateConstructorUsedError;
  AppImage get problemImage => throw _privateConstructorUsedError;
  String? get explanation => throw _privateConstructorUsedError;
  AppImage get explanationImage => throw _privateConstructorUsedError;
  List<String> get answers => throw _privateConstructorUsedError;
  List<String> get choices => throw _privateConstructorUsedError;
  bool get isCheckAnswerOrder => throw _privateConstructorUsedError;
  Question get rawQuestion => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AnsweringQuestionCopyWith<AnsweringQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnsweringQuestionCopyWith<$Res> {
  factory $AnsweringQuestionCopyWith(
          AnsweringQuestion value, $Res Function(AnsweringQuestion) then) =
      _$AnsweringQuestionCopyWithImpl<$Res, AnsweringQuestion>;
  @useResult
  $Res call(
      {String questionId,
      QuestionType questionType,
      String problem,
      AppImage problemImage,
      String? explanation,
      AppImage explanationImage,
      List<String> answers,
      List<String> choices,
      bool isCheckAnswerOrder,
      Question rawQuestion});

  $AppImageCopyWith<$Res> get problemImage;
  $AppImageCopyWith<$Res> get explanationImage;
  $QuestionCopyWith<$Res> get rawQuestion;
}

/// @nodoc
class _$AnsweringQuestionCopyWithImpl<$Res, $Val extends AnsweringQuestion>
    implements $AnsweringQuestionCopyWith<$Res> {
  _$AnsweringQuestionCopyWithImpl(this._value, this._then);

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
    Object? problemImage = null,
    Object? explanation = freezed,
    Object? explanationImage = null,
    Object? answers = null,
    Object? choices = null,
    Object? isCheckAnswerOrder = null,
    Object? rawQuestion = null,
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
      problemImage: null == problemImage
          ? _value.problemImage
          : problemImage // ignore: cast_nullable_to_non_nullable
              as AppImage,
      explanation: freezed == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String?,
      explanationImage: null == explanationImage
          ? _value.explanationImage
          : explanationImage // ignore: cast_nullable_to_non_nullable
              as AppImage,
      answers: null == answers
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      choices: null == choices
          ? _value.choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isCheckAnswerOrder: null == isCheckAnswerOrder
          ? _value.isCheckAnswerOrder
          : isCheckAnswerOrder // ignore: cast_nullable_to_non_nullable
              as bool,
      rawQuestion: null == rawQuestion
          ? _value.rawQuestion
          : rawQuestion // ignore: cast_nullable_to_non_nullable
              as Question,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AppImageCopyWith<$Res> get problemImage {
    return $AppImageCopyWith<$Res>(_value.problemImage, (value) {
      return _then(_value.copyWith(problemImage: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AppImageCopyWith<$Res> get explanationImage {
    return $AppImageCopyWith<$Res>(_value.explanationImage, (value) {
      return _then(_value.copyWith(explanationImage: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $QuestionCopyWith<$Res> get rawQuestion {
    return $QuestionCopyWith<$Res>(_value.rawQuestion, (value) {
      return _then(_value.copyWith(rawQuestion: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AnsweringQuestionCopyWith<$Res>
    implements $AnsweringQuestionCopyWith<$Res> {
  factory _$$_AnsweringQuestionCopyWith(_$_AnsweringQuestion value,
          $Res Function(_$_AnsweringQuestion) then) =
      __$$_AnsweringQuestionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String questionId,
      QuestionType questionType,
      String problem,
      AppImage problemImage,
      String? explanation,
      AppImage explanationImage,
      List<String> answers,
      List<String> choices,
      bool isCheckAnswerOrder,
      Question rawQuestion});

  @override
  $AppImageCopyWith<$Res> get problemImage;
  @override
  $AppImageCopyWith<$Res> get explanationImage;
  @override
  $QuestionCopyWith<$Res> get rawQuestion;
}

/// @nodoc
class __$$_AnsweringQuestionCopyWithImpl<$Res>
    extends _$AnsweringQuestionCopyWithImpl<$Res, _$_AnsweringQuestion>
    implements _$$_AnsweringQuestionCopyWith<$Res> {
  __$$_AnsweringQuestionCopyWithImpl(
      _$_AnsweringQuestion _value, $Res Function(_$_AnsweringQuestion) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? questionType = null,
    Object? problem = null,
    Object? problemImage = null,
    Object? explanation = freezed,
    Object? explanationImage = null,
    Object? answers = null,
    Object? choices = null,
    Object? isCheckAnswerOrder = null,
    Object? rawQuestion = null,
  }) {
    return _then(_$_AnsweringQuestion(
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
      problemImage: null == problemImage
          ? _value.problemImage
          : problemImage // ignore: cast_nullable_to_non_nullable
              as AppImage,
      explanation: freezed == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String?,
      explanationImage: null == explanationImage
          ? _value.explanationImage
          : explanationImage // ignore: cast_nullable_to_non_nullable
              as AppImage,
      answers: null == answers
          ? _value._answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      choices: null == choices
          ? _value._choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isCheckAnswerOrder: null == isCheckAnswerOrder
          ? _value.isCheckAnswerOrder
          : isCheckAnswerOrder // ignore: cast_nullable_to_non_nullable
              as bool,
      rawQuestion: null == rawQuestion
          ? _value.rawQuestion
          : rawQuestion // ignore: cast_nullable_to_non_nullable
              as Question,
    ));
  }
}

/// @nodoc

class _$_AnsweringQuestion implements _AnsweringQuestion {
  const _$_AnsweringQuestion(
      {required this.questionId,
      required this.questionType,
      required this.problem,
      required this.problemImage,
      required this.explanation,
      required this.explanationImage,
      required final List<String> answers,
      required final List<String> choices,
      required this.isCheckAnswerOrder,
      required this.rawQuestion})
      : _answers = answers,
        _choices = choices;

  @override
  final String questionId;
  @override
  final QuestionType questionType;
  @override
  final String problem;
  @override
  final AppImage problemImage;
  @override
  final String? explanation;
  @override
  final AppImage explanationImage;
  final List<String> _answers;
  @override
  List<String> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  final List<String> _choices;
  @override
  List<String> get choices {
    if (_choices is EqualUnmodifiableListView) return _choices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_choices);
  }

  @override
  final bool isCheckAnswerOrder;
  @override
  final Question rawQuestion;

  @override
  String toString() {
    return 'AnsweringQuestion(questionId: $questionId, questionType: $questionType, problem: $problem, problemImage: $problemImage, explanation: $explanation, explanationImage: $explanationImage, answers: $answers, choices: $choices, isCheckAnswerOrder: $isCheckAnswerOrder, rawQuestion: $rawQuestion)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AnsweringQuestion &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.questionType, questionType) ||
                other.questionType == questionType) &&
            (identical(other.problem, problem) || other.problem == problem) &&
            (identical(other.problemImage, problemImage) ||
                other.problemImage == problemImage) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            (identical(other.explanationImage, explanationImage) ||
                other.explanationImage == explanationImage) &&
            const DeepCollectionEquality().equals(other._answers, _answers) &&
            const DeepCollectionEquality().equals(other._choices, _choices) &&
            (identical(other.isCheckAnswerOrder, isCheckAnswerOrder) ||
                other.isCheckAnswerOrder == isCheckAnswerOrder) &&
            (identical(other.rawQuestion, rawQuestion) ||
                other.rawQuestion == rawQuestion));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      questionId,
      questionType,
      problem,
      problemImage,
      explanation,
      explanationImage,
      const DeepCollectionEquality().hash(_answers),
      const DeepCollectionEquality().hash(_choices),
      isCheckAnswerOrder,
      rawQuestion);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AnsweringQuestionCopyWith<_$_AnsweringQuestion> get copyWith =>
      __$$_AnsweringQuestionCopyWithImpl<_$_AnsweringQuestion>(
          this, _$identity);
}

abstract class _AnsweringQuestion implements AnsweringQuestion {
  const factory _AnsweringQuestion(
      {required final String questionId,
      required final QuestionType questionType,
      required final String problem,
      required final AppImage problemImage,
      required final String? explanation,
      required final AppImage explanationImage,
      required final List<String> answers,
      required final List<String> choices,
      required final bool isCheckAnswerOrder,
      required final Question rawQuestion}) = _$_AnsweringQuestion;

  @override
  String get questionId;
  @override
  QuestionType get questionType;
  @override
  String get problem;
  @override
  AppImage get problemImage;
  @override
  String? get explanation;
  @override
  AppImage get explanationImage;
  @override
  List<String> get answers;
  @override
  List<String> get choices;
  @override
  bool get isCheckAnswerOrder;
  @override
  Question get rawQuestion;
  @override
  @JsonKey(ignore: true)
  _$$_AnsweringQuestionCopyWith<_$_AnsweringQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}
