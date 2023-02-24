// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$folderHash() => r'c30565afc2e569669f6d359a99172974da6e6e33';

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

typedef FolderRef = AutoDisposeProviderRef<Folder>;

/// See also [folder].
@ProviderFor(folder)
const folderProvider = FolderFamily();

/// See also [folder].
class FolderFamily extends Family<Folder> {
  /// See also [folder].
  const FolderFamily();

  /// See also [folder].
  FolderProvider call({
    required FoldersStateKey key,
    required String folderId,
  }) {
    return FolderProvider(
      key: key,
      folderId: folderId,
    );
  }

  @override
  FolderProvider getProviderOverride(
    covariant FolderProvider provider,
  ) {
    return call(
      key: provider.key,
      folderId: provider.folderId,
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
  String? get name => r'folderProvider';
}

/// See also [folder].
class FolderProvider extends AutoDisposeProvider<Folder> {
  /// See also [folder].
  FolderProvider({
    required this.key,
    required this.folderId,
  }) : super.internal(
          (ref) => folder(
            ref,
            key: key,
            folderId: folderId,
          ),
          from: folderProvider,
          name: r'folderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$folderHash,
          dependencies: FolderFamily._dependencies,
          allTransitiveDependencies: FolderFamily._allTransitiveDependencies,
        );

  final FoldersStateKey key;
  final String folderId;

  @override
  bool operator ==(Object other) {
    return other is FolderProvider &&
        other.key == key &&
        other.folderId == folderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, key.hashCode);
    hash = _SystemHash.combine(hash, folderId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
