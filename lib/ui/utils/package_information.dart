import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info/package_info.dart';

final packageInfoProvider = Provider<PackageInfo>(
  (_) => throw UnimplementedError(
    'package info should be overridden in main()',
  ),
);
