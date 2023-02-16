import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info/package_info.dart';

final packageInformationProvider = FutureProvider.autoDispose<PackageInfo>(
  (_) => PackageInfo.fromPlatform(),
);
