import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartx/dartx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:realm/realm.dart' hide AppException;
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';
import 'package:test_maker_native_app/data/remote/firestore_converting.dart';
import 'package:test_maker_native_app/feature/folder/model/folder.dart';
import 'package:test_maker_native_app/feature/folder/repository/folder_repository.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

class RemoteOwnedFolderRepository implements FolderRepository {
  RemoteOwnedFolderRepository({
    required this.remoteDB,
    required this.auth,
  });

  final FirebaseFirestore remoteDB;
  final FirebaseAuth auth;

  @override
  Future<Either<AppException, Folder>> addFolder({
    required String title,
    required AppThemeColor color,
  }) async {
    return TaskEither.tryCatch(
      () async {
        final folder = Folder(
          folderId: Uuid.v4().toString(),
          title: title,
          order: -1,
          color: color,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          workbookCount: 0,
          location: AppDataLocation.remoteOwned,
        );

        await remoteDB.collection('folders').doc(folder.folderId).set({
          'folderId': folder.folderId,
          'name': folder.title,
          'color': folder.color.index,
          'userId': auth.currentUser!.uid,
          'userName': auth.currentUser!.displayName,
          'size': folder.workbookCount,
          'createdAt': folder.createdAt,
          'updatedAt': folder.updatedAt,
          //TODO: 動的に指定する
          'deleted': false,
          'public': false,
        });

        return folder;
      },
      (e, stack) => AppException.fromRawException(e: e),
    ).run();
  }

  @override
  Future<Either<AppException, List<Folder>>> getFolders() async {
    return TaskEither.tryCatch(
      () async {
        final user = auth.currentUser!;
        final snapshot = await remoteDB
            .collection('folders')
            .where('userId', isEqualTo: user.uid)
            .get();

        return snapshot.docs
            .where((e) => e.data().getOrElse('deleted', () => false) == false)
            .map((e) => documentToFolder(user.uid, e))
            .toList();
      },
      (e, stack) => AppException.fromRawException(e: e),
    ).run();
  }

  @override
  Future<Either<AppException, List<Folder>>> getDeletedFolders() async {
    return TaskEither.tryCatch(
      () async {
        final user = auth.currentUser!;
        final snapshot = await remoteDB
            .collection('folders')
            .where('userId', isEqualTo: user.uid)
            .get();

        return snapshot.docs
            .where((e) => e.data().getOrElse('deleted', () => false) == true)
            .map((e) => documentToFolder(user.uid, e))
            .toList();
      },
      (e, stack) => AppException.fromRawException(e: e),
    ).run();
  }

  @override
  Future<Either<AppException, void>> updateFolder(Folder folder) async {
    return TaskEither.tryCatch(
      () async {
        await remoteDB.collection('folders').doc(folder.folderId).update({
          'name': folder.title,
          'color': folder.color.index,
          'updatedAt': folder.updatedAt,
        });
      },
      (e, stack) => AppException.fromRawException(e: e),
    ).run();
  }

  @override
  Future<Either<AppException, void>> deleteFolder(Folder folder) async {
    return TaskEither.tryCatch(
      () async {
        await remoteDB.collection('folders').doc(folder.folderId).update({
          'deleted': true,
          'updatedAt': folder.updatedAt,
        });
      },
      (e, stack) => AppException.fromRawException(e: e),
    ).run();
  }

  @override
  Future<Either<AppException, void>> destroyFolders(
      List<Folder> folders) async {
    return TaskEither.tryCatch(
      () async {
        final batch = remoteDB.batch();
        for (final folder in folders) {
          batch.delete(remoteDB.collection('folders').doc(folder.folderId));
        }
        await batch.commit();
      },
      (e, stack) => AppException.fromRawException(e: e),
    ).run();
  }

  @override
  Future<Either<AppException, void>> restoreFolder(Folder folder) async {
    return TaskEither.tryCatch(
      () async {
        await remoteDB.collection('folders').doc(folder.folderId).update({
          'deleted': false,
          'updatedAt': folder.updatedAt,
        });
      },
      (e, stack) => AppException.fromRawException(e: e),
    ).run();
  }
}
