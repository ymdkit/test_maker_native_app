import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';
import 'package:test_maker_native_app/constants/data_source.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/feature/workbook/repository/local_workbook_data_source.dart';
import 'package:test_maker_native_app/feature/workbook/repository/remote_workbook_data_source.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

final workbookRepositoryProvider = Provider<WorkbookRepository>(
  (ref) => WorkbookRepository(
    remoteDataSource: ref.watch(remoteWorkbookDataSourceProvider),
    localDataSource: ref.watch(localWorkbookDataSourceProvider),
  ),
);

class WorkbookRepository {
  WorkbookRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final RemoteWorkbookDataSource remoteDataSource;
  final LocalWorkbookDataSource localDataSource;

  Future<Either<AppException, Workbook>> addWorkbook({
    required String title,
    required AppThemeColor color,
    required String? folderId,
  }) async =>
      Right(
        localDataSource.addWorkbook(
          title: title,
          color: color,
          folderId: folderId,
        ),
      );

  Future<Either<AppException, List<Workbook>>> getWorkbooks({
    required AppDataLocation location,
    required String? folderId,
  }) async {
    switch (location) {
      case AppDataLocation.local:
        return Right(localDataSource.getWorkbooks(folderId));
      case AppDataLocation.remoteOwned:
        return remoteDataSource.getWorkbooks();
      case AppDataLocation.remoteShared:
        return const Right([]);
    }
  }

  Future<Either<AppException, List<Workbook>>> getDeletedWorkbooks() async {
    return Right(localDataSource.getDeletedWorkbooks());
  }

  Future<Either<AppException, void>> updateWorkbook(Workbook workbook) async {
    return Right(localDataSource.updateWorkbook(workbook));
  }

  Future<Either<AppException, void>> deleteWorkbook(Workbook workbook) async {
    return Right(localDataSource.deleteWorkbook(workbook));
  }

  Future<Either<AppException, void>> destroyWorkbooks(
      List<Workbook> workbooks) async {
    return Right(localDataSource.destroyWorkbooks(workbooks));
  }

  Future<Either<AppException, void>> restoreWorkbook(Workbook workbook) async {
    return Right(localDataSource.restoreWorkbook(workbook));
  }
}
