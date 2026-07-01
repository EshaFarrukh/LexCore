import 'dart:developer';

import 'package:flutter_riverpod/legacy.dart';
import 'package:lex_core/core/constants/app_keys.dart';
import 'package:lex_core/core/utils/storage/storage_service.dart';
import 'package:lex_core/di/injection_container.dart';
import 'package:lex_core/features/client/domain/entities/case_entity.dart';
import 'package:lex_core/features/client/domain/usecases/client_usecases.dart';
import 'package:lex_core/features/lawyer/domain/entities/lawyer_case_entity.dart';
import 'package:lex_core/features/lawyer/data/models/case_model/lawyer_case_model.dart';
import 'package:lex_core/features/lawyer/presentation/states/case_states/lawyer_case_states.dart';

class LawyerCaseController extends StateNotifier<LawyerCaseStates> {
  final GetCasesByUserIdUseCase _getCasesUseCase;

  LawyerCaseController({GetCasesByUserIdUseCase? getCasesUseCase})
      : _getCasesUseCase = getCasesUseCase ?? sl<GetCasesByUserIdUseCase>(),
        super(LawyerCaseInitialState());

  Future<void> getAllCases() async {
    state = LawyerCaseLoadingState();
    try {
      final String? userId = await StorageService.instance.read(AppKeys.userIdKey);
      if (userId == null || userId.isEmpty) {
        state = LawyerCaseFailureState(error: "User not logged in");
        return;
      }

      final List<CaseEntity> caseEntities = await _getCasesUseCase.execute(userId);

      final List<LawyerCaseModel> allCasesList = caseEntities
          .map((entity) => LawyerCaseModel.fromEntity(entity))
          .toList();

      final pendingList = allCasesList.where((c) {
        final s = c.status.toLowerCase();
        return s != 'disposed' && s != 'closed';
      }).toList();

      final disposedList = allCasesList.where((c) {
        final s = c.status.toLowerCase();
        return s == 'disposed' || s == 'closed';
      }).toList();

      final allCases = AllLawyerCasesResponse(
        pendingCases: pendingList,
        disposedCases: disposedList,
      );

      state = LawyerCaseSuccessState(data: allCases);
    } catch (e, stack) {
      log('Get All Lawyer Cases → Error: $e\n$stack');
      state = LawyerCaseFailureState(error: 'Unable to load lawyer dashboard data');
    }
  }
}
