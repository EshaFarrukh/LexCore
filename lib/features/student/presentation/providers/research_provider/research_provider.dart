import 'package:flutter_riverpod/legacy.dart';
import 'package:lex_core/features/student/presentation/controllers/research_controller/research_controller.dart';
import 'package:lex_core/features/student/presentation/states/research_states.dart';

final researchControllerProvider =
    StateNotifierProvider<ResearchController, ResearchStates>((ref) {
  return ResearchController();
});

