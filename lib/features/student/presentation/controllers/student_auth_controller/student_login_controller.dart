import 'dart:developer';

import 'package:flutter_riverpod/legacy.dart';
import 'package:lex_core/core/network/api_exceptions.dart';
import 'package:lex_core/core/utils/storage/storage_service.dart';
import 'package:lex_core/core/constants/app_keys.dart';
import 'package:lex_core/di/injection_container.dart';
import 'package:lex_core/features/auth/domain/usecases/auth_usecases.dart';
import 'package:lex_core/features/student/presentation/states/student_auth_state/student_login_state.dart';

class StudentLoginController extends StateNotifier<StudentLoginState> {
  final LoginUseCase _loginUseCase;

  StudentLoginController({LoginUseCase? useCase}) 
      : _loginUseCase = useCase ?? sl<LoginUseCase>(),
        super(StudentLoginInitial());

  Future<Map<String, dynamic>?> studentlLogin({
    required String email,
    required String password,
  }) async {
    state = StudentLoginLoading();
    try {
      final responseData = await _loginUseCase.execute(email, password);

      if (responseData['statusCode'] == 200 || responseData['statusCode'] == 201) {
        final data = responseData['data'] as Map<String, dynamic>;
        final user = data['user'] as Map<String, dynamic>;
        
        final String userId = user['id'] as String;
        final String userType = user['role'] as String;
        final String fullName = user['name'] as String;

        if (userType != 'student') {
          state = StudentLoginFailure("You do not have permission to access this profile.");
          return null;
        }
        
        await StorageService.instance.write(AppKeys.userIdKey, userId);
        await StorageService.instance.write(AppKeys.userTypeKey, userType);
        await StorageService.instance.write(AppKeys.fullNameKey, fullName);

        state = StudentLoginSuccess(
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
        state = StudentLoginFailure(responseData['message'] ?? 'Login Failed');
        return null;
      }
    } on ApiException catch (e) {
      state = StudentLoginFailure(e.message);
      return null;
    } catch (e, stackTrace) {
      log("LoginController -> Error: $e");
      log(stackTrace.toString());
      state = StudentLoginFailure(e.toString().replaceAll('Exception: ', ''));
      return null;
    }
  }
}
