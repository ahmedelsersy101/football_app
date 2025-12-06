import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:football_app/features/onboarding/data/models/team_model.dart';

class TeamsCubit extends Cubit<List<String>> {
  static const String _teamsBoxName = 'teams_box';
  static const String _teamsKey = 'selected_teams';

  late Box _teamsBox;

  TeamsCubit() : super([]); // Start with empty selection

  /// Initialize Hive and load saved teams
  Future<void> initialize() async {
    _teamsBox = await Hive.openBox(_teamsBoxName);

    // Load saved teams or use default
    final savedTeams = _teamsBox.get(_teamsKey, defaultValue: <String>[]) as List;
    emit(List<String>.from(savedTeams));
  }

  /// Toggle team selection (add if not selected, remove if already selected)
  void toggleTeam(String teamId) {
    final currentSelection = List<String>.from(state);

    if (currentSelection.contains(teamId)) {
      currentSelection.remove(teamId);
    } else {
      currentSelection.add(teamId);
    }

    emit(currentSelection);
  }

  /// Save selected teams to Hive
  Future<void> saveSelection() async {
    await _teamsBox.put(_teamsKey, state);
  }

  /// Check if a team is selected
  bool isTeamSelected(String teamId) {
    return state.contains(teamId);
  }

  /// Get selected team models
  List<TeamModel> get selectedTeams {
    return TeamModel.getTeamsByIds(state);
  }

  /// Clear all selections
  void clearSelection() {
    emit([]);
  }

  @override
  Future<void> close() {
    _teamsBox.close();
    return super.close();
  }
}
