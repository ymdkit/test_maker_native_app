import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exception.freezed.dart';

@freezed
class AppException with _$AppException implements Exception {
  const AppException._();
  const factory AppException({
    @Default(AppExceptionMessage.systemError) AppExceptionMessage message,
    @Default(AppExceptionCode.unknown) AppExceptionCode code,
    Exception? rawException,
  }) = _AppException;

  factory AppException.fromRawException({
    required Object e,
    AppExceptionCode? code,
    AppExceptionMessage? message,
  }) =>
      AppException(
        code: code ?? AppExceptionCode.unknown,
        message: message ?? AppExceptionMessage.systemError,
        rawException: e is Exception ? e : Exception(e.toString()),
      );

  @override
  String toString() {
    return '$code: \n$rawException';
  }
}

//NOTE: エラーの内容に応じて UI 側で条件分岐したい場合に利用する
enum AppExceptionCode {
  unAuthorized,
  unknown,
}

enum AppExceptionMessage {
  systemError,
  signInFailure,
  importWorkbookFailure,
  exportWorkbookFailure;

  String displayString(BuildContext context) {
    switch (this) {
      case AppExceptionMessage.systemError:
        return AppLocalizations.of(context)!.messageSystemError;
      case AppExceptionMessage.signInFailure:
        return AppLocalizations.of(context)!.messageSignInFailure;
      case AppExceptionMessage.importWorkbookFailure:
        return AppLocalizations.of(context)!.messageImportWorkbookFailure;
      case AppExceptionMessage.exportWorkbookFailure:
        return AppLocalizations.of(context)!.messageExportWorkbookFailure;

    }
  }
}
