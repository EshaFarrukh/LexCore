import 'package:flutter_riverpod/legacy.dart';
import 'package:lex_core/di/injection_container.dart';
import 'package:lex_core/features/auth/domain/usecases/auth_usecases.dart';
import 'package:lex_core/features/student/presentation/states/student_auth_state/student_signup_state.dart';

class StudentSignupController extends StateNotifier<StudentSignupState> {
  final SignupUseCase _signupUseCase;

  StudentSignupController({SignupUseCase? signupUseCase})
      : _signupUseCase = signupUseCase ?? sl<SignupUseCase>(),
        super(StudentSignupInitial());

  Future<void> studentSignupCont({
    required String fullName,
    required String fatherName,
    required String dob,
    required String phoneNumber,
    required String university,
    required String address,
    required String password,
    required String email,
  }) async {
    state = StudentSignupLoading();
    try {
      final body = {
        "fullName": fullName,
        "email": email,
        "phone": phoneNumber,
        "password": password,
        "address": "Father: $fatherName, DOB: $dob, Uni: $university, Address: $address",
        "role": "student",
      };

      final responseData = await _signupUseCase.execute(body);
      if (responseData['statusCode'] == 200 || responseData['statusCode'] == 201) {
        state = StudentSignupSuccess("Signup Successfull");
      } else {
        state = StudentSignupFailure(responseData['message'] ?? "Signup Failed");
      }
    } catch (e) {
      state = StudentSignupFailure("Signup Failed: $e");
    }
  }
}

