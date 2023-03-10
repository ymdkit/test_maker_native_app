// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_schema.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class RealmQuestion extends _RealmQuestion
    with RealmEntity, RealmObjectBase, RealmObject {
  RealmQuestion(
    String questionId,
    String workbookId,
    int questionType,
    String problem,
    String answer,
    bool isAutoGenerateWrongChoices,
    bool isCheckAnswerOrder,
    int order,
    String answerStatus,
    DateTime createdAt,
    DateTime updatedAt, {
    String? problemImageUrl,
    String? explanation,
    String? explanationImageUrl,
    bool? isDeleted,
    DateTime? lastAnsweredAt,
    Iterable<String> answers = const [],
    Iterable<String> wrongChoices = const [],
  }) {
    RealmObjectBase.set(this, 'questionId', questionId);
    RealmObjectBase.set(this, 'workbookId', workbookId);
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
    RealmObjectBase.set(this, 'isDeleted', isDeleted);
    RealmObjectBase.set(this, 'createdAt', createdAt);
    RealmObjectBase.set(this, 'updatedAt', updatedAt);
    RealmObjectBase.set(this, 'lastAnsweredAt', lastAnsweredAt);
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
  String get workbookId =>
      RealmObjectBase.get<String>(this, 'workbookId') as String;
  @override
  set workbookId(String value) =>
      RealmObjectBase.set(this, 'workbookId', value);

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
  bool? get isDeleted => RealmObjectBase.get<bool>(this, 'isDeleted') as bool?;
  @override
  set isDeleted(bool? value) => RealmObjectBase.set(this, 'isDeleted', value);

  @override
  DateTime get createdAt =>
      RealmObjectBase.get<DateTime>(this, 'createdAt') as DateTime;
  @override
  set createdAt(DateTime value) =>
      RealmObjectBase.set(this, 'createdAt', value);

  @override
  DateTime get updatedAt =>
      RealmObjectBase.get<DateTime>(this, 'updatedAt') as DateTime;
  @override
  set updatedAt(DateTime value) =>
      RealmObjectBase.set(this, 'updatedAt', value);

  @override
  DateTime? get lastAnsweredAt =>
      RealmObjectBase.get<DateTime>(this, 'lastAnsweredAt') as DateTime?;
  @override
  set lastAnsweredAt(DateTime? value) =>
      RealmObjectBase.set(this, 'lastAnsweredAt', value);

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
      SchemaProperty('workbookId', RealmPropertyType.string),
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
      SchemaProperty('isDeleted', RealmPropertyType.bool, optional: true),
      SchemaProperty('createdAt', RealmPropertyType.timestamp),
      SchemaProperty('updatedAt', RealmPropertyType.timestamp),
      SchemaProperty('lastAnsweredAt', RealmPropertyType.timestamp,
          optional: true),
    ]);
  }
}

