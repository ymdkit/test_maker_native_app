import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';

@freezed
class Account with _$Account {
  const Account._();
  const factory Account({
    required String accountId,
    required String email,
    required String name,
  }) = _Account;
}
