import 'package:flutter_riverpod/legacy.dart';
import 'package:lex_core/core/network/api_exceptions.dart';
import 'package:lex_core/di/injection_container.dart';
import 'package:lex_core/features/auth/domain/usecases/auth_usecases.dart';
import 'package:lex_core/features/auth/presentation/states/signup_state.dart';

class SignupController extends StateNotifier<SignupState> {
  final SignupUseCase _signupUseCase;

  SignupController({SignupUseCase? useCase})
      : _signupUseCase = useCase ?? sl<SignupUseCase>(),
        super(SignupInitial());

  Future<String?> signup({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String address,
    required String userType,
  }) async {
    state = SignupLoading();
    try {
      final body = {
        "fullName": fullName,
        "email": email,
        "phone": phone,
        "password": password,
        "address": address,
        "role": userType,
      };

      final responseData = await _signupUseCase.execute(body);

      if (responseData['statusCode'] == 200 || responseData['statusCode'] == 201) {
        final Map<String, dynamic> data = responseData['data'] as Map<String, dynamic>;
        final user = data['user'] as Map<String, dynamic>;
        final String userId = user['id'] as String;
        final String message = responseData['message'] ?? 'Signup Successful';

        state = SignupSuccess(message);
        return userId;
      } else {
        state = SignupFailure(responseData['message'] ?? 'Signup Failed');
        return null;
      }
    } on ApiException catch (e) {
      state = SignupFailure(e.message);
      return null;
    } catch (e, st) {
      state = SignupFailure("Error: ${e.toString()}");
      return null;
    }
  }
}
