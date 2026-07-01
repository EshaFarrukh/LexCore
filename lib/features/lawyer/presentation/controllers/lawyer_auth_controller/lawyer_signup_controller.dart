import 'dart:developer';

import 'package:flutter_riverpod/legacy.dart';
import 'package:lex_core/core/network/api_exceptions.dart';
import 'package:lex_core/di/injection_container.dart';
import 'package:lex_core/features/auth/domain/usecases/auth_usecases.dart';
import 'package:lex_core/features/lawyer/presentation/states/lawyer_auth_state/lawyer_signup_state.dart';

class LawyerSignupController extends StateNotifier<LawyerSignupState> {
  final SignupUseCase _signupUseCase;

  LawyerSignupController({SignupUseCase? signupUseCase})
      : _signupUseCase = signupUseCase ?? sl<SignupUseCase>(),
        super(LawyerSignupInitial());

  Future<void> lawyerSignUp({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    state = LawyerSignupLoading();

    try {
      final body = {
        "fullName": fullName,
        "email": email,
        "phone": phoneNumber,
        "password": password,
        "address": "N/A",
        "role": "lawyer",
      };

      final responseData = await _signupUseCase.execute(body);
      if (responseData['statusCode'] == 200 || responseData['statusCode'] == 201) {
        state = const LawyerSignupSuccess(
            "Your signup request has been sent for verification. Once approved, you can login to the app.");
      } else {
        state = LawyerSignupFailure(
            responseData['errorMessage'] ?? responseData['message'] ?? "Signup Failed");
      }
    } on ApiException catch (e) {
      state = LawyerSignupFailure(e.message);
    } catch (e, st) {
      log("LawyerSignupController → Exception: $e");
      log("StackTrace: $st");
      state = LawyerSignupFailure("Error: ${e.toString()}");
    }
  }
}

