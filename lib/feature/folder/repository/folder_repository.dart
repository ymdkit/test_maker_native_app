import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';
import 'package:test_maker_native_app/data/local/realm.dart';
import 'package:test_maker_native_app/data/remote/firebase_auth.dart';
import 'package:test_maker_native_app/data/remote/firestore.dart';
import 'package:test_maker_native_app/feature/folder/model/folder.dart';
import 'package:test_maker_native_app/feature/folder/repository/local_folder_repository.dart';
import 'package:test_maker_native_app/feature/folder/repository/remote_owned_folder_repository.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

final folderRepositoryProvider =
    Provider.family<FolderRepository, AppDataLocation>((ref, location) {
  switch (location) {
    case AppDataLocation.local:
      return LocalFolderRepository(
        localDB: ref.watch(realmProvider),
      );
    case AppDataLocation.remoteOwned:
      return RemoteOwnedFolderRepository(
        remoteDB: ref.watch(firestoreProvider),
        auth: ref.watch(firebaseAuthProvider),
      );
    default:
      throw const AppException(message: 'Invalid AppDataLocation');
  }
});

abstract class FolderRepository {
  Future<Either<AppException, Folder>> addFolder({
    required String title,
    required AppThemeColor color,
  });

  Future<Either<AppException, List<Folder>>> getFolders();

  Future<Either<AppException, List<Folder>>> getDeletedFolders();

  Future<Either<AppException, void>> updateFolder(Folder folder);

  Future<Either<AppException, void>> deleteFolder(Folder folder);

  Future<Either<AppException, void>> destroyFolders(List<Folder> folders);

  Future<Either<AppException, void>> restoreFolder(Folder folder);
}
