// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'answer_workbook_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AnswerWorkbookState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Question question) answering,
    required TResult Function(Question question) confirming,
    required TResult Function(Question question) selfScoring,
    required TResult Function(Question question) reviewing,
    required TResult Function() idling,
    required TResult Function() finished,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Question question)? answering,
    TResult? Function(Question question)? confirming,
    TResult? Function(Question question)? selfScoring,
    TResult? Function(Question question)? reviewing,
    TResult? Function()? idling,
    TResult? Function()? finished,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Question question)? answering,
    TResult Function(Question question)? confirming,
    TResult Function(Question question)? selfScoring,
    TResult Function(Question question)? reviewing,
    TResult Function()? idling,
    TResult Function()? finished,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Answering value) answering,
    required TResult Function(Confirming value) confirming,
    required TResult Function(SelfScoring value) selfScoring,
    required TResult Function(Reviewing value) reviewing,
    required TResult Function(Idling value) idling,
    required TResult Function(Finished value) finished,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Answering value)? answering,
    TResult? Function(Confirming value)? confirming,
    TResult? Function(SelfScoring value)? selfScoring,
    TResult? Function(Reviewing value)? reviewing,
    TResult? Function(Idling value)? idling,
    TResult? Function(Finished value)? finished,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Answering value)? answering,
    TResult Function(Confirming value)? confirming,
    TResult Function(SelfScoring value)? selfScoring,
    TResult Function(Reviewing value)? reviewing,
    TResult Function(Idling value)? idling,
    TResult Function(Finished value)? finished,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnswerWorkbookStateCopyWith<$Res> {
  factory $AnswerWorkbookStateCopyWith(
          AnswerWorkbookState value, $Res Function(AnswerWorkbookState) then) =
      _$AnswerWorkbookStateCopyWithImpl<$Res, AnswerWorkbookState>;
}

/// @nodoc
class _$AnswerWorkbookStateCopyWithImpl<$Res, $Val extends AnswerWorkbookState>
    implements $AnswerWorkbookStateCopyWith<$Res> {
  _$AnswerWorkbookStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AnsweringCopyWith<$Res> {
  factory _$$AnsweringCopyWith(
          _$Answering value, $Res Function(_$Answering) then) =
      __$$AnsweringCopyWithImpl<$Res>;
  @useResult
  $Res call({Question question});

  $QuestionCopyWith<$Res> get question;
}

/// @nodoc
class __$$AnsweringCopyWithImpl<$Res>
    extends _$AnswerWorkbookStateCopyWithImpl<$Res, _$Answering>
    implements _$$AnsweringCopyWith<$Res> {
  __$$AnsweringCopyWithImpl(
      _$Answering _value, $Res Function(_$Answering) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
  }) {
    return _then(_$Answering(
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as Question,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $QuestionCopyWith<$Res> get question {
    return $QuestionCopyWith<$Res>(_value.question, (value) {
      return _then(_value.copyWith(question: value));
    });
  }
}

/// @nodoc

class _$Answering implements Answering {
  const _$Answering({required this.question});

  @override
  final Question question;

  @override
  String toString() {
    return 'AnswerWorkbookState.answering(question: $question)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Answering &&
            (identical(other.question, question) ||
                other.question == question));
  }

  @override
  int get hashCode => Object.hash(runtimeType, question);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AnsweringCopyWith<_$Answering> get copyWith =>
      __$$AnsweringCopyWithImpl<_$Answering>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Question question) answering,
    required TResult Function(Question question) confirming,
    required TResult Function(Question question) selfScoring,
    required TResult Function(Question question) reviewing,
    required TResult Function() idling,
    required TResult Function() finished,
  }) {
    return answering(question);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Question question)? answering,
    TResult? Function(Question question)? confirming,
    TResult? Function(Question question)? selfScoring,
    TResult? Function(Question question)? reviewing,
    TResult? Function()? idling,
    TResult? Function()? finished,
  }) {
    return answering?.call(question);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Question question)? answering,
    TResult Function(Question question)? confirming,
    TResult Function(Question question)? selfScoring,
    TResult Function(Question question)? reviewing,
    TResult Function()? idling,
    TResult Function()? finished,
    required TResult orElse(),
  }) {
    if (answering != null) {
      return answering(question);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Answering value) answering,
    required TResult Function(Confirming value) confirming,
    required TResult Function(SelfScoring value) selfScoring,
    required TResult Function(Reviewing value) reviewing,
    required TResult Function(Idling value) idling,
    required TResult Function(Finished value) finished,
  }) {
    return answering(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Answering value)? answering,
    TResult? Function(Confirming value)? confirming,
    TResult? Function(SelfScoring value)? selfScoring,
    TResult? Function(Reviewing value)? reviewing,
    TResult? Function(Idling value)? idling,
    TResult? Function(Finished value)? finished,
  }) {
    return answering?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Answering value)? answering,
    TResult Function(Confirming value)? confirming,
    TResult Function(SelfScoring value)? selfScoring,
    TResult Function(Reviewing value)? reviewing,
    TResult Function(Idling value)? idling,
    TResult Function(Finished value)? finished,
    required TResult orElse(),
  }) {
    if (answering != null) {
      return answering(this);
    }
    return orElse();
  }
}

