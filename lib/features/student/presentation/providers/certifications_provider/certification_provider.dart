import 'package:flutter_riverpod/legacy.dart';
import 'package:lex_core/features/student/presentation/controllers/certifications_controller/certification_controller.dart';
import 'package:lex_core/features/student/presentation/states/certification_states.dart';

final certificationControllerProvider =
    StateNotifierProvider<CertificationController, CertificationStates>((ref) {
  return CertificationController();
});

