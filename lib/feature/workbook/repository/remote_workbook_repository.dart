import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';
import 'package:test_maker_native_app/data/remote/firestore_converting.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/feature/workbook/repository/workbook_repository.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

class RemoteWorkbookRepository implements WorkbookRepository {
  RemoteWorkbookRepository({
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
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<AppException, List<Workbook>>> getWorkbooks({
    required String? folderId,
  }) async {
    return TaskEither.tryCatch(
      () {
        final userId = auth.currentUser!.uid;
        return remoteDB
            .collection('tests')
            .where('userId', isEqualTo: userId)
            .get()
            .then(
              (value) =>
                  value.docs.map((e) => documentToWorkbook(userId, e)).toList(),
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
            .where('isDeleted', isNotEqualTo: null)
            .get()
            .then(
              (value) =>
                  value.docs.map((e) => documentToWorkbook(userId, e)).toList(),
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
          'isDeleted': true,
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
            .where('isDeleted', isEqualTo: true)
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
          'isDeleted': false,
          'userId': user.uid,
          'userName': user.displayName,
          'updatedAt': Timestamp.now(),
        });
      },
      (e, stack) => AppException.fromRawException(e: e),
    ).run();
  }
}