abstract class Answering implements AnswerWorkbookState {
  const factory Answering({required final Question question}) = _$Answering;

  Question get question;
  @JsonKey(ignore: true)
  _$$AnsweringCopyWith<_$Answering> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConfirmingCopyWith<$Res> {
  factory _$$ConfirmingCopyWith(
          _$Confirming value, $Res Function(_$Confirming) then) =
      __$$ConfirmingCopyWithImpl<$Res>;
  @useResult
  $Res call({Question question});

  $QuestionCopyWith<$Res> get question;
}

/// @nodoc
class __$$ConfirmingCopyWithImpl<$Res>
    extends _$AnswerWorkbookStateCopyWithImpl<$Res, _$Confirming>
    implements _$$ConfirmingCopyWith<$Res> {
  __$$ConfirmingCopyWithImpl(
      _$Confirming _value, $Res Function(_$Confirming) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
  }) {
    return _then(_$Confirming(
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as Question,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $QuestionCopyWith<$Res> get question {
    return $QuestionCopyWith<$Res>(_value.question, (value) {
      return _then(_value.copyWith(question: value));
    });
  }
}

/// @nodoc

class _$Confirming implements Confirming {
  const _$Confirming({required this.question});

  @override
  final Question question;

  @override
  String toString() {
    return 'AnswerWorkbookState.confirming(question: $question)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Confirming &&
            (identical(other.question, question) ||
                other.question == question));
  }

  @override
  int get hashCode => Object.hash(runtimeType, question);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmingCopyWith<_$Confirming> get copyWith =>
      __$$ConfirmingCopyWithImpl<_$Confirming>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Question question) answering,
    required TResult Function(Question question) confirming,
    required TResult Function(Question question) selfScoring,
    required TResult Function(Question question) reviewing,
    required TResult Function() idling,
    required TResult Function() finished,
  }) {
    return confirming(question);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Question question)? answering,
    TResult? Function(Question question)? confirming,
    TResult? Function(Question question)? selfScoring,
    TResult? Function(Question question)? reviewing,
    TResult? Function()? idling,
    TResult? Function()? finished,
  }) {
    return confirming?.call(question);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Question question)? answering,
    TResult Function(Question question)? confirming,
    TResult Function(Question question)? selfScoring,
    TResult Function(Question question)? reviewing,
    TResult Function()? idling,
    TResult Function()? finished,
    required TResult orElse(),
  }) {
    if (confirming != null) {
      return confirming(question);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Answering value) answering,
    required TResult Function(Confirming value) confirming,
    required TResult Function(SelfScoring value) selfScoring,
    required TResult Function(Reviewing value) reviewing,
    required TResult Function(Idling value) idling,
    required TResult Function(Finished value) finished,
  }) {
    return confirming(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Answering value)? answering,
    TResult? Function(Confirming value)? confirming,
    TResult? Function(SelfScoring value)? selfScoring,
    TResult? Function(Reviewing value)? reviewing,
    TResult? Function(Idling value)? idling,
    TResult? Function(Finished value)? finished,
  }) {
    return confirming?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Answering value)? answering,
    TResult Function(Confirming value)? confirming,
    TResult Function(SelfScoring value)? selfScoring,
    TResult Function(Reviewing value)? reviewing,
    TResult Function(Idling value)? idling,
    TResult Function(Finished value)? finished,
    required TResult orElse(),
  }) {
    if (confirming != null) {
      return confirming(this);
    }
    return orElse();
  }
}

