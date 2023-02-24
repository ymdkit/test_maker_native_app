// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$groupHash() => r'2b1108db47259d04cc4a6481cba73202ffcee5c7';

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

typedef GroupRef = AutoDisposeProviderRef<Group>;

/// See also [group].
@ProviderFor(group)
const groupProvider = GroupFamily();

/// See also [group].
class GroupFamily extends Family<Group> {
  /// See also [group].
  const GroupFamily();

  /// See also [group].
  GroupProvider call(
    String groupId,
  ) {
    return GroupProvider(
      groupId,
    );
  }

  @override
  GroupProvider getProviderOverride(
    covariant GroupProvider provider,
  ) {
    return call(
      provider.groupId,
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
  String? get name => r'groupProvider';
}

/// See also [group].
class GroupProvider extends AutoDisposeProvider<Group> {
  /// See also [group].
  GroupProvider(
    this.groupId,
  ) : super.internal(
          (ref) => group(
            ref,
            groupId,
          ),
          from: groupProvider,
          name: r'groupProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$groupHash,
          dependencies: GroupFamily._dependencies,
          allTransitiveDependencies: GroupFamily._allTransitiveDependencies,
        );

  final String groupId;

  @override
  bool operator ==(Object other) {
    return other is GroupProvider && other.groupId == groupId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
