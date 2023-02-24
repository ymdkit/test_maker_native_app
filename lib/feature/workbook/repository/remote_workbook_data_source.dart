import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';
import 'package:test_maker_native_app/data/remote/firebase_auth.dart';
import 'package:test_maker_native_app/data/remote/firestore.dart';
import 'package:test_maker_native_app/data/remote/firestore_converting.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

final remoteWorkbookDataSourceProvider = Provider<RemoteWorkbookDataSource>(
  (ref) => RemoteWorkbookDataSource(
    auth: ref.watch(firebaseAuthProvider),
    remoteDB: ref.watch(firestoreProvider),
  ),
);

class RemoteWorkbookDataSource {
  RemoteWorkbookDataSource({
    required this.auth,
    required this.remoteDB,
  });

  final FirebaseAuth auth;
  final FirebaseFirestore remoteDB;

  Future<Either<AppException, Workbook>> addWorkbook({
    required String title,
    required AppThemeColor color,
    required String? folderId,
  }) {
    throw UnimplementedError();
  }

  Future<Either<AppException, List<Workbook>>> getWorkbooks() async {
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

  List<Workbook> getDeletedWorkbooks() {
    throw UnimplementedError();
  }

  Future<Either<AppException, void>> updateWorkbook(Workbook workbook) {
    throw UnimplementedError();
  }

  void deleteWorkbook(Workbook workbook) {
    throw UnimplementedError();
  }

  void destroyWorkbooks(List<Workbook> workbooks) {
    throw UnimplementedError();
  }

  void restoreWorkbook(Workbook workbook) {
    throw UnimplementedError();
  }
}
