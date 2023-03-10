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
  String get workbookId => throw _privateConstructorUsedError;
  QuestionType get questionType => throw _privateConstructorUsedError;
  String get problem => throw _privateConstructorUsedError;
  AppImage get problemImage => throw _privateConstructorUsedError;
  List<String> get answers => throw _privateConstructorUsedError;
  List<String> get wrongChoices => throw _privateConstructorUsedError;
  String? get explanation => throw _privateConstructorUsedError;
  AppImage get explanationImage => throw _privateConstructorUsedError;
  bool get isAutoGenerateWrongChoices => throw _privateConstructorUsedError;
  bool get isCheckAnswerOrder => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  AnswerStatus get answerStatus => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get lastAnsweredAt => throw _privateConstructorUsedError;
  AppDataLocation get location => throw _privateConstructorUsedError;

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
      String workbookId,
      QuestionType questionType,
      String problem,
      AppImage problemImage,
      List<String> answers,
      List<String> wrongChoices,
      String? explanation,
      AppImage explanationImage,
      bool isAutoGenerateWrongChoices,
      bool isCheckAnswerOrder,
      int order,
      AnswerStatus answerStatus,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? lastAnsweredAt,
      AppDataLocation location});

  $AppImageCopyWith<$Res> get problemImage;
  $AppImageCopyWith<$Res> get explanationImage;
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
    Object? workbookId = null,
    Object? questionType = null,
    Object? problem = null,
    Object? problemImage = null,
    Object? answers = null,
    Object? wrongChoices = null,
    Object? explanation = freezed,
    Object? explanationImage = null,
    Object? isAutoGenerateWrongChoices = null,
    Object? isCheckAnswerOrder = null,
    Object? order = null,
    Object? answerStatus = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? lastAnsweredAt = freezed,
    Object? location = null,
  }) {
    return _then(_value.copyWith(
      questionId: null == questionId
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as String,
      workbookId: null == workbookId
          ? _value.workbookId
          : workbookId // ignore: cast_nullable_to_non_nullable
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
      answers: null == answers
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      wrongChoices: null == wrongChoices
          ? _value.wrongChoices
          : wrongChoices // ignore: cast_nullable_to_non_nullable
              as List<String>,
      explanation: freezed == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String?,
      explanationImage: null == explanationImage
          ? _value.explanationImage
          : explanationImage // ignore: cast_nullable_to_non_nullable
              as AppImage,
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
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastAnsweredAt: freezed == lastAnsweredAt
          ? _value.lastAnsweredAt
          : lastAnsweredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as AppDataLocation,
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
      String workbookId,
      QuestionType questionType,
      String problem,
      AppImage problemImage,
      List<String> answers,
      List<String> wrongChoices,
      String? explanation,
      AppImage explanationImage,
      bool isAutoGenerateWrongChoices,
      bool isCheckAnswerOrder,
      int order,
      AnswerStatus answerStatus,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? lastAnsweredAt,
      AppDataLocation location});

  @override
  $AppImageCopyWith<$Res> get problemImage;
  @override
  $AppImageCopyWith<$Res> get explanationImage;
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
    Object? workbookId = null,
    Object? questionType = null,
    Object? problem = null,
    Object? problemImage = null,
    Object? answers = null,
    Object? wrongChoices = null,
    Object? explanation = freezed,
    Object? explanationImage = null,
    Object? isAutoGenerateWrongChoices = null,
    Object? isCheckAnswerOrder = null,
    Object? order = null,
    Object? answerStatus = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? lastAnsweredAt = freezed,
    Object? location = null,
  }) {
    return _then(_$_Question(
      questionId: null == questionId
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as String,
      workbookId: null == workbookId
          ? _value.workbookId
          : workbookId // ignore: cast_nullable_to_non_nullable
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
      answers: null == answers
          ? _value._answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      wrongChoices: null == wrongChoices
          ? _value._wrongChoices
          : wrongChoices // ignore: cast_nullable_to_non_nullable
              as List<String>,
      explanation: freezed == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String?,
      explanationImage: null == explanationImage
          ? _value.explanationImage
          : explanationImage // ignore: cast_nullable_to_non_nullable
              as AppImage,
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
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastAnsweredAt: freezed == lastAnsweredAt
          ? _value.lastAnsweredAt
          : lastAnsweredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as AppDataLocation,
    ));
  }
}

/// @nodoc

class _$_Question extends _Question {
  const _$_Question(
      {required this.questionId,
      required this.workbookId,
      required this.questionType,
      required this.problem,
      required this.problemImage,
      required final List<String> answers,
      required final List<String> wrongChoices,
      required this.explanation,
      required this.explanationImage,
      required this.isAutoGenerateWrongChoices,
      required this.isCheckAnswerOrder,
      required this.order,
      required this.answerStatus,
      required this.createdAt,
      required this.updatedAt,
      required this.lastAnsweredAt,
      required this.location})
      : _answers = answers,
        _wrongChoices = wrongChoices,
        super._();

