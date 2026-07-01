import 'package:flutter_riverpod/legacy.dart';
import 'package:lex_core/features/client/presentation/controllers/cases_controller/case_controller.dart';
import 'package:lex_core/features/client/presentation/states/case_states/case_states.dart';

final caseControllerProvider =
    StateNotifierProvider<CaseController, CaseStates>((ref) {
      return CaseController();
    });

