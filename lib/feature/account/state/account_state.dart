import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/account/model/account.dart';
import 'package:test_maker_native_app/feature/account/model/sign_in_provider.dart';
import 'package:test_maker_native_app/feature/account/repository/account_repository.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

part 'account_state.freezed.dart';

@freezed
class AccountState with _$AccountState {
  const factory AccountState.guest() = AccountState_Guest;
  const factory AccountState.loading() = AccountState_Loading;
  const factory AccountState.authenticated({
    required Account account,
  }) = AccountState_Authorized;
}

final accountStateProvider =
    StateNotifierProvider<AccountStateNotifier, AccountState>((ref) {
  return AccountStateNotifier(
    accountRepository: ref.watch(accountRepositoryProvider),
  );
});

class AccountStateNotifier extends StateNotifier<AccountState> {
  AccountStateNotifier({
    required this.accountRepository,
  }) : super(const AccountState.guest()) {
    accountRepository.fetchAccount().match(
          (_) => state = const AccountState.guest(),
          (account) => state = AccountState.authenticated(account: account),
        );
  }

  final AccountRepository accountRepository;

  Future<Either<AppException, void>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = const AccountState.loading();
    final result = await accountRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    result.match(
      (error) => state = const AccountState.guest(),
      (account) => state = AccountState.authenticated(account: account),
    );
    return result;
  }

  Future<Either<AppException, void>> signInWithProvider({
    required SignInProvider signInProvider,
  }) async {
    state = const AccountState.loading();
    final Either<AppException, Account> result;

    switch (signInProvider) {
      case SignInProvider.google:
        result = await accountRepository.signInWithGoogle();
        break;
      case SignInProvider.apple:
        result = await accountRepository.signInWithApple();
        break;
    }
    result.match(
      (error) => state = const AccountState.guest(),
      (account) => state = AccountState.authenticated(account: account),
    );
    return result;
  }

  Future<void> signOut() async {
    await accountRepository.signOut();
    state = const AccountState.guest();
  }
}
