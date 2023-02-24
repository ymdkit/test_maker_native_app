import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/folder/model/folder.dart';
import 'package:test_maker_native_app/feature/folder/repository/folder_repository.dart';
import 'package:test_maker_native_app/feature/folder/state/folders_state.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

final deletedFoldersProvider = StateNotifierProvider.autoDispose<
    DeletedFoldersStateNotifier, FoldersState>(
  (ref) => DeletedFoldersStateNotifier(
    folderRepository: ref.watch(folderRepositoryProvider),
    onMutateDeletedFolderStream: ref.watch(onMutateDeletedFolderStreamProvider),
    onMutateFolderStream: ref.watch(onMutateFolderStreamProvider),
  ),
);

class DeletedFoldersStateNotifier extends StateNotifier<FoldersState> {
  DeletedFoldersStateNotifier({
    required this.folderRepository,
    required this.onMutateDeletedFolderStream,
    required StreamController<Folder> onMutateFolderStream,
  }) : super(const FoldersState.loading()) {
    _setupFolders();
    onMutateFolderSubscription = onMutateFolderStream.stream.listen(
      (folder) async => _setupFolders(),
    );
  }

  final FolderRepository folderRepository;
  final StreamController<Folder> onMutateDeletedFolderStream;
  late final StreamSubscription<Folder> onMutateFolderSubscription;

  Future<void> _setupFolders() async {
    state = const FoldersState.loading();
    final result = await folderRepository.getDeletedFolders();
    result.match(
      (l) => state = FoldersState.failure(exception: l),
      (r) => state = FoldersState.success(value: r),
    );
  }

  Future<Either<AppException, void>> restoreFolder(Folder folder) async =>
      await state.maybeWhen(
        success: (folders) async {
          final result = await folderRepository.restoreFolder(folder);

          return result.match(
            (l) => left(l),
            (r) {
              state = FoldersState.success(
                value: folders
                    .where(
                      (e) => e.folderId != folder.folderId,
                    )
                    .toList(),
              );
              onMutateDeletedFolderStream.sink.add(folder);
              return right(r);
            },
          );
        },
        orElse: () => right(null),
      );

  Future<Either<AppException, void>> destroyFolders() async =>
      await state.maybeWhen(
        success: (folders) async {
          final result = await folderRepository.destroyFolders(folders);

          return result.match(
            (l) => left(l),
            (r) {
              state = const FoldersState.success(value: []);
              return right(r);
            },
          );
        },
        orElse: () => right(null),
      );

  @override
  void dispose() {
    onMutateFolderSubscription.cancel();
    super.dispose();
  }
}

final onMutateDeletedFolderStreamProvider = Provider(
  (ref) => StreamController<Folder>.broadcast(),
);
