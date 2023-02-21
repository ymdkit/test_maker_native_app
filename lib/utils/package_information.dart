import 'package:package_info/package_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'package_information.g.dart';

@riverpod
PackageInfo packageInfo(PackageInfoRef ref) => throw UnimplementedError(
      'package info should be overridden in main()',
    );
