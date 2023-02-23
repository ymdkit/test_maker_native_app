// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AccountState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() guest,
    required TResult Function() loading,
    required TResult Function(Account account) authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? guest,
    TResult? Function()? loading,
    TResult? Function(Account account)? authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? guest,
    TResult Function()? loading,
    TResult Function(Account account)? authenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountState_Guest value) guest,
    required TResult Function(AccountState_Loading value) loading,
    required TResult Function(AccountState_Authorized value) authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountState_Guest value)? guest,
    TResult? Function(AccountState_Loading value)? loading,
    TResult? Function(AccountState_Authorized value)? authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountState_Guest value)? guest,
    TResult Function(AccountState_Loading value)? loading,
    TResult Function(AccountState_Authorized value)? authenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountStateCopyWith<$Res> {
  factory $AccountStateCopyWith(
          AccountState value, $Res Function(AccountState) then) =
      _$AccountStateCopyWithImpl<$Res, AccountState>;
}

/// @nodoc
class _$AccountStateCopyWithImpl<$Res, $Val extends AccountState>
    implements $AccountStateCopyWith<$Res> {
  _$AccountStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AccountState_GuestCopyWith<$Res> {
  factory _$$AccountState_GuestCopyWith(_$AccountState_Guest value,
          $Res Function(_$AccountState_Guest) then) =
      __$$AccountState_GuestCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AccountState_GuestCopyWithImpl<$Res>
    extends _$AccountStateCopyWithImpl<$Res, _$AccountState_Guest>
    implements _$$AccountState_GuestCopyWith<$Res> {
  __$$AccountState_GuestCopyWithImpl(
      _$AccountState_Guest _value, $Res Function(_$AccountState_Guest) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AccountState_Guest implements AccountState_Guest {
  const _$AccountState_Guest();

  @override
  String toString() {
    return 'AccountState.guest()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AccountState_Guest);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() guest,
    required TResult Function() loading,
    required TResult Function(Account account) authenticated,
  }) {
    return guest();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? guest,
    TResult? Function()? loading,
    TResult? Function(Account account)? authenticated,
  }) {
    return guest?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? guest,
    TResult Function()? loading,
    TResult Function(Account account)? authenticated,
    required TResult orElse(),
  }) {
    if (guest != null) {
      return guest();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountState_Guest value) guest,
    required TResult Function(AccountState_Loading value) loading,
    required TResult Function(AccountState_Authorized value) authenticated,
  }) {
    return guest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountState_Guest value)? guest,
    TResult? Function(AccountState_Loading value)? loading,
    TResult? Function(AccountState_Authorized value)? authenticated,
  }) {
    return guest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountState_Guest value)? guest,
    TResult Function(AccountState_Loading value)? loading,
    TResult Function(AccountState_Authorized value)? authenticated,
    required TResult orElse(),
  }) {
    if (guest != null) {
      return guest(this);
    }
    return orElse();
  }
}

abstract class AccountState_Guest implements AccountState {
  const factory AccountState_Guest() = _$AccountState_Guest;
}

/// @nodoc
abstract class _$$AccountState_LoadingCopyWith<$Res> {
  factory _$$AccountState_LoadingCopyWith(_$AccountState_Loading value,
          $Res Function(_$AccountState_Loading) then) =
      __$$AccountState_LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AccountState_LoadingCopyWithImpl<$Res>
    extends _$AccountStateCopyWithImpl<$Res, _$AccountState_Loading>
    implements _$$AccountState_LoadingCopyWith<$Res> {
  __$$AccountState_LoadingCopyWithImpl(_$AccountState_Loading _value,
      $Res Function(_$AccountState_Loading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AccountState_Loading implements AccountState_Loading {
  const _$AccountState_Loading();

  @override
  String toString() {
    return 'AccountState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AccountState_Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() guest,
    required TResult Function() loading,
    required TResult Function(Account account) authenticated,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? guest,
    TResult? Function()? loading,
    TResult? Function(Account account)? authenticated,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? guest,
    TResult Function()? loading,
    TResult Function(Account account)? authenticated,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountState_Guest value) guest,
    required TResult Function(AccountState_Loading value) loading,
    required TResult Function(AccountState_Authorized value) authenticated,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountState_Guest value)? guest,
    TResult? Function(AccountState_Loading value)? loading,
    TResult? Function(AccountState_Authorized value)? authenticated,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountState_Guest value)? guest,
    TResult Function(AccountState_Loading value)? loading,
    TResult Function(AccountState_Authorized value)? authenticated,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AccountState_Loading implements AccountState {
  const factory AccountState_Loading() = _$AccountState_Loading;
}

/// @nodoc
abstract class _$$AccountState_AuthorizedCopyWith<$Res> {
  factory _$$AccountState_AuthorizedCopyWith(_$AccountState_Authorized value,
          $Res Function(_$AccountState_Authorized) then) =
      __$$AccountState_AuthorizedCopyWithImpl<$Res>;
  @useResult
  $Res call({Account account});

  $AccountCopyWith<$Res> get account;
}

/// @nodoc
class __$$AccountState_AuthorizedCopyWithImpl<$Res>
    extends _$AccountStateCopyWithImpl<$Res, _$AccountState_Authorized>
    implements _$$AccountState_AuthorizedCopyWith<$Res> {
  __$$AccountState_AuthorizedCopyWithImpl(_$AccountState_Authorized _value,
      $Res Function(_$AccountState_Authorized) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? account = null,
  }) {
    return _then(_$AccountState_Authorized(
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as Account,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $AccountCopyWith<$Res> get account {
    return $AccountCopyWith<$Res>(_value.account, (value) {
      return _then(_value.copyWith(account: value));
    });
  }
}

/// @nodoc

class _$AccountState_Authorized implements AccountState_Authorized {
  const _$AccountState_Authorized({required this.account});

  @override
  final Account account;

  @override
  String toString() {
    return 'AccountState.authenticated(account: $account)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountState_Authorized &&
            (identical(other.account, account) || other.account == account));
  }

  @override
  int get hashCode => Object.hash(runtimeType, account);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountState_AuthorizedCopyWith<_$AccountState_Authorized> get copyWith =>
      __$$AccountState_AuthorizedCopyWithImpl<_$AccountState_Authorized>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() guest,
    required TResult Function() loading,
    required TResult Function(Account account) authenticated,
  }) {
    return authenticated(account);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? guest,
    TResult? Function()? loading,
    TResult? Function(Account account)? authenticated,
  }) {
    return authenticated?.call(account);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? guest,
    TResult Function()? loading,
    TResult Function(Account account)? authenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(account);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountState_Guest value) guest,
    required TResult Function(AccountState_Loading value) loading,
    required TResult Function(AccountState_Authorized value) authenticated,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountState_Guest value)? guest,
    TResult? Function(AccountState_Loading value)? loading,
    TResult? Function(AccountState_Authorized value)? authenticated,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountState_Guest value)? guest,
    TResult Function(AccountState_Loading value)? loading,
    TResult Function(AccountState_Authorized value)? authenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class AccountState_Authorized implements AccountState {
  const factory AccountState_Authorized({required final Account account}) =
      _$AccountState_Authorized;

  Account get account;
  @JsonKey(ignore: true)
  _$$AccountState_AuthorizedCopyWith<_$AccountState_Authorized> get copyWith =>
      throw _privateConstructorUsedError;
}
