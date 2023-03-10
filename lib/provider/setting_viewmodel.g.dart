// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_viewmodel.dart';

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

String _$SettingViewModelHash() => r'446609617d6428f8dc0f686271fdf7e353213966';

/// See also [SettingViewModel].
class SettingViewModelProvider
    extends AutoDisposeNotifierProviderImpl<SettingViewModel, ThemeSettings> {
  SettingViewModelProvider([
    this.setting,
  ]) : super(
          () => SettingViewModel()..setting = setting,
          from: settingViewModelProvider,
          name: r'settingViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$SettingViewModelHash,
        );

  final ThemeSettings? setting;

  @override
  bool operator ==(Object other) {
    return other is SettingViewModelProvider && other.setting == setting;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, setting.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  ThemeSettings runNotifierBuild(
    covariant _$SettingViewModel notifier,
  ) {
    return notifier.build(
      setting,
    );
  }
}

typedef SettingViewModelRef = AutoDisposeNotifierProviderRef<ThemeSettings>;

/// See also [SettingViewModel].
final settingViewModelProvider = SettingViewModelFamily();

class SettingViewModelFamily extends Family<ThemeSettings> {
  SettingViewModelFamily();

  SettingViewModelProvider call([
    ThemeSettings? setting,
  ]) {
    return SettingViewModelProvider(
      setting,
    );
  }

  @override
  AutoDisposeNotifierProviderImpl<SettingViewModel, ThemeSettings>
      getProviderOverride(
    covariant SettingViewModelProvider provider,
  ) {
    return call(
      provider.setting,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'settingViewModelProvider';
}

abstract class _$SettingViewModel
    extends BuildlessAutoDisposeNotifier<ThemeSettings> {
  late final ThemeSettings? setting;

  ThemeSettings build([
    ThemeSettings? setting,
  ]);
}
