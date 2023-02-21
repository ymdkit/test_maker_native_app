import 'package:dartx/dartx.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:test_maker_native_app/data/local/realm.dart';
import 'package:test_maker_native_app/data/local/realm_model_converting_ext.dart';
import 'package:test_maker_native_app/data/local/realm_schema.dart';
import 'package:test_maker_native_app/model/enum/color_theme.dart';
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
    required AppThemeColor color,
    required String? folderId,
  }) {
    final newOrder =
        (localDB.all<RealmWorkbook>().maxBy((e) => e.order)?.order ?? 0) + 1;

    final workbook = Workbook(
      workbookId: Uuid.v4().toString(),
      title: title,
      order: newOrder,
      color: color,
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
        .where((e) => e.isDeleted != true)
        .where((e) => e.folderId == folderId)
        .map(
      (e) {
        final questionCount = localDB
            .all<RealmQuestion>()
            .where((e) => e.isDeleted != true)
            .where((element) => element.workbookId == e.workbookId)
            .length;
        return e.toWorkbook(questionCount: questionCount);
      },
    ).toList();
  }

  List<Workbook> getDeletedWorkbooks() {
    return localDB.all<RealmWorkbook>().where((e) => e.isDeleted == true).map(
      (e) {
        final questionCount = localDB
            .all<RealmQuestion>()
            .where((element) => element.workbookId == e.workbookId)
            .length;
        return e.toWorkbook(questionCount: questionCount);
      },
    ).toList();
  }

  void updateWorkbook(Workbook workbook) {
    localDB.write(() {
      localDB.add<RealmWorkbook>(
        RealmWorkbookConverting.fromWorkbook(workbook),
        update: true,
      );
    });
  }

  void deleteWorkbook(Workbook workbook) {
    localDB.write(() {
      localDB.add<RealmWorkbook>(
        RealmWorkbookConverting.fromWorkbook(workbook)..isDeleted = true,
        update: true,
      );
    });
  }

  void destroyWorkbooks(List<Workbook> workbooks) {
    localDB.write(() {
      final targets = localDB.all<RealmWorkbook>().where((e) {
        return workbooks.any((element) => element.workbookId == e.workbookId);
      });
      localDB.deleteMany(targets);
    });
  }

  void restoreWorkbook(Workbook workbook) {
    localDB.write(() {
      localDB.add<RealmWorkbook>(
        RealmWorkbookConverting.fromWorkbook(workbook)..isDeleted = false,
        update: true,
      );
    });
  }
}
