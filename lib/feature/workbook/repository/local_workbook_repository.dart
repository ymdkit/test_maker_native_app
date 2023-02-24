import 'package:dartx/dartx.dart';
import 'package:fpdart/fpdart.dart';
import 'package:realm/realm.dart' hide AppException;
import 'package:test_maker_native_app/constants/color_theme.dart';
import 'package:test_maker_native_app/constants/data_source.dart';
import 'package:test_maker_native_app/data/local/realm_model_converting_ext.dart';
import 'package:test_maker_native_app/data/local/realm_schema.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/feature/workbook/repository/workbook_repository.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

class LocalWorkbookRepository implements WorkbookRepository {
  LocalWorkbookRepository({
    required this.localDB,
  });

  final Realm localDB;

  @override
  Future<Either<AppException, Workbook>> addWorkbook({
    required String title,
    required AppThemeColor color,
    required String? folderId,
  }) async {
    final newOrder =
        (localDB.all<RealmWorkbook>().maxBy((e) => e.order)?.order ?? 0) + 1;

    final workbook = Workbook(
      workbookId: Uuid.v4().toString(),
      title: title,
      order: newOrder,
      color: color,
      folderId: folderId,
      questionCount: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      location: AppDataLocation.local,
    );

    localDB.write(() {
      localDB.add<RealmWorkbook>(
        RealmWorkbookConverting.fromWorkbook(workbook),
      );
    });

    return Right(workbook);
  }

  @override
  Future<Either<AppException, List<Workbook>>> getWorkbooks({
    required String? folderId,
  }) async {
    return Right(
      localDB
          .all<RealmWorkbook>()
          .where((e) => e.isDeleted != true)
          .where((e) => e.folderId == folderId)
          .map(
        (e) {
          final questionCount = localDB
              .all<RealmQuestion>()
              .where((e) => e.isDeleted != true)
              .where((element) => element.workbookId == e.workbookId)
              .length;
          return e.toWorkbook(questionCount: questionCount);
        },
      ).toList(),
    );
  }

  @override
  Future<Either<AppException, List<Workbook>>> getDeletedWorkbooks() async {
    return Right(
        localDB.all<RealmWorkbook>().where((e) => e.isDeleted == true).map(
      (e) {
        final questionCount = localDB
            .all<RealmQuestion>()
            .where((element) => element.workbookId == e.workbookId)
            .length;
        return e.toWorkbook(questionCount: questionCount);
      },
    ).toList());
  }

  @override
  Future<Either<AppException, void>> updateWorkbook(Workbook workbook) async {
    localDB.write(() {
      localDB.add<RealmWorkbook>(
        RealmWorkbookConverting.fromWorkbook(workbook.copyWith(
          updatedAt: DateTime.now(),
        )),
        update: true,
      );
    });
    return const Right(null);
  }

  @override
  Future<Either<AppException, void>> deleteWorkbook(Workbook workbook) async {
    localDB.write(() {
      localDB.add<RealmWorkbook>(
        RealmWorkbookConverting.fromWorkbook(workbook)..isDeleted = true,
        update: true,
      );
    });
    return const Right(null);
  }

  @override
  Future<Either<AppException, void>> destroyWorkbooks(
      List<Workbook> workbooks) async {
    localDB.write(() {
      final targets = localDB.all<RealmWorkbook>().where((e) {
        return workbooks.any((element) => element.workbookId == e.workbookId);
      });
      localDB.deleteMany(targets);
    });
    return const Right(null);
  }

  @override
  Future<Either<AppException, void>> restoreWorkbook(Workbook workbook) async {
    localDB.write(() {
      localDB.add<RealmWorkbook>(
        RealmWorkbookConverting.fromWorkbook(workbook)..isDeleted = false,
        update: true,
      );
    });
    return const Right(null);
  }
}
