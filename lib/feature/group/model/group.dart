import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';

part 'group.freezed.dart';

@freezed
class Group with _$Group {
  const Group._();
  const factory Group({
    required String groupId,
    required String ownerId,
    required String title,
    required AppThemeColor color,
    required DateTime createdAt,
    required bool isOwned,
  }) = _Group;

  factory Group.empty() => Group(
        groupId: '',
        title: '',
        color: AppThemeColor.blue,
        createdAt: DateTime.now(),
        ownerId: '',
        isOwned: false,
      );
}
