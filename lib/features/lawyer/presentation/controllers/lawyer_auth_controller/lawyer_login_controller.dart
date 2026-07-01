import 'dart:developer';

import 'package:flutter_riverpod/legacy.dart';
import 'package:lex_core/core/constants/app_keys.dart';
import 'package:lex_core/core/network/api_exceptions.dart';
import 'package:lex_core/core/utils/storage/storage_service.dart';
import 'package:lex_core/di/injection_container.dart';
import 'package:lex_core/features/auth/domain/usecases/auth_usecases.dart';
import 'package:lex_core/features/lawyer/presentation/states/lawyer_auth_state/lawyer_login_state.dart';

class LawyerLoginController extends StateNotifier<LawyerLoginState> {
  final LoginUseCase _loginUseCase;

  LawyerLoginController({LoginUseCase? loginUseCase})
      : _loginUseCase = loginUseCase ?? sl<LoginUseCase>(),
        super(LawyerLoginInitial());

  Future<Map<String, dynamic>?> lawyerLogin({
    required String email,
    required String password,
  }) async {
    state = LawyerLoginLoading(); // ← Show loading

    try {
      final responseData = await _loginUseCase.execute(email, password);

      if (responseData['statusCode'] == 200 || responseData['statusCode'] == 201) {
        final data = responseData['data'] as Map<String, dynamic>;
        final user = data['user'] as Map<String, dynamic>;
        
        final String userId = user['id'] as String;
        final String userType = user['role'] as String;
        final String fullName = user['name'] as String;

        if (userType != 'lawyer') {
          state = LawyerLoginFailure("You do not have permission to access this profile.");
          return null;
        }

        await StorageService.instance.write(AppKeys.userIdKey, userId);
        await StorageService.instance.write(AppKeys.userTypeKey, userType);
        await StorageService.instance.write(AppKeys.fullNameKey, fullName);

        state = LawyerLoginSuccess(
          fullName: fullName,
          token: "firebase_managed_token",
          message: responseData['message'] ?? 'Login Successful',
        );

        return {
          'userId': userId,
          'userType': userType,
          'fullName': fullName,
        };
      } else {
        state = LawyerLoginFailure(responseData['message'] ?? 'Login Failed');
        return null;
      }
    } on ApiException catch (e) {
      state = LawyerLoginFailure(e.message);
      return null;
    } catch (e, stackTrace) {
      log("LoginController -> Error: $e");
      log(stackTrace.toString());
      state = LawyerLoginFailure(e.toString().replaceAll('Exception: ', ''));
      return null;
    }
  }
}
