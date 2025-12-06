import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:football_app/features/onboarding/data/models/timezone_model.dart';

class TimezoneCubit extends Cubit<String> {
  static const String _timezoneBoxName = 'timezone_box';
  static const String _timezoneKey = 'selected_timezone';

  late Box _timezoneBox;

  TimezoneCubit() : super('EG'); // Default to Egypt

  /// Initialize Hive and load saved timezone
  Future<void> initialize() async {
    _timezoneBox = await Hive.openBox(_timezoneBoxName);

    // Load saved timezone or use default
    final savedTimezone = _timezoneBox.get(_timezoneKey, defaultValue: 'EG') as String;
    emit(savedTimezone);
  }

  /// Change timezone and persist it
  Future<void> changeTimezone(String countryCode) async {
    await _timezoneBox.put(_timezoneKey, countryCode);
    emit(countryCode);
  }

  /// Get current timezone model
  TimezoneModel get currentTimezone => TimezoneModel.getTimezoneByCode(state);

  @override
  Future<void> close() {
    _timezoneBox.close();
    return super.close();
  }
}
