import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';
import 'package:test_maker_native_app/data/local/realm.dart';
import 'package:test_maker_native_app/data/remote/firebase_auth.dart';
import 'package:test_maker_native_app/data/remote/firestore.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/feature/workbook/repository/local_workbook_repository.dart';
import 'package:test_maker_native_app/feature/workbook/repository/remote_owned_workbook_repository.dart';
import 'package:test_maker_native_app/feature/workbook/repository/remote_shared_workbook_repository.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

final workbookRepositoryProvider =
    Provider.family<WorkbookRepository, AppDataLocation>((ref, location) {
  switch (location) {
    case AppDataLocation.local:
      return LocalWorkbookRepository(
        localDB: ref.watch(realmProvider),
        remoteDB: ref.watch(firestoreProvider),
        auth: ref.watch(firebaseAuthProvider),
      );
    case AppDataLocation.remoteOwned:
      return RemoteOwnedWorkbookRepository(
        remoteDB: ref.watch(firestoreProvider),
        auth: ref.watch(firebaseAuthProvider),
      );
    case AppDataLocation.remoteShared:
      return RemoteSharedWorkbookRepository(
        remoteDB: ref.watch(firestoreProvider),
      );
  }
});

abstract class WorkbookRepository {
  TaskEither<AppException, Workbook> addWorkbook({
    required String title,
    required AppThemeColor color,
    required String? folderId,
    required bool isPublic
  });

  Future<Either<AppException, List<Workbook>>> getWorkbooks({
    required String? folderId,
  });

  Future<Either<AppException, Workbook>> getWorkbook({
    required String workbookId,
  });

  Future<Either<AppException, List<Workbook>>> getDeletedWorkbooks();

  Future<Either<AppException, void>> updateWorkbook(Workbook workbook);

  TaskEither<AppException, void> deleteWorkbook(Workbook workbook);

  Future<Either<AppException, void>> destroyWorkbooks(List<Workbook> workbooks);

  Future<Either<AppException, void>> restoreWorkbook(Workbook workbook);

  Future<Either<AppException, void>> linkToGroup({
    required String groupId,
    required Workbook workbook,
  });
}