abstract class Confirming implements AnswerWorkbookState {
  const factory Confirming({required final Question question}) = _$Confirming;

  Question get question;
  @JsonKey(ignore: true)
  _$$ConfirmingCopyWith<_$Confirming> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelfScoringCopyWith<$Res> {
  factory _$$SelfScoringCopyWith(
          _$SelfScoring value, $Res Function(_$SelfScoring) then) =
      __$$SelfScoringCopyWithImpl<$Res>;
  @useResult
  $Res call({Question question});

  $QuestionCopyWith<$Res> get question;
}

/// @nodoc
class __$$SelfScoringCopyWithImpl<$Res>
    extends _$AnswerWorkbookStateCopyWithImpl<$Res, _$SelfScoring>
    implements _$$SelfScoringCopyWith<$Res> {
  __$$SelfScoringCopyWithImpl(
      _$SelfScoring _value, $Res Function(_$SelfScoring) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
  }) {
    return _then(_$SelfScoring(
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as Question,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $QuestionCopyWith<$Res> get question {
    return $QuestionCopyWith<$Res>(_value.question, (value) {
      return _then(_value.copyWith(question: value));
    });
  }
}

/// @nodoc

class _$SelfScoring implements SelfScoring {
  const _$SelfScoring({required this.question});

  @override
  final Question question;

  @override
  String toString() {
    return 'AnswerWorkbookState.selfScoring(question: $question)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelfScoring &&
            (identical(other.question, question) ||
                other.question == question));
  }

  @override
  int get hashCode => Object.hash(runtimeType, question);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelfScoringCopyWith<_$SelfScoring> get copyWith =>
      __$$SelfScoringCopyWithImpl<_$SelfScoring>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Question question) answering,
    required TResult Function(Question question) confirming,
    required TResult Function(Question question) selfScoring,
    required TResult Function(Question question) reviewing,
    required TResult Function() idling,
    required TResult Function() finished,
  }) {
    return selfScoring(question);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Question question)? answering,
    TResult? Function(Question question)? confirming,
    TResult? Function(Question question)? selfScoring,
    TResult? Function(Question question)? reviewing,
    TResult? Function()? idling,
    TResult? Function()? finished,
  }) {
    return selfScoring?.call(question);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Question question)? answering,
    TResult Function(Question question)? confirming,
    TResult Function(Question question)? selfScoring,
    TResult Function(Question question)? reviewing,
    TResult Function()? idling,
    TResult Function()? finished,
    required TResult orElse(),
  }) {
    if (selfScoring != null) {
      return selfScoring(question);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Answering value) answering,
    required TResult Function(Confirming value) confirming,
    required TResult Function(SelfScoring value) selfScoring,
    required TResult Function(Reviewing value) reviewing,
    required TResult Function(Idling value) idling,
    required TResult Function(Finished value) finished,
  }) {
    return selfScoring(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Answering value)? answering,
    TResult? Function(Confirming value)? confirming,
    TResult? Function(SelfScoring value)? selfScoring,
    TResult? Function(Reviewing value)? reviewing,
    TResult? Function(Idling value)? idling,
    TResult? Function(Finished value)? finished,
  }) {
    return selfScoring?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Answering value)? answering,
    TResult Function(Confirming value)? confirming,
    TResult Function(SelfScoring value)? selfScoring,
    TResult Function(Reviewing value)? reviewing,
    TResult Function(Idling value)? idling,
    TResult Function(Finished value)? finished,
    required TResult orElse(),
  }) {
    if (selfScoring != null) {
      return selfScoring(this);
    }
    return orElse();
  }
}

abstract class SelfScoring implements AnswerWorkbookState {
  const factory SelfScoring({required final Question question}) = _$SelfScoring;

