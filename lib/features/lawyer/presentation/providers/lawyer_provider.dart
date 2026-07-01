import 'package:flutter_riverpod/legacy.dart';
import 'package:lex_core/features/lawyer/presentation/controllers/lawyer_controller.dart';
import 'package:lex_core/features/lawyer/presentation/states/lawyer_state.dart';

final lawyerProvider = StateNotifierProvider<LawyerController, LawyerState>(
  (ref) => LawyerController(),
);

