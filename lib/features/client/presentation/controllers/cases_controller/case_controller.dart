import 'dart:developer';

import 'package:flutter_riverpod/legacy.dart';
import 'package:lex_core/core/constants/app_keys.dart';
import 'package:lex_core/core/utils/storage/storage_service.dart';
import 'package:lex_core/di/injection_container.dart';
import 'package:lex_core/features/client/domain/entities/case_entity.dart';
import 'package:lex_core/features/client/domain/usecases/client_usecases.dart';
import 'package:lex_core/features/client/presentation/states/case_states/case_states.dart';

class CaseController extends StateNotifier<CaseStates> {
  final GetCasesByUserIdUseCase _getCasesUseCase;

  CaseController({GetCasesByUserIdUseCase? getCasesUseCase})
      : _getCasesUseCase = getCasesUseCase ?? sl<GetCasesByUserIdUseCase>(),
        super(CaseInitialState());

  Future<void> getAllCases() async {
    state = CaseLoadingState();
    try {
      String? userId = await StorageService.instance.read(AppKeys.userIdKey);
      if (userId == null || userId.isEmpty) {
        userId = 'client_1'; // Fallback for mock data
      }

      final List<CaseEntity> allCasesList = await _getCasesUseCase.execute(userId);

      final pendingList = allCasesList.where((c) {
        final s = c.status.toLowerCase();
        return s != 'disposed' && s != 'closed';
      }).toList();

      final disposedList = allCasesList.where((c) {
        final s = c.status.toLowerCase();
        return s == 'disposed' || s == 'closed';
      }).toList();

      final allCases = AllCasesResponse(
        pendingCases: pendingList,
        disposedCases: disposedList,
      );

      state = CaseSuccessState(data: allCases);
    } catch (e, stack) {
      log("Get All Cases → Error: $e\n$stack");
      state = CaseFailureState(error: "Unable to load cases. Please check your internet connection and try again.");
    }
  }
}
