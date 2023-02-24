import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/feature/folder/model/folder.dart';

part 'folders_state_key.freezed.dart';

@freezed
class FoldersStateKey with _$FoldersStateKey {
  const FoldersStateKey._();
  const factory FoldersStateKey({
    required AppDataLocation location,
  }) = _FoldersStateKey;

  factory FoldersStateKey.from(
    Folder folder,
  ) =>
      FoldersStateKey(location: folder.location);
}
