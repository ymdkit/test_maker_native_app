import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartx/dartx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:fpdart/fpdart.dart' hide Group;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';
import 'package:test_maker_native_app/data/remote/firebase_auth.dart';
import 'package:test_maker_native_app/data/remote/firestore.dart';
import 'package:test_maker_native_app/data/remote/firestore_converting.dart';
import 'package:test_maker_native_app/feature/group/model/group.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';
import 'package:test_maker_native_app/utils/dynamic_link_creator.dart';

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
          return group
              .then((value) => value.get())
              .then((group) => documentToGroup(userId, group));
        },
        (e, stack) => AppException.fromRawException(e: e),
      );

  Future<Either<AppException, List<Group>>> getGroups() async {
    try {
      final userId = auth.currentUser?.uid;
      if (userId == null) {
        return right([]);
      }

      final groups = await db
          .collection('users')
          .doc(userId)
          .collection('groups')
          .orderBy('createdAt', descending: true)
          .get();
      return right(groups.docs.map((e) => documentToGroup(userId, e)).toList());
    } catch (e) {
      return left(AppException.fromRawException(e: e));
    }
  }

  TaskEither<AppException, Group> getGroup(String groupId) {
    return TaskEither.tryCatch(
      () async {
        final userId = auth.currentUser?.uid;
        final group = await db.collection('groups').doc(groupId).get();
        return documentToGroup(userId, group);
      },
      (e, stack) => AppException.fromRawException(e: e),
    );
  }

  Future<Either<AppException, void>> updateGroup(Group group) async {
    try {
      final userId = auth.currentUser?.uid;
      if (userId == null) {
        return right(null);
      }

      await db.collection('groups').doc(group.groupId).update({
        'name': group.title,
        'color': group.color.index,
        'updatedAt': Timestamp.now(),
      });
      await db
          .collection('users')
          .doc(userId)
          .collection('groups')
          .doc(group.groupId)
          .update({
        'name': group.title,
        'color': group.color.index,
        'updatedAt': Timestamp.now(),
      });
      return right(null);
    } catch (e) {
      return left(AppException.fromRawException(e: e));
    }
  }

  TaskEither<AppException, Group> deleteGroup(Group group) {
    return TaskEither.tryCatch(
      () async {
        await db.collection('groups').doc(group.groupId).delete();
        return group;
      },
      (e, _) => AppException.fromRawException(e: e),
    );
  }

  TaskEither<AppException, Group> joinGroup(Group group) => TaskEither.tryCatch(
        () async {
          final userId = auth.currentUser?.uid;

          if (userId == null) {
            throw const AppException();
          }

          final ref = db.collection('users').doc(userId).collection('groups');
          await ref.doc(group.groupId).set(
            {
              'id': ref.id,
              'name': group.title,
              'color': group.color.index,
              'userId': group.ownerId,
            },
          );
          return group;
        },
        (e, _) => AppException.fromRawException(e: e),
      );

  TaskEither<AppException, Group> leaveGroup(Group group) {
    return TaskEither.tryCatch(
      () async {
        await db
            .collection('users')
            .doc(auth.currentUser!.uid)
            .collection('groups')
            .doc(group.groupId)
            .delete();
        return group;
      },
      (e, _) => AppException.fromRawException(e: e),
    );
  }

  Future<Either<AppException, List<Workbook>>> getGroupWorkbooks({
    required String groupId,
  }) async {
    try {
      final userId = auth.currentUser!.uid;
      final groups = await db
          .collection('tests')
          .where('groupId', isEqualTo: groupId)
          .get();
      return right(groups.docs
          .where((e) => e.data().getOrElse('deleted', () => false) == false)
          .map((e) => documentToWorkbook(userId, e))
          .toList());
    } catch (e) {
      return left(AppException.fromRawException(e: e));
    }
  }

  Future<Either<AppException, void>> unLinkGroupWorkbook({
    required String groupId,
    required String workbookId,
  }) async {
    return TaskEither.tryCatch(
      () async {
        await db.collection('tests').doc(workbookId).update({
          'groupId': '',
        });
      },
      (e, _) => AppException.fromRawException(e: e),
    ).run();
  }
}
