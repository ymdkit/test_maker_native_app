import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_maker_native_app/data/remote/firebase_auth.dart';
import 'package:test_maker_native_app/data/remote/firestore.dart';
import 'package:test_maker_native_app/feature/account/model/account.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

final accountRepositoryProvider = Provider<AccountRepository>(
  (ref) => AccountRepository(
    auth: ref.watch(firebaseAuthProvider),
    remoteDB: ref.watch(firestoreProvider),
  ),
);

class AccountRepository {
  const AccountRepository({
    required this.auth,
    required this.remoteDB,
  });

  final FirebaseAuth auth;
  final FirebaseFirestore remoteDB;

  Future<Either<AppException, Account>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        return const Left(
            AppException(message: AppExceptionMessage.signInFailure));
      }

      await _updateUser(user);
      return Right(user.toAccount());
    } on FirebaseAuthException catch (e) {
      return Left(
        AppException.fromRawException(
          message: AppExceptionMessage.signInFailure,
          e: e,
        ),
      );
    } catch (e) {
      return Left(AppException.fromRawException(e: e));
    }
  }

  Future<Either<AppException, Account>> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return const Left(AppException(
          message: AppExceptionMessage.signInFailure,
        ));
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final user = authResult.user;
      if (user == null) {
        return const Left(AppException(
          message: AppExceptionMessage.signInFailure,
        ));
      }

      await _updateUser(user);
      return Right(user.toAccount());
    } catch (e) {
      return Left(AppException.fromRawException(e: e));
    }
  }

  Future<Either<AppException, Account>> signInWithApple() async {
    final appleProvider = AppleAuthProvider();

    try {
      final credential =
          await FirebaseAuth.instance.signInWithProvider(appleProvider);

      final user = credential.user;
      if (user == null) {
        return const Left(AppException(
          message: AppExceptionMessage.signInFailure,
        ));
      }

      await _updateUser(user);
      return Right(user.toAccount());
    } catch (e) {
      return Left(AppException.fromRawException(e: e));
    }
  }

  Either<AppException, Account> fetchAccount() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Left(AppException(
        message: AppExceptionMessage.signInFailure,
      ));
    }
    return Right(user.toAccount());
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  TaskEither<AppException, void> delete() => TaskEither.tryCatch(
        () async => FirebaseAuth.instance.currentUser?.delete(),
        (e, _) => AppException.fromRawException(
          e: e,
          code: AppExceptionCode.unAuthorized,
        ),
      );

  Future<void> _updateUser(User user) async =>
      remoteDB.collection('users').doc(user.uid).set(
        {
          'id': user.uid,
          'name': user.displayName,
          'email': user.email,
          'photo_url': user.photoURL,
          'last_login_at': Timestamp.fromDate(DateTime.now()),
        },
      );
}

extension FirebaseUserExt on User {
  Account toAccount() {
    return Account(
      accountId: uid,
      email: email ?? '',
      name: displayName ?? '',
    );
  }
}
