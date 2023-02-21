import 'package:dartx/dartx.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:test_maker_native_app/data/local/realm.dart';
import 'package:test_maker_native_app/data/local/realm_model_converting_ext.dart';
import 'package:test_maker_native_app/data/local/realm_schema.dart';
import 'package:test_maker_native_app/feature/folder/model/folder.dart';
import 'package:test_maker_native_app/model/enum/color_theme.dart';

final folderRepositoryProvider = Provider<FolderRepository>(
  (ref) => FolderRepository(
    localDB: ref.watch(realmProvider),
  ),
);

class FolderRepository {
  FolderRepository({
    required this.localDB,
  });

  final Realm localDB;

  Folder addFolder({
    required String title,
    required AppThemeColor color,
  }) {
    final newOrder =
        (localDB.all<RealmFolder>().maxBy((e) => e.order)?.order ?? 0) + 1;

    final folder = Folder(
      folderId: Uuid.v4().toString(),
      title: title,
      order: newOrder,
      color: color,
      workbookCount: 0,
    );

    localDB.write(() {
      localDB.add<RealmFolder>(
        RealmFolderConverting.fromFolder(folder),
      );
    });

    return folder;
  }

  List<Folder> getFolders() {
    return localDB
        .all<RealmFolder>()
        .where((e) => e.isDeleted != true)
        .map((e) {
      final workbookCount = localDB
          .all<RealmWorkbook>()
          .where((element) => element.folderId == e.folderId)
          .length;

      return e.toFolder(
        workbookCount: workbookCount,
      );
    }).toList(growable: false);
  }

  List<Folder> getDeletedFolders() {
    return localDB
        .all<RealmFolder>()
        .where((e) => e.isDeleted == true)
        .map((e) {
      final workbookCount = localDB
          .all<RealmWorkbook>()
          .where((e) => e.isDeleted != true)
          .where((element) => element.folderId == e.folderId)
          .length;

      return e.toFolder(
        workbookCount: workbookCount,
      );
    }).toList(growable: false);
  }

  void updateFolder(Folder folder) {
    localDB.write(() {
      localDB.add<RealmFolder>(
        RealmFolderConverting.fromFolder(folder),
        update: true,
      );
    });
  }

  void deleteFolder(Folder folder) {
    localDB.write(() {
      localDB.add<RealmFolder>(
        RealmFolderConverting.fromFolder(folder)..isDeleted = true,
        update: true,
      );
    });
  }

  void destroyFolders(List<Folder> folders) {
    localDB.write(
      () {
        final targets = localDB.all<RealmFolder>().where((e) {
          return folders.any((element) => element.folderId == e.folderId);
        });
        localDB.deleteMany(targets);
      },
    );
  }

  void restoreFolder(Folder folder) {
    localDB.write(() {
      localDB.add<RealmFolder>(
        RealmFolderConverting.fromFolder(folder)..isDeleted = false,
        update: true,
      );
    });
  }
}
