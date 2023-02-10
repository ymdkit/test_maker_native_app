// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_question.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class RealmQuestion extends _RealmQuestion
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  RealmQuestion(
    String questionId,
    int questionType,
    String problem,
    bool isAutoGenerateWrongChoices,
    bool isCheckAnswerOrder, {
    String? problemImageUrl,
    String? explanation,
    String? explanationImageUrl,
    int answerStatus = 0,
    Iterable<String> answers = const [],
    Iterable<String> wrongChoices = const [],
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<RealmQuestion>({
        'answerStatus': 0,
      });
    }
    RealmObjectBase.set(this, 'questionId', questionId);
    RealmObjectBase.set(this, 'questionType', questionType);
    RealmObjectBase.set(this, 'problem', problem);
    RealmObjectBase.set(this, 'problemImageUrl', problemImageUrl);
    RealmObjectBase.set(this, 'explanation', explanation);
    RealmObjectBase.set(this, 'explanationImageUrl', explanationImageUrl);
    RealmObjectBase.set(
        this, 'isAutoGenerateWrongChoices', isAutoGenerateWrongChoices);
    RealmObjectBase.set(this, 'isCheckAnswerOrder', isCheckAnswerOrder);
    RealmObjectBase.set(this, 'answerStatus', answerStatus);
    RealmObjectBase.set<RealmList<String>>(
        this, 'answers', RealmList<String>(answers));
    RealmObjectBase.set<RealmList<String>>(
        this, 'wrongChoices', RealmList<String>(wrongChoices));
  }

  RealmQuestion._();

  @override
  String get questionId =>
      RealmObjectBase.get<String>(this, 'questionId') as String;
  @override
  set questionId(String value) =>
      RealmObjectBase.set(this, 'questionId', value);

  @override
  int get questionType => RealmObjectBase.get<int>(this, 'questionType') as int;
  @override
  set questionType(int value) =>
      RealmObjectBase.set(this, 'questionType', value);

  @override
  String get problem => RealmObjectBase.get<String>(this, 'problem') as String;
  @override
  set problem(String value) => RealmObjectBase.set(this, 'problem', value);

  @override
  String? get problemImageUrl =>
      RealmObjectBase.get<String>(this, 'problemImageUrl') as String?;
  @override
  set problemImageUrl(String? value) =>
      RealmObjectBase.set(this, 'problemImageUrl', value);

  @override
  RealmList<String> get answers =>
      RealmObjectBase.get<String>(this, 'answers') as RealmList<String>;
  @override
  set answers(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<String> get wrongChoices =>
      RealmObjectBase.get<String>(this, 'wrongChoices') as RealmList<String>;
  @override
  set wrongChoices(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  String? get explanation =>
      RealmObjectBase.get<String>(this, 'explanation') as String?;
  @override
  set explanation(String? value) =>
      RealmObjectBase.set(this, 'explanation', value);

  @override
  String? get explanationImageUrl =>
      RealmObjectBase.get<String>(this, 'explanationImageUrl') as String?;
  @override
  set explanationImageUrl(String? value) =>
      RealmObjectBase.set(this, 'explanationImageUrl', value);

  @override
  bool get isAutoGenerateWrongChoices =>
      RealmObjectBase.get<bool>(this, 'isAutoGenerateWrongChoices') as bool;
  @override
  set isAutoGenerateWrongChoices(bool value) =>
      RealmObjectBase.set(this, 'isAutoGenerateWrongChoices', value);

  @override
  bool get isCheckAnswerOrder =>
      RealmObjectBase.get<bool>(this, 'isCheckAnswerOrder') as bool;
  @override
  set isCheckAnswerOrder(bool value) =>
      RealmObjectBase.set(this, 'isCheckAnswerOrder', value);

  @override
  int get answerStatus => RealmObjectBase.get<int>(this, 'answerStatus') as int;
  @override
  set answerStatus(int value) =>
      RealmObjectBase.set(this, 'answerStatus', value);

  @override
  Stream<RealmObjectChanges<RealmQuestion>> get changes =>
      RealmObjectBase.getChanges<RealmQuestion>(this);

  @override
  RealmQuestion freeze() => RealmObjectBase.freezeObject<RealmQuestion>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(RealmQuestion._);
    return const SchemaObject(
        ObjectType.realmObject, RealmQuestion, 'RealmQuestion', [
      SchemaProperty('questionId', RealmPropertyType.string),
      SchemaProperty('questionType', RealmPropertyType.int),
      SchemaProperty('problem', RealmPropertyType.string),
      SchemaProperty('problemImageUrl', RealmPropertyType.string,
          optional: true),
      SchemaProperty('answers', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('wrongChoices', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('explanation', RealmPropertyType.string, optional: true),
      SchemaProperty('explanationImageUrl', RealmPropertyType.string,
          optional: true),
      SchemaProperty('isAutoGenerateWrongChoices', RealmPropertyType.bool),
      SchemaProperty('isCheckAnswerOrder', RealmPropertyType.bool),
      SchemaProperty('answerStatus', RealmPropertyType.int),
    ]);
  }
}
