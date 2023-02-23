import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exception.freezed.dart';

@freezed
class AppException with _$AppException implements Exception {
  const AppException._();
  const factory AppException({
    @Default('システムエラーが発生しました。ご迷惑をおかけしますがしばらく時間を置いてから再度お試しください') String message,
    @Default(AppExceptionCode.unknown) AppExceptionCode code,
    Exception? rawException,
  }) = _AppException;

  factory AppException.fromRawException({
    required Object e,
    String? message,
  }) =>
      AppException(
        message: message ?? 'システムエラーが発生しました。ご迷惑をおかけしますがしばらく時間を置いてから再度お試しください',
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