  Question get question;
  @JsonKey(ignore: true)
  _$$SelfScoringCopyWith<_$SelfScoring> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReviewingCopyWith<$Res> {
  factory _$$ReviewingCopyWith(
          _$Reviewing value, $Res Function(_$Reviewing) then) =
      __$$ReviewingCopyWithImpl<$Res>;
  @useResult
  $Res call({Question question});

  $QuestionCopyWith<$Res> get question;
}

/// @nodoc
class __$$ReviewingCopyWithImpl<$Res>
    extends _$AnswerWorkbookStateCopyWithImpl<$Res, _$Reviewing>
    implements _$$ReviewingCopyWith<$Res> {
  __$$ReviewingCopyWithImpl(
      _$Reviewing _value, $Res Function(_$Reviewing) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
  }) {
    return _then(_$Reviewing(
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as Question,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $QuestionCopyWith<$Res> get question {
    return $QuestionCopyWith<$Res>(_value.question, (value) {
      return _then(_value.copyWith(question: value));
    });
  }
}

/// @nodoc

class _$Reviewing implements Reviewing {
  const _$Reviewing({required this.question});

  @override
  final Question question;

  @override
  String toString() {
    return 'AnswerWorkbookState.reviewing(question: $question)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Reviewing &&
            (identical(other.question, question) ||
                other.question == question));
  }

  @override
  int get hashCode => Object.hash(runtimeType, question);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewingCopyWith<_$Reviewing> get copyWith =>
      __$$ReviewingCopyWithImpl<_$Reviewing>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Question question) answering,
    required TResult Function(Question question) confirming,
    required TResult Function(Question question) selfScoring,
    required TResult Function(Question question) reviewing,
    required TResult Function() idling,
    required TResult Function() finished,
  }) {
    return reviewing(question);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Question question)? answering,
    TResult? Function(Question question)? confirming,
    TResult? Function(Question question)? selfScoring,
    TResult? Function(Question question)? reviewing,
    TResult? Function()? idling,
    TResult? Function()? finished,
  }) {
    return reviewing?.call(question);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Question question)? answering,
    TResult Function(Question question)? confirming,
    TResult Function(Question question)? selfScoring,
    TResult Function(Question question)? reviewing,
    TResult Function()? idling,
    TResult Function()? finished,
    required TResult orElse(),
  }) {
    if (reviewing != null) {
      return reviewing(question);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Answering value) answering,
    required TResult Function(Confirming value) confirming,
    required TResult Function(SelfScoring value) selfScoring,
    required TResult Function(Reviewing value) reviewing,
    required TResult Function(Idling value) idling,
    required TResult Function(Finished value) finished,
  }) {
    return reviewing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Answering value)? answering,
    TResult? Function(Confirming value)? confirming,
    TResult? Function(SelfScoring value)? selfScoring,
    TResult? Function(Reviewing value)? reviewing,
    TResult? Function(Idling value)? idling,
    TResult? Function(Finished value)? finished,
  }) {
    return reviewing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Answering value)? answering,
    TResult Function(Confirming value)? confirming,
    TResult Function(SelfScoring value)? selfScoring,
    TResult Function(Reviewing value)? reviewing,
    TResult Function(Idling value)? idling,
    TResult Function(Finished value)? finished,
    required TResult orElse(),
  }) {
    if (reviewing != null) {
      return reviewing(this);
    }
    return orElse();
  }
}

abstract class Reviewing implements AnswerWorkbookState {
  const factory Reviewing({required final Question question}) = _$Reviewing;

