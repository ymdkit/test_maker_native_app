import 'package:dartx/dartx.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:test_maker_native_app/data/local/realm.dart';
import 'package:test_maker_native_app/data/local/realm_model_converting_ext.dart';
import 'package:test_maker_native_app/data/local/realm_schema.dart';
import 'package:test_maker_native_app/model/enum/color_theme.dart';
import 'package:test_maker_native_app/model/question.dart';
import 'package:test_maker_native_app/model/workbook.dart';

final workbookRepositoryProvider = Provider<WorkbookRepository>(
  (ref) => WorkbookRepository(
    localDB: ref.watch(realmProvider),
  ),
);

class WorkbookRepository {
  WorkbookRepository({
    required this.localDB,
  });

  final Realm localDB;

  Workbook addWorkbook({
    required String title,
    required ColorTheme color,
    required String? folderId,
  }) {
    final newOrder =
        (localDB.all<RealmWorkbook>().maxBy((e) => e.order)?.order ?? 0) + 1;

    final workbook = Workbook(
      workbookId: Uuid.v4().toString(),
      title: title,
      order: newOrder,
      color: color.index,
      folderId: folderId,
      questionCount: 0,
    );

    localDB.write(() {
      localDB.add<RealmWorkbook>(
        RealmWorkbookConverting.fromWorkbook(workbook),
      );
    });

    return workbook;
  }

  List<Workbook> getWorkbooks(String? folderId) {
    return localDB
        .all<RealmWorkbook>()
        .where((e) => e.folderId == folderId)
        .map(
      (e) {
        final questionCount = getQuestions(e.workbookId).length;
        return e.toWorkbook(questionCount: questionCount);
      },
    ).toList();
  }

  Workbook getWorkbook(String workbookId) {
    final realmWorkbook = localDB
        .all<RealmWorkbook>()
        .firstWhere((e) => e.workbookId == workbookId);

    final questionCount = getQuestions(realmWorkbook.workbookId).length;
    return realmWorkbook.toWorkbook(questionCount: questionCount);
  }

  List<Question> getQuestions(String workbookId) {
    return localDB
        .all<RealmQuestion>()
        .where((e) => e.workbookId == workbookId)
        .map((e) => e.toQuestion())
        .toList();
  }
}
