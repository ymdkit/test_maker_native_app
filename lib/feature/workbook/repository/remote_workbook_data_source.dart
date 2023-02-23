import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';
import 'package:test_maker_native_app/data/remote/firebase_auth.dart';
import 'package:test_maker_native_app/data/remote/firestore.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';

final remoteWorkbookDataSourceProvider = Provider<RemoteWorkbookDataSource>(
  (ref) => RemoteWorkbookDataSource(
    auth: ref.watch(firebaseAuthProvider),
    remoteDB: ref.watch(firestoreProvider),
  ),
);

class RemoteWorkbookDataSource {
  RemoteWorkbookDataSource({
    required this.auth,
    required this.remoteDB,
  });

  final FirebaseAuth auth;
  final FirebaseFirestore remoteDB;

  Workbook addWorkbook({
    required String title,
    required AppThemeColor color,
    required String? folderId,
  }) {
    throw UnimplementedError();
  }

  List<Workbook> getWorkbooks(String? folderId) {
    throw UnimplementedError();
  }

  List<Workbook> getDeletedWorkbooks() {
    throw UnimplementedError();
  }

  void updateWorkbook(Workbook workbook) {
    throw UnimplementedError();
  }

  void deleteWorkbook(Workbook workbook) {
    throw UnimplementedError();
  }

  void destroyWorkbooks(List<Workbook> workbooks) {
    throw UnimplementedError();
  }

  void restoreWorkbook(Workbook workbook) {
    throw UnimplementedError();
  }
}
