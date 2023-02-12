// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_schema.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class RealmQuestion extends _RealmQuestion
    with RealmEntity, RealmObjectBase, RealmObject {
  RealmQuestion(
    String questionId,
    int questionType,
    String problem,
    String answer,
    bool isAutoGenerateWrongChoices,
    bool isCheckAnswerOrder,
    int order,
    String answerStatus, {
    String? problemImageUrl,
    String? explanation,
    String? explanationImageUrl,
    Iterable<String> answers = const [],
    Iterable<String> wrongChoices = const [],
  }) {
    RealmObjectBase.set(this, 'questionId', questionId);
    RealmObjectBase.set(this, 'questionType', questionType);
    RealmObjectBase.set(this, 'problem', problem);
    RealmObjectBase.set(this, 'problemImageUrl', problemImageUrl);
    RealmObjectBase.set(this, 'answer', answer);
    RealmObjectBase.set(this, 'explanation', explanation);
    RealmObjectBase.set(this, 'explanationImageUrl', explanationImageUrl);
    RealmObjectBase.set(
        this, 'isAutoGenerateWrongChoices', isAutoGenerateWrongChoices);
    RealmObjectBase.set(this, 'isCheckAnswerOrder', isCheckAnswerOrder);
    RealmObjectBase.set(this, 'order', order);
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
  String get answer => RealmObjectBase.get<String>(this, 'answer') as String;
  @override
  set answer(String value) => RealmObjectBase.set(this, 'answer', value);

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
  int get order => RealmObjectBase.get<int>(this, 'order') as int;
  @override
  set order(int value) => RealmObjectBase.set(this, 'order', value);

  @override
  String get answerStatus =>
      RealmObjectBase.get<String>(this, 'answerStatus') as String;
  @override
  set answerStatus(String value) =>
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
        ObjectType.realmObject, RealmQuestion, 'Question', [
      SchemaProperty('questionId', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('questionType', RealmPropertyType.int),
      SchemaProperty('problem', RealmPropertyType.string),
      SchemaProperty('problemImageUrl', RealmPropertyType.string,
          optional: true),
      SchemaProperty('answer', RealmPropertyType.string),
      SchemaProperty('answers', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('wrongChoices', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('explanation', RealmPropertyType.string, optional: true),
      SchemaProperty('explanationImageUrl', RealmPropertyType.string,
          optional: true),
      SchemaProperty('isAutoGenerateWrongChoices', RealmPropertyType.bool),
      SchemaProperty('isCheckAnswerOrder', RealmPropertyType.bool),
      SchemaProperty('order', RealmPropertyType.int),
      SchemaProperty('answerStatus', RealmPropertyType.string),
    ]);
  }
}

class RealmWorkbook extends _RealmWorkbook
    with RealmEntity, RealmObjectBase, RealmObject {
  RealmWorkbook(
    String workbookId,
    String title,
    int order,
    int color, {
    String? folderId,
    Iterable<RealmQuestion> questions = const [],
  }) {
    RealmObjectBase.set(this, 'workbookId', workbookId);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'order', order);
    RealmObjectBase.set(this, 'color', color);
    RealmObjectBase.set(this, 'folderId', folderId);
    RealmObjectBase.set<RealmList<RealmQuestion>>(
        this, 'questions', RealmList<RealmQuestion>(questions));
  }

  RealmWorkbook._();

  @override
  String get workbookId =>
      RealmObjectBase.get<String>(this, 'workbookId') as String;
  @override
  set workbookId(String value) =>
      RealmObjectBase.set(this, 'workbookId', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  int get order => RealmObjectBase.get<int>(this, 'order') as int;
  @override
  set order(int value) => RealmObjectBase.set(this, 'order', value);

  @override
  int get color => RealmObjectBase.get<int>(this, 'color') as int;
  @override
  set color(int value) => RealmObjectBase.set(this, 'color', value);

  @override
  String? get folderId =>
      RealmObjectBase.get<String>(this, 'folderId') as String?;
  @override
  set folderId(String? value) => RealmObjectBase.set(this, 'folderId', value);

  @override
  RealmList<RealmQuestion> get questions =>
      RealmObjectBase.get<RealmQuestion>(this, 'questions')
          as RealmList<RealmQuestion>;
  @override
  set questions(covariant RealmList<RealmQuestion> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<RealmWorkbook>> get changes =>
      RealmObjectBase.getChanges<RealmWorkbook>(this);

  @override
  RealmWorkbook freeze() => RealmObjectBase.freezeObject<RealmWorkbook>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(RealmWorkbook._);
    return const SchemaObject(ObjectType.realmObject, RealmWorkbook, 'Test', [
      SchemaProperty('workbookId', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('order', RealmPropertyType.int),
      SchemaProperty('color', RealmPropertyType.int),
      SchemaProperty('folderId', RealmPropertyType.string, optional: true),
      SchemaProperty('questions', RealmPropertyType.object,
          linkTarget: 'Question', collectionType: RealmCollectionType.list),
    ]);
  }
}

class RealmFolder extends _RealmFolder
    with RealmEntity, RealmObjectBase, RealmObject {
  RealmFolder(
    String folderId,
    String title,
    int order,
    int color,
  ) {
    RealmObjectBase.set(this, 'folderId', folderId);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'order', order);
    RealmObjectBase.set(this, 'color', color);
  }

  RealmFolder._();

  @override
  String get folderId =>
      RealmObjectBase.get<String>(this, 'folderId') as String;
  @override
  set folderId(String value) => RealmObjectBase.set(this, 'folderId', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  int get order => RealmObjectBase.get<int>(this, 'order') as int;
  @override
  set order(int value) => RealmObjectBase.set(this, 'order', value);

  @override
  int get color => RealmObjectBase.get<int>(this, 'color') as int;
  @override
  set color(int value) => RealmObjectBase.set(this, 'color', value);

  @override
  Stream<RealmObjectChanges<RealmFolder>> get changes =>
      RealmObjectBase.getChanges<RealmFolder>(this);

  @override
  RealmFolder freeze() => RealmObjectBase.freezeObject<RealmFolder>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(RealmFolder._);
    return const SchemaObject(ObjectType.realmObject, RealmFolder, 'Category', [
      SchemaProperty('folderId', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('order', RealmPropertyType.int),
      SchemaProperty('color', RealmPropertyType.int),
    ]);
  }
}