  Question get question;
  @JsonKey(ignore: true)
  _$$ReviewingCopyWith<_$Reviewing> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$IdlingCopyWith<$Res> {
  factory _$$IdlingCopyWith(_$Idling value, $Res Function(_$Idling) then) =
      __$$IdlingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$IdlingCopyWithImpl<$Res>
    extends _$AnswerWorkbookStateCopyWithImpl<$Res, _$Idling>
    implements _$$IdlingCopyWith<$Res> {
  __$$IdlingCopyWithImpl(_$Idling _value, $Res Function(_$Idling) _then)
      : super(_value, _then);
}

/// @nodoc

class _$Idling implements Idling {
  const _$Idling();

  @override
  String toString() {
    return 'AnswerWorkbookState.idling()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Idling);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Question question) answering,
    required TResult Function(Question question) confirming,
    required TResult Function(Question question) selfScoring,
    required TResult Function(Question question) reviewing,
    required TResult Function() idling,
    required TResult Function() finished,
  }) {
    return idling();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Question question)? answering,
    TResult? Function(Question question)? confirming,
    TResult? Function(Question question)? selfScoring,
    TResult? Function(Question question)? reviewing,
    TResult? Function()? idling,
    TResult? Function()? finished,
  }) {
    return idling?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Question question)? answering,
    TResult Function(Question question)? confirming,
    TResult Function(Question question)? selfScoring,
    TResult Function(Question question)? reviewing,
    TResult Function()? idling,
    TResult Function()? finished,
    required TResult orElse(),
  }) {
    if (idling != null) {
      return idling();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Answering value) answering,
    required TResult Function(Confirming value) confirming,
    required TResult Function(SelfScoring value) selfScoring,
    required TResult Function(Reviewing value) reviewing,
    required TResult Function(Idling value) idling,
    required TResult Function(Finished value) finished,
  }) {
    return idling(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Answering value)? answering,
    TResult? Function(Confirming value)? confirming,
    TResult? Function(SelfScoring value)? selfScoring,
    TResult? Function(Reviewing value)? reviewing,
    TResult? Function(Idling value)? idling,
    TResult? Function(Finished value)? finished,
  }) {
    return idling?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Answering value)? answering,
    TResult Function(Confirming value)? confirming,
    TResult Function(SelfScoring value)? selfScoring,
    TResult Function(Reviewing value)? reviewing,
    TResult Function(Idling value)? idling,
    TResult Function(Finished value)? finished,
    required TResult orElse(),
  }) {
    if (idling != null) {
      return idling(this);
    }
    return orElse();
  }
}

abstract class Idling implements AnswerWorkbookState {
  const factory Idling() = _$Idling;
}

/// @nodoc
abstract class _$$FinishedCopyWith<$Res> {
  factory _$$FinishedCopyWith(
          _$Finished value, $Res Function(_$Finished) then) =
      __$$FinishedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FinishedCopyWithImpl<$Res>
    extends _$AnswerWorkbookStateCopyWithImpl<$Res, _$Finished>
    implements _$$FinishedCopyWith<$Res> {
  __$$FinishedCopyWithImpl(_$Finished _value, $Res Function(_$Finished) _then)
      : super(_value, _then);
}

/// @nodoc

class _$Finished implements Finished {
  const _$Finished();

  @override
  String toString() {
    return 'AnswerWorkbookState.finished()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Finished);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Question question) answering,
    required TResult Function(Question question) confirming,
    required TResult Function(Question question) selfScoring,
    required TResult Function(Question question) reviewing,
    required TResult Function() idling,
    required TResult Function() finished,
  }) {
    return finished();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Question question)? answering,
    TResult? Function(Question question)? confirming,
    TResult? Function(Question question)? selfScoring,
    TResult? Function(Question question)? reviewing,
    TResult? Function()? idling,
    TResult? Function()? finished,
  }) {
    return finished?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Question question)? answering,
    TResult Function(Question question)? confirming,
    TResult Function(Question question)? selfScoring,
    TResult Function(Question question)? reviewing,
    TResult Function()? idling,
    TResult Function()? finished,
    required TResult orElse(),
  }) {
    if (finished != null) {
      return finished();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Answering value) answering,
    required TResult Function(Confirming value) confirming,
    required TResult Function(SelfScoring value) selfScoring,
    required TResult Function(Reviewing value) reviewing,
    required TResult Function(Idling value) idling,
    required TResult Function(Finished value) finished,
  }) {
    return finished(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Answering value)? answering,
    TResult? Function(Confirming value)? confirming,
    TResult? Function(SelfScoring value)? selfScoring,
    TResult? Function(Reviewing value)? reviewing,
    TResult? Function(Idling value)? idling,
    TResult? Function(Finished value)? finished,
  }) {
    return finished?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Answering value)? answering,
    TResult Function(Confirming value)? confirming,
    TResult Function(SelfScoring value)? selfScoring,
    TResult Function(Reviewing value)? reviewing,
    TResult Function(Idling value)? idling,
    TResult Function(Finished value)? finished,
    required TResult orElse(),
  }) {
    if (finished != null) {
      return finished(this);
    }
    return orElse();
  }
}

abstract class Finished implements AnswerWorkbookState {
  const factory Finished() = _$Finished;
}
