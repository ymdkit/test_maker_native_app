import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final preferencesProvider = Provider<SharedPreferences>(
  (_) => throw UnimplementedError(
    'shared preferences should be overridden in main()',
  ),
);
