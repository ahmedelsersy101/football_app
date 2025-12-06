import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:football_app/features/onboarding/data/models/league_model.dart';

class LeaguesCubit extends Cubit<List<String>> {
  static const String _leaguesBoxName = 'leagues_box';
  static const String _leaguesKey = 'selected_leagues';

  late Box _leaguesBox;

  LeaguesCubit() : super([]); // Start with empty selection

  /// Initialize Hive and load saved leagues
  Future<void> initialize() async {
    _leaguesBox = await Hive.openBox(_leaguesBoxName);

    // Load saved leagues or use default
    final savedLeagues = _leaguesBox.get(_leaguesKey, defaultValue: <String>[]) as List;
    emit(List<String>.from(savedLeagues));
  }

  /// Toggle league selection (add if not selected, remove if already selected)
  void toggleLeague(String leagueId) {
    final currentSelection = List<String>.from(state);

    if (currentSelection.contains(leagueId)) {
      currentSelection.remove(leagueId);
    } else {
      currentSelection.add(leagueId);
    }

    emit(currentSelection);
  }

  /// Save selected leagues to Hive
  Future<void> saveSelection() async {
    await _leaguesBox.put(_leaguesKey, state);
  }

  /// Check if a league is selected
  bool isLeagueSelected(String leagueId) {
    return state.contains(leagueId);
  }

  /// Get selected league models
  List<LeagueModel> get selectedLeagues {
    return LeagueModel.getLeaguesByIds(state);
  }

  /// Clear all selections
  void clearSelection() {
    emit([]);
  }

  @override
  Future<void> close() {
    _leaguesBox.close();
    return super.close();
  }
}
