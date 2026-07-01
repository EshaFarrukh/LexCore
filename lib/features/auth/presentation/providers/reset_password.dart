import 'package:flutter_riverpod/legacy.dart';
import 'package:lex_core/features/auth/presentation/controllers/reset_password_controller.dart';
import 'package:lex_core/features/auth/presentation/states/reset_password_state.dart';

final resetPasswordProvider =
    StateNotifierProvider<ResetPasswordController, ResetPasswordState>(
      (ref) => ResetPasswordController(),
    );

