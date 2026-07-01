import 'dart:developer';

import 'package:flutter_riverpod/legacy.dart';
import 'package:lex_core/di/injection_container.dart';
import 'package:lex_core/features/student/data/models/research_model.dart';
import 'package:lex_core/features/student/domain/usecases/student_usecases.dart';
import 'package:lex_core/features/student/presentation/states/research_states.dart';

class ResearchController extends StateNotifier<ResearchStates> {
  final GetResearchUseCase _getResearchUseCase;

  ResearchController({GetResearchUseCase? getResearchUseCase})
      : _getResearchUseCase = getResearchUseCase ?? sl<GetResearchUseCase>(),
        super(ResearchInitialState());

  Future<void> getAllResearch() async {
    state = ResearchLoadingState();
    try {
      final researchList = await _getResearchUseCase.execute();

      final currentList = researchList.where((r) => r.status == 'active').toList();
      final availableList = researchList.where((r) => r.status != 'active').toList();

      final allResearch = AllResearchResponse(
        currentResearch: currentList,
        availableResearch: availableList,
      );

      state = ResearchSuccessState(data: allResearch);
    } catch (e, stack) {
      log('Get All Research -> Error: $e\n$stack');
      state = ResearchFailureState(error: 'Unable to load research data');
    }
  }

  Future<void> joinResearch(String researchId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      if (state is ResearchSuccessState) {
        final currentData = (state as ResearchSuccessState).data;
        final currentResearch = List<ResearchModel>.from(currentData.currentResearch);
        final availableResearch = List<ResearchModel>.from(currentData.availableResearch);

        final researchToJoin = availableResearch.firstWhere(
          (research) => research.id == researchId,
          orElse: () => throw Exception('Research not found'),
        );

        // Move research from available to current
        final joinedResearch = ResearchModel(
          id: researchToJoin.id,
          title: researchToJoin.title,
          description: researchToJoin.description,
          startDate: researchToJoin.startDate,
          status: 'active',
          supervisor: researchToJoin.supervisor,
        );

        currentResearch.add(joinedResearch);
        availableResearch.removeWhere((research) => research.id == researchId);

        final updatedData = AllResearchResponse(
          currentResearch: currentResearch,
          availableResearch: availableResearch,
        );

        state = ResearchSuccessState(data: updatedData);
      }
    } catch (e, stack) {
      log('Join Research â†’ Error: $e\n$stack');
      state = ResearchFailureState(error: 'Failed to join research topic');
    }
  }

  Future<void> refreshResearch() async {
    await getAllResearch();
  }
}

