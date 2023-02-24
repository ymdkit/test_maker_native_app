// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workbook_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$workbookHash() => r'744a92879ba4b9d77dad82ce3793c78cd0c722a1';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef WorkbookRef = AutoDisposeProviderRef<Workbook>;

/// See also [workbook].
@ProviderFor(workbook)
const workbookProvider = WorkbookFamily();

/// See also [workbook].
class WorkbookFamily extends Family<Workbook> {
  /// See also [workbook].
  const WorkbookFamily();

  /// See also [workbook].
  WorkbookProvider call({
    required WorkbooksStateKey key,
    required String workbookId,
  }) {
    return WorkbookProvider(
      key: key,
      workbookId: workbookId,
    );
  }

  @override
  WorkbookProvider getProviderOverride(
    covariant WorkbookProvider provider,
  ) {
    return call(
      key: provider.key,
      workbookId: provider.workbookId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'workbookProvider';
}

/// See also [workbook].
class WorkbookProvider extends AutoDisposeProvider<Workbook> {
  /// See also [workbook].
  WorkbookProvider({
    required this.key,
    required this.workbookId,
  }) : super.internal(
          (ref) => workbook(
            ref,
            key: key,
            workbookId: workbookId,
          ),
          from: workbookProvider,
          name: r'workbookProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$workbookHash,
          dependencies: WorkbookFamily._dependencies,
          allTransitiveDependencies: WorkbookFamily._allTransitiveDependencies,
        );

  final WorkbooksStateKey key;
  final String workbookId;

  @override
  bool operator ==(Object other) {
    return other is WorkbookProvider &&
        other.key == key &&
        other.workbookId == workbookId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, key.hashCode);
    hash = _SystemHash.combine(hash, workbookId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
