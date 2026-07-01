import 'dart:developer';
import 'package:flutter_riverpod/legacy.dart';
import 'package:lex_core/core/constants/app_keys.dart';
import 'package:lex_core/core/network/api_exceptions.dart';
import 'package:lex_core/core/utils/storage/storage_service.dart';
import 'package:lex_core/core/database/hive_service.dart';
import 'package:lex_core/di/injection_container.dart';
import 'package:lex_core/features/auth/domain/usecases/auth_usecases.dart';
import 'package:lex_core/features/auth/presentation/states/login_state.dart';

class LoginController extends StateNotifier<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginController({LoginUseCase? useCase})
      : _loginUseCase = useCase ?? sl<LoginUseCase>(),
        super(LoginInitial());

  Future<Map<String, dynamic>?> login({
    required String email,
    required String password,
  }) async {
    state = LoginLoading();
    try {
      final responseData = await _loginUseCase.execute(email, password);

      if (responseData['statusCode'] == 200 || responseData['statusCode'] == 201) {
        final data = responseData['data'] as Map<String, dynamic>;
        final user = data['user'] as Map<String, dynamic>;
        
        final String userId = user['id'] as String;
        final String userType = user['role'] as String;
        final String fullName = user['name'] as String;
        
        await StorageService.instance.write(AppKeys.userIdKey, userId);
        await StorageService.instance.write(AppKeys.userTypeKey, userType);
        await StorageService.instance.write(AppKeys.fullNameKey, fullName);

        await HiveService.saveUserInfo(
          userId: userId,
          role: userType,
          name: fullName,
        );

        state = LoginSuccess(
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
        state = LoginFailure(responseData['message'] ?? 'Login Failed');
        return null;
      }
    } on ApiException catch (e) {
      state = LoginFailure(e.message);
      return null;
    } catch (e, st) {
      log("LoginController error: $e");
      log("LoginController ST: $st");
      state = LoginFailure("Error: ${e.toString()}");
      return null;
    }
  }
}
