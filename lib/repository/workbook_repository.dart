import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:test_maker_native_app/data/local/realm.dart';
import 'package:test_maker_native_app/data/local/realm_model_converting_ext.dart';
import 'package:test_maker_native_app/data/local/realm_schema.dart';
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
    required int color,
    required String? folderId,
  }) {
    final newOrder = localDB
            .all<RealmWorkbook>()
            .map((e) => e.order)
            .reduce((value, element) => value > element ? value : element) +
        1;

    final workbook = Workbook(
      workbookId: Uuid.v4().toString(),
      title: title,
      order: newOrder,
      color: color,
      folderId: folderId,
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
        .map((e) => e.toWorkbook())
        .toList();
  }
}
