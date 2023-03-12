// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_detail_viewmodel.dart';

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

String _$AlarmDetailViewModelHash() =>
    r'ec3c34f10aaadee4a547e8f55686f095f6208da4';

/// See also [AlarmDetailViewModel].
class AlarmDetailViewModelProvider
    extends AutoDisposeNotifierProviderImpl<AlarmDetailViewModel, Alarm> {
  AlarmDetailViewModelProvider([
    this.initVal,
  ]) : super(
          () => AlarmDetailViewModel()..initVal = initVal,
          from: alarmDetailViewModelProvider,
          name: r'alarmDetailViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$AlarmDetailViewModelHash,
        );

  final Alarm? initVal;

  @override
  bool operator ==(Object other) {
    return other is AlarmDetailViewModelProvider && other.initVal == initVal;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, initVal.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  Alarm runNotifierBuild(
    covariant _$AlarmDetailViewModel notifier,
  ) {
    return notifier.build(
      initVal,
    );
  }
}

typedef AlarmDetailViewModelRef = AutoDisposeNotifierProviderRef<Alarm>;

/// See also [AlarmDetailViewModel].
final alarmDetailViewModelProvider = AlarmDetailViewModelFamily();

class AlarmDetailViewModelFamily extends Family<Alarm> {
  AlarmDetailViewModelFamily();

  AlarmDetailViewModelProvider call([
    Alarm? initVal,
  ]) {
    return AlarmDetailViewModelProvider(
      initVal,
    );
  }

  @override
  AutoDisposeNotifierProviderImpl<AlarmDetailViewModel, Alarm>
      getProviderOverride(
    covariant AlarmDetailViewModelProvider provider,
  ) {
    return call(
      provider.initVal,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'alarmDetailViewModelProvider';
}

abstract class _$AlarmDetailViewModel
    extends BuildlessAutoDisposeNotifier<Alarm> {
  late final Alarm? initVal;

  Alarm build([
    Alarm? initVal,
  ]);
}
