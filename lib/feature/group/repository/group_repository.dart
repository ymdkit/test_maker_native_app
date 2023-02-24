import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartx/dartx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart' hide Group;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';
import 'package:test_maker_native_app/data/remote/firebase_auth.dart';
import 'package:test_maker_native_app/data/remote/firestore.dart';
import 'package:test_maker_native_app/feature/group/model/group.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

final groupRepositoryProvider = Provider<GroupRepository>(
  (ref) => GroupRepository(
    db: ref.watch(firestoreProvider),
    auth: ref.watch(firebaseAuthProvider),
  ),
);

class GroupRepository {
  GroupRepository({
    required this.db,
    required this.auth,
  });

  final FirebaseFirestore db;
  final FirebaseAuth auth;

  TaskEither<AppException, Group> addGroup({
    required String title,
    required AppThemeColor color,
  }) =>
      TaskEither.tryCatch(
        () {
          final userId = auth.currentUser!.uid;
          final group = db.collection('groups').add(
            {
              'name': title,
              'color': color.index,
              'userId': userId,
              'createdAt': Timestamp.now(),
            },
          );
          return group.then((value) => value.get()).then(_documentToGroup);
        },
        (e, stack) => AppException.fromRawException(e: e),
      );

  Future<Either<AppException, List<Group>>> getGroups() async {
    try {
      final userId = auth.currentUser!.uid;
      final groups =
          await db.collection('users').doc(userId).collection('groups').get();
      return right(groups.docs.map((e) => _documentToGroup(e)).toList());
    } catch (e) {
      return left(AppException.fromRawException(e: e));
    }
  }

  Future<Either<AppException, void>> updateGroup(Group group) async {
    try {
      await db.collection('groups').doc(group.groupId).update({
        'name': group.title,
        'color': group.color.index,
      });
      return right(null);
    } catch (e) {
      return left(AppException.fromRawException(e: e));
    }
  }

  Future<Either<AppException, void>> deleteGroup(Group group) async {
    try {
      await db
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('groups')
          .doc(group.groupId)
          .delete();
      return right(null);
    } catch (e) {
      return left(AppException.fromRawException(e: e));
    }
  }

  TaskEither<AppException, Group> joinGroup(Group group) => TaskEither.tryCatch(
        () async {
          final userId = auth.currentUser!.uid;
          final ref = db.collection('users').doc(userId).collection('groups');
          final doc = await ref.add(
            {
              'id': ref.id,
              'name': group.title,
              'color': group.color.index,
              'userId': userId,
              'createdAt': Timestamp.now(),
            },
          );
          return _documentToGroup(await doc.get());
        },
        (e, _) => AppException.fromRawException(e: e),
      );

  Future<Either<AppException, void>> leaveGroup({
    required String groupId,
  }) async {
    try {
      await db
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('groups')
          .doc(groupId)
          .delete();
      return right(null);
    } catch (e) {
      return left(AppException.fromRawException(e: e));
    }
  }

  Future<Either<AppException, List<Workbook>>> getGroupWorkbooks({
    required String groupId,
  }) async {
    try {
      final groups =
          await db.collection('groups').doc(groupId).collection('tests').get();
      return right(groups.docs.map((e) => _documentToWorkbook(e)).toList());
    } catch (e) {
      return left(AppException.fromRawException(e: e));
    }
  }

  Group _documentToGroup(
    DocumentSnapshot document,
  ) {
    final data = document.data() as Map<String, dynamic>?;
    if (data != null) {
      return Group(
        groupId: document.id,
        title: data['name'] as String,
        color: AppThemeColor.fromIndex(data.getOrElse('color', () => 0) as int),
        ownerId: data['userId'] as String,
        isOwned: data['userId'] == auth.currentUser?.uid,
        createdAt: (data['createdAt'] as Timestamp).toDate(),
      );
    } else {
      return Group.empty();
    }
  }

  Workbook _documentToWorkbook(
    DocumentSnapshot document,
  ) {
    final data = document.data() as Map<String, dynamic>?;
    if (data != null) {
      return Workbook(
        workbookId: document.id,
        title: data['name'] as String,
        order: data['order'] as int,
        color: AppThemeColor.fromIndex(data.getOrElse('color', () => 0) as int),
        folderId: null,
        questionCount: data['size'] as int,
        createdAt: (data['createdAt'] as Timestamp).toDate(),
        updatedAt: (data['updatedAt'] as Timestamp).toDate(),
        isOwned: data['userId'] == auth.currentUser?.uid,
      );
    } else {
      return Workbook.empty();
    }
  }
}
