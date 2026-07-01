import 'package:flutter_riverpod/legacy.dart';
import 'package:lex_core/features/auth/presentation/controllers/forgot_password_controller.dart';
import 'package:lex_core/features/auth/presentation/states/forogot_password_State.dart';

final forgotPasswordProvider =
    StateNotifierProvider<ForgotPasswordController, ForgotPasswordState>(
      (ref) => ForgotPasswordController(),
    );

