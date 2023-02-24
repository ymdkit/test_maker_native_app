import 'package:dartx/dartx.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:realm/realm.dart' hide AppException;
import 'package:test_maker_native_app/constants/color_theme.dart';
import 'package:test_maker_native_app/data/local/realm.dart';
import 'package:test_maker_native_app/data/local/realm_model_converting_ext.dart';
import 'package:test_maker_native_app/data/local/realm_schema.dart';
import 'package:test_maker_native_app/feature/folder/model/folder.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

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

  Future<Either<AppException, Folder>> addFolder({
    required String title,
    required AppThemeColor color,
  }) async {
    final newOrder =
        (localDB.all<RealmFolder>().maxBy((e) => e.order)?.order ?? 0) + 1;

    final folder = Folder(
      folderId: Uuid.v4().toString(),
      title: title,
      order: newOrder,
      color: color,
      workbookCount: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    localDB.write(() {
      localDB.add<RealmFolder>(
        RealmFolderConverting.fromFolder(folder),
      );
    });

    return Right(folder);
  }

  Future<Either<AppException, List<Folder>>> getFolders() async {
    return Right(
      localDB.all<RealmFolder>().where((e) => e.isDeleted != true).map((e) {
        final workbookCount = localDB
            .all<RealmWorkbook>()
            .where((element) => element.folderId == e.folderId)
            .length;

        return e.toFolder(
          workbookCount: workbookCount,
        );
      }).toList(),
    );
  }

  Future<Either<AppException, List<Folder>>> getDeletedFolders() async {
    return Right(
        localDB.all<RealmFolder>().where((e) => e.isDeleted == true).map((e) {
      final workbookCount = localDB
          .all<RealmWorkbook>()
          .where((e) => e.isDeleted != true)
          .where((element) => element.folderId == e.folderId)
          .length;

      return e.toFolder(
        workbookCount: workbookCount,
      );
    }).toList(growable: false));
  }

  Future<Either<AppException, void>> updateFolder(Folder folder) async {
    localDB.write(() {
      localDB.add<RealmFolder>(
        RealmFolderConverting.fromFolder(
          folder.copyWith(
            updatedAt: DateTime.now(),
          ),
        ),
        update: true,
      );
    });
    return const Right(null);
  }

  Future<Either<AppException, void>> deleteFolder(Folder folder) async {
    localDB.write(() {
      localDB.add<RealmFolder>(
        RealmFolderConverting.fromFolder(folder)..isDeleted = true,
        update: true,
      );
    });
    return const Right(null);
  }

  Future<Either<AppException, void>> destroyFolders(
      List<Folder> folders) async {
    localDB.write(
      () {
        final targets = localDB.all<RealmFolder>().where((e) {
          return folders.any((element) => element.folderId == e.folderId);
        });
        localDB.deleteMany(targets);
      },
    );
    return const Right(null);
  }

  Future<Either<AppException, void>> restoreFolder(Folder folder) async {
    localDB.write(() {
      localDB.add<RealmFolder>(
        RealmFolderConverting.fromFolder(folder)..isDeleted = false,
        update: true,
      );
    });
    return const Right(null);
  }
}