  @override
  final String questionId;
  @override
  final String workbookId;
  @override
  final QuestionType questionType;
  @override
  final String problem;
  @override
  final AppImage problemImage;
  final List<String> _answers;
  @override
  List<String> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  final List<String> _wrongChoices;
  @override
  List<String> get wrongChoices {
    if (_wrongChoices is EqualUnmodifiableListView) return _wrongChoices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_wrongChoices);
  }

  @override
  final String? explanation;
  @override
  final AppImage explanationImage;
  @override
  final bool isAutoGenerateWrongChoices;
  @override
  final bool isCheckAnswerOrder;
  @override
  final int order;
  @override
  final AnswerStatus answerStatus;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? lastAnsweredAt;
  @override
  final AppDataLocation location;

  @override
  String toString() {
    return 'Question(questionId: $questionId, workbookId: $workbookId, questionType: $questionType, problem: $problem, problemImage: $problemImage, answers: $answers, wrongChoices: $wrongChoices, explanation: $explanation, explanationImage: $explanationImage, isAutoGenerateWrongChoices: $isAutoGenerateWrongChoices, isCheckAnswerOrder: $isCheckAnswerOrder, order: $order, answerStatus: $answerStatus, createdAt: $createdAt, updatedAt: $updatedAt, lastAnsweredAt: $lastAnsweredAt, location: $location)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Question &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.workbookId, workbookId) ||
                other.workbookId == workbookId) &&
            (identical(other.questionType, questionType) ||
                other.questionType == questionType) &&
            (identical(other.problem, problem) || other.problem == problem) &&
            (identical(other.problemImage, problemImage) ||
                other.problemImage == problemImage) &&
            const DeepCollectionEquality().equals(other._answers, _answers) &&
            const DeepCollectionEquality()
                .equals(other._wrongChoices, _wrongChoices) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            (identical(other.explanationImage, explanationImage) ||
                other.explanationImage == explanationImage) &&
            (identical(other.isAutoGenerateWrongChoices,
                    isAutoGenerateWrongChoices) ||
                other.isAutoGenerateWrongChoices ==
                    isAutoGenerateWrongChoices) &&
            (identical(other.isCheckAnswerOrder, isCheckAnswerOrder) ||
                other.isCheckAnswerOrder == isCheckAnswerOrder) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.answerStatus, answerStatus) ||
                other.answerStatus == answerStatus) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastAnsweredAt, lastAnsweredAt) ||
                other.lastAnsweredAt == lastAnsweredAt) &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      questionId,
      workbookId,
      questionType,
      problem,
      problemImage,
      const DeepCollectionEquality().hash(_answers),
      const DeepCollectionEquality().hash(_wrongChoices),
      explanation,
      explanationImage,
      isAutoGenerateWrongChoices,
      isCheckAnswerOrder,
      order,
      answerStatus,
      createdAt,
      updatedAt,
      lastAnsweredAt,
      location);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QuestionCopyWith<_$_Question> get copyWith =>
      __$$_QuestionCopyWithImpl<_$_Question>(this, _$identity);
}

abstract class _Question extends Question {
  const factory _Question(
      {required final String questionId,
      required final String workbookId,
      required final QuestionType questionType,
      required final String problem,
      required final AppImage problemImage,
      required final List<String> answers,
      required final List<String> wrongChoices,
      required final String? explanation,
      required final AppImage explanationImage,
      required final bool isAutoGenerateWrongChoices,
      required final bool isCheckAnswerOrder,
      required final int order,
      required final AnswerStatus answerStatus,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final DateTime? lastAnsweredAt,
      required final AppDataLocation location}) = _$_Question;
  const _Question._() : super._();

  @override
  String get questionId;
  @override
  String get workbookId;
  @override
  QuestionType get questionType;
  @override
  String get problem;
  @override
  AppImage get problemImage;
  @override
  List<String> get answers;
  @override
  List<String> get wrongChoices;
  @override
  String? get explanation;
  @override
  AppImage get explanationImage;
  @override
  bool get isAutoGenerateWrongChoices;
  @override
  bool get isCheckAnswerOrder;
  @override
  int get order;
  @override
  AnswerStatus get answerStatus;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get lastAnsweredAt;
  @override
  AppDataLocation get location;
  @override
  @JsonKey(ignore: true)
  _$$_QuestionCopyWith<_$_Question> get copyWith =>
      throw _privateConstructorUsedError;
}
