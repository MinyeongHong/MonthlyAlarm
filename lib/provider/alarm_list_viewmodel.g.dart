// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_list_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

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

String _$AlarmListViewModelHash() =>
    r'33dbad00e8d329c3f8975d6e8532a2bb86c0c8e7';

/// See also [AlarmListViewModel].
final alarmListViewModelProvider =
    AutoDisposeNotifierProvider<AlarmListViewModel, List<Alarm>>(
  AlarmListViewModel.new,
  name: r'alarmListViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$AlarmListViewModelHash,
);
typedef AlarmListViewModelRef = AutoDisposeNotifierProviderRef<List<Alarm>>;

abstract class _$AlarmListViewModel extends AutoDisposeNotifier<List<Alarm>> {
  @override
  List<Alarm> build();
}

String _$menuModeHash() => r'dd58f7c0770c8d9864cea5535efd0a2e255e89dd';

/// See also [menuMode].
class MenuModeProvider extends AutoDisposeProvider<int> {
  MenuModeProvider(
    this.item,
  ) : super(
          (ref) => menuMode(
            ref,
            item,
          ),
          from: menuModeProvider,
          name: r'menuModeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$menuModeHash,
        );

  final int? item;

  @override
  bool operator ==(Object other) {
    return other is MenuModeProvider && other.item == item;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, item.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef MenuModeRef = AutoDisposeProviderRef<int>;

/// See also [menuMode].
final menuModeProvider = MenuModeFamily();

class MenuModeFamily extends Family<int> {
  MenuModeFamily();

  MenuModeProvider call(
    int? item,
  ) {
    return MenuModeProvider(
      item,
    );
  }

  @override
  AutoDisposeProvider<int> getProviderOverride(
    covariant MenuModeProvider provider,
  ) {
    return call(
      provider.item,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'menuModeProvider';
}
