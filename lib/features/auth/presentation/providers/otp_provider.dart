import 'package:flutter_riverpod/legacy.dart';
import 'package:lex_core/features/auth/presentation/controllers/otp_controller.dart';
import 'package:lex_core/features/auth/presentation/states/otp_state.dart';

final otpProvider = StateNotifierProvider<OtpController, OtpState>(
  (ref) => OtpController(),
);

