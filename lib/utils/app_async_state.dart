import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

part 'app_async_state.freezed.dart';

@freezed
class AppAsyncState<T> with _$AppAsyncState<T> {
  const factory AppAsyncState.loading() = AppAsyncState_Loading;
  const factory AppAsyncState.success({
    required T value,
  }) = AppAsyncState_Success;
  const factory AppAsyncState.failure({
    required AppException exception,
  }) = AppAsyncState_Failure;
}