class RealmWorkbook extends _RealmWorkbook
    with RealmEntity, RealmObjectBase, RealmObject {
  RealmWorkbook(
    String workbookId,
    String title,
    int order,
    int color,
    DateTime createdAt,
    DateTime updatedAt, {
    String? folderId,
    bool? isDeleted,
  }) {
    RealmObjectBase.set(this, 'workbookId', workbookId);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'order', order);
    RealmObjectBase.set(this, 'color', color);
    RealmObjectBase.set(this, 'folderId', folderId);
    RealmObjectBase.set(this, 'isDeleted', isDeleted);
    RealmObjectBase.set(this, 'createdAt', createdAt);
    RealmObjectBase.set(this, 'updatedAt', updatedAt);
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
  bool? get isDeleted => RealmObjectBase.get<bool>(this, 'isDeleted') as bool?;
  @override
  set isDeleted(bool? value) => RealmObjectBase.set(this, 'isDeleted', value);

  @override
  DateTime get createdAt =>
      RealmObjectBase.get<DateTime>(this, 'createdAt') as DateTime;
  @override
  set createdAt(DateTime value) =>
      RealmObjectBase.set(this, 'createdAt', value);

  @override
  DateTime get updatedAt =>
      RealmObjectBase.get<DateTime>(this, 'updatedAt') as DateTime;
  @override
  set updatedAt(DateTime value) =>
      RealmObjectBase.set(this, 'updatedAt', value);

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
      SchemaProperty('isDeleted', RealmPropertyType.bool, optional: true),
      SchemaProperty('createdAt', RealmPropertyType.timestamp),
      SchemaProperty('updatedAt', RealmPropertyType.timestamp),
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
    DateTime createdAt,
    DateTime updatedAt, {
    bool? isDeleted,
  }) {
    RealmObjectBase.set(this, 'folderId', folderId);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'order', order);
    RealmObjectBase.set(this, 'color', color);
    RealmObjectBase.set(this, 'isDeleted', isDeleted);
    RealmObjectBase.set(this, 'createdAt', createdAt);
    RealmObjectBase.set(this, 'updatedAt', updatedAt);
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
  bool? get isDeleted => RealmObjectBase.get<bool>(this, 'isDeleted') as bool?;
  @override
  set isDeleted(bool? value) => RealmObjectBase.set(this, 'isDeleted', value);

  @override
  DateTime get createdAt =>
      RealmObjectBase.get<DateTime>(this, 'createdAt') as DateTime;
  @override
  set createdAt(DateTime value) =>
      RealmObjectBase.set(this, 'createdAt', value);

  @override
  DateTime get updatedAt =>
      RealmObjectBase.get<DateTime>(this, 'updatedAt') as DateTime;
  @override
  set updatedAt(DateTime value) =>
      RealmObjectBase.set(this, 'updatedAt', value);

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
      SchemaProperty('isDeleted', RealmPropertyType.bool, optional: true),
      SchemaProperty('createdAt', RealmPropertyType.timestamp),
      SchemaProperty('updatedAt', RealmPropertyType.timestamp),
    ]);
  }
}

class RealmAnswerHistory extends _RealmAnswerHistory
    with RealmEntity, RealmObjectBase, RealmObject {
  RealmAnswerHistory(
    String answerHistoryId,
    String questionId,
    String workbookId,
    bool isCorrect,
    DateTime createdAt,
  ) {
    RealmObjectBase.set(this, 'answerHistoryId', answerHistoryId);
    RealmObjectBase.set(this, 'questionId', questionId);
    RealmObjectBase.set(this, 'workbookId', workbookId);
    RealmObjectBase.set(this, 'isCorrect', isCorrect);
    RealmObjectBase.set(this, 'createdAt', createdAt);
  }

  RealmAnswerHistory._();

  @override
  String get answerHistoryId =>
      RealmObjectBase.get<String>(this, 'answerHistoryId') as String;
  @override
  set answerHistoryId(String value) =>
      RealmObjectBase.set(this, 'answerHistoryId', value);

  @override
  String get questionId =>
      RealmObjectBase.get<String>(this, 'questionId') as String;
  @override
  set questionId(String value) =>
      RealmObjectBase.set(this, 'questionId', value);

  @override
  String get workbookId =>
      RealmObjectBase.get<String>(this, 'workbookId') as String;
  @override
  set workbookId(String value) =>
      RealmObjectBase.set(this, 'workbookId', value);

  @override
  bool get isCorrect => RealmObjectBase.get<bool>(this, 'isCorrect') as bool;
  @override
  set isCorrect(bool value) => RealmObjectBase.set(this, 'isCorrect', value);

  @override
  DateTime get createdAt =>
      RealmObjectBase.get<DateTime>(this, 'createdAt') as DateTime;
  @override
  set createdAt(DateTime value) =>
      RealmObjectBase.set(this, 'createdAt', value);

  @override
  Stream<RealmObjectChanges<RealmAnswerHistory>> get changes =>
      RealmObjectBase.getChanges<RealmAnswerHistory>(this);

  @override
  RealmAnswerHistory freeze() =>
      RealmObjectBase.freezeObject<RealmAnswerHistory>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(RealmAnswerHistory._);
    return const SchemaObject(
        ObjectType.realmObject, RealmAnswerHistory, 'RealmAnswerHistory', [
      SchemaProperty('answerHistoryId', RealmPropertyType.string,
          primaryKey: true),
      SchemaProperty('questionId', RealmPropertyType.string),
      SchemaProperty('workbookId', RealmPropertyType.string),
      SchemaProperty('isCorrect', RealmPropertyType.bool),
      SchemaProperty('createdAt', RealmPropertyType.timestamp),
    ]);
  }
}
