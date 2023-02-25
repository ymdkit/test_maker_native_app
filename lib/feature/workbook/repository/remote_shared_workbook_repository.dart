import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';
import 'package:test_maker_native_app/data/remote/firestore_converting.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/feature/workbook/repository/workbook_repository.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

class RemoteSharedWorkbookRepository implements WorkbookRepository {
  RemoteSharedWorkbookRepository({
    required this.remoteDB,
  });

  final FirebaseFirestore remoteDB;

  @override
  Future<Either<AppException, Workbook>> addWorkbook({
    required String title,
    required AppThemeColor color,
    required String? folderId,
  }) async {
    return Right(Workbook.empty());
  }

  @override
  Future<Either<AppException, List<Workbook>>> getWorkbooks({
    required String? folderId,
  }) async {
    return const Right([]);
  }

  @override
  Future<Either<AppException, Workbook>> getWorkbook({
    required String workbookId,
  }) async {
    return TaskEither.tryCatch(
      () {
        return remoteDB
            .collection('tests')
            .doc(workbookId)
            .get()
            .then((value) => documentToWorkbook(null, value));
      },
      (e, stack) => AppException.fromRawException(e: e),
    ).run();
  }

  @override
  Future<Either<AppException, List<Workbook>>> getDeletedWorkbooks() async {
    return const Right([]);
  }

  @override
  Future<Either<AppException, void>> updateWorkbook(Workbook workbook) async {
    return const Right(null);
  }

  @override
  Future<Either<AppException, void>> deleteWorkbook(Workbook workbook) async {
    return const Right(null);
  }

  @override
  Future<Either<AppException, void>> destroyWorkbooks(
      List<Workbook> workbooks) async {
    return const Right(null);
  }

  @override
  Future<Either<AppException, void>> restoreWorkbook(Workbook workbook) async {
    return const Right(null);
  }

  @override
  Future<Either<AppException, void>> linkToGroup({
    required String groupId,
    required Workbook workbook,
  }) async {
    return const Right(null);
  }
}
