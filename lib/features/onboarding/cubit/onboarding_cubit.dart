import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OnboardingCubit extends Cubit<bool> {
  static const String _onboardingBoxName = 'onboarding_box';
  static const String _completedKey = 'onboarding_completed';

  late Box _onboardingBox;

  OnboardingCubit() : super(false); // Not completed by default

  /// Initialize Hive and check if onboarding is completed
  Future<void> initialize() async {
    _onboardingBox = await Hive.openBox(_onboardingBoxName);

    // Check if onboarding was completed before
    final isCompleted = _onboardingBox.get(_completedKey, defaultValue: false) as bool;
    emit(isCompleted);
  }

  /// Mark onboarding as completed
  Future<void> completeOnboarding() async {
    await _onboardingBox.put(_completedKey, true);
    emit(true);
  }

  /// Reset onboarding (useful for testing or settings)
  Future<void> resetOnboarding() async {
    await _onboardingBox.put(_completedKey, false);
    emit(false);
  }

  /// Check if onboarding is completed
  bool get isCompleted => state;

  @override
  Future<void> close() {
    _onboardingBox.close();
    return super.close();
  }
}
