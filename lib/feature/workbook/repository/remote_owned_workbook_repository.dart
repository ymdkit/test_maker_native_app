import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:realm/realm.dart' hide AppException;
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';
import 'package:test_maker_native_app/data/remote/firestore_converting.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/feature/workbook/repository/workbook_repository.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

class RemoteOwnedWorkbookRepository implements WorkbookRepository {
  RemoteOwnedWorkbookRepository({
    required this.auth,
    required this.remoteDB,
  });

  final FirebaseAuth auth;
  final FirebaseFirestore remoteDB;

  @override
  Future<Either<AppException, Workbook>> addWorkbook({
    required String title,
    required AppThemeColor color,
    required String? folderId,
  }) async {
    return TaskEither.tryCatch(
      () {
        final user = auth.currentUser!;
        final workbookId = Uuid.v4().toString();
        final workbook = Workbook(
          workbookId: workbookId,
          title: title,
          color: color,
          folderId: folderId,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          order: -1,
          location: AppDataLocation.remoteOwned,
          questionCount: 0,
        );
        return remoteDB.collection('tests').doc(workbookId).set({
          'documentId': workbookId,
          'groupId': '',
          'name': workbook.title,
          'color': workbook.color.index,
          'size': workbook.questionCount,
          'created_at': Timestamp.now(),
          'updated_at': Timestamp.now(),
          'order': workbook.order,
          'userId': user.uid,
          'userName': user.displayName,
          //TODO: 動的に設定する
          'public': false,
        }).then((value) => workbook);
      },
      (e, stack) => AppException.fromRawException(e: e),
    ).run();
  }

  @override
  Future<Either<AppException, List<Workbook>>> getWorkbooks({
    required String? folderId,
  }) async {
    return TaskEither.tryCatch(
      () {
        final userId = auth.currentUser?.uid;

        if (userId == null) {
          return Future.value(List<Workbook>.empty());
        }

        return remoteDB
            .collection('tests')
            .where('userId', isEqualTo: userId)
            .get()
            .then(
              (value) => value.docs
                  .where((e) => !e.data().keys.contains('deleted'))
                  .map((e) => documentToWorkbook(userId, e))
                  .toList(),
            );
      },
      (e, stack) => AppException.fromRawException(e: e),
    ).run();
  }

  @override
  Future<Either<AppException, List<Workbook>>> getDeletedWorkbooks() async {
    return TaskEither.tryCatch(
      () {
        final userId = auth.currentUser!.uid;
        return remoteDB
            .collection('tests')
            .where('userId', isEqualTo: userId)
            .get()
            .then(
          (value) {
            return value.docs
                .where((e) => e.data().keys.contains('deleted'))
                .map((e) => documentToWorkbook(userId, e))
                .toList();
          },
        );
      },
      (e, stack) => AppException.fromRawException(e: e),
    ).run();
  }

  @override
  Future<Either<AppException, void>> updateWorkbook(Workbook workbook) async {
    return TaskEither.tryCatch(
      () {
        final user = auth.currentUser!;
        return remoteDB.collection('tests').doc(workbook.workbookId).update({
          'name': workbook.title,
          'color': workbook.color.index,
          'size': workbook.questionCount,
          'userId': user.uid,
          'userName': user.displayName,
          'updatedAt': Timestamp.now(),
        });
      },
      (e, stack) => AppException.fromRawException(e: e),
    ).run();
  }

  @override
  Future<Either<AppException, void>> deleteWorkbook(Workbook workbook) async {
    return TaskEither.tryCatch(
      () {
        final user = auth.currentUser!;
        return remoteDB.collection('tests').doc(workbook.workbookId).update({
          'deleted': true,
          'userId': user.uid,
          'userName': user.displayName,
          'updatedAt': Timestamp.now(),
        });
      },
      (e, stack) => AppException.fromRawException(e: e),
    ).run();
  }

  @override
  Future<Either<AppException, void>> destroyWorkbooks(
      List<Workbook> workbooks) async {
    return TaskEither.tryCatch(
      () {
        final user = auth.currentUser!;
        return remoteDB
            .collection('tests')
            .where('userId', isEqualTo: user.uid)
            .where('deleted', isEqualTo: true)
            .get()
            .then((value) {
          final batch = remoteDB.batch();
          for (final element in value.docs) {
            batch.delete(element.reference);
          }
          return batch.commit();
        });
      },
      (e, stack) => AppException.fromRawException(e: e),
    ).run();
  }

  @override
  Future<Either<AppException, void>> restoreWorkbook(Workbook workbook) async {
    return TaskEither.tryCatch(
      () {
        final user = auth.currentUser!;
        return remoteDB.collection('tests').doc(workbook.workbookId).update({
          'deleted': false,
          'userId': user.uid,
          'userName': user.displayName,
          'updatedAt': Timestamp.now(),
        });
      },
      (e, stack) => AppException.fromRawException(e: e),
    ).run();
  }

  @override
  Future<Either<AppException, void>> linkToGroup({
    required String groupId,
    required Workbook workbook,
  }) async {
    return TaskEither.tryCatch(
      () {
        return remoteDB.collection('tests').doc(workbook.workbookId).update({
          'groupId': groupId,
        });
      },
      (e, stack) => AppException.fromRawException(e: e),
    ).run();
  }
}
