import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lex_core/core/constants/app_assets.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/validation/app_validation.dart';
import 'package:lex_core/features/student/presentation/providers/student_auth_provider/student_signup_provider.dart';
import 'package:lex_core/app/router/route_names.dart';
import 'package:lex_core/features/student/presentation/states/student_auth_state/student_signup_state.dart';
import 'package:lex_core/shared/widgets/custom_button.dart';
import 'package:lex_core/shared/widgets/custom_dialog.dart';
import 'package:lex_core/shared/widgets/custom_text.dart';
import 'package:lex_core/shared/widgets/custom_text_field.dart';
import 'package:lex_core/shared/widgets/loading_indicator.dart';
import 'package:sizer/sizer.dart';

class StudentSignupScreen extends ConsumerStatefulWidget {
  const StudentSignupScreen({super.key});

  @override
  ConsumerState<StudentSignupScreen> createState() =>
      _StudentSignupScreenState();
}

class _StudentSignupScreenState extends ConsumerState<StudentSignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _fatherNameController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _dobController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _universityController.dispose();
    super.dispose();
  }

  void _showSuccesssDialog(String message) {
    _fatherNameController.clear();
    _fullNameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _dobController.clear();
    _phoneController.clear();
    _addressController.clear();
    _universityController.clear();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => CustomDialog(
        title: "Success",
        description: message,
        buttonText: "OK",
        icon: Icons.check_circle,
        onPressed: () {
          Navigator.of(context).pop();
        },
        buttonGradient: const [Color(0xFF00FF7F), Color(0xFF006400)],
      ),
    );
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (_) => CustomDialog(
        title: title,
        description: message,
        buttonText: "OK",
        icon: Icons.error_outline,
        buttonGradient: const [Color(0xFFFF6B6B), Color(0xFFC0392B)],
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Future<void> _studentSignup() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final fullName = _fullNameController.text.trim();
    final fatherName = _fatherNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final dob = _dobController.text.trim();
    final phoneNumber = _phoneController.text.trim();
    final address = _addressController.text.trim();
    final university = _universityController.text.trim();
    if (fullName.isEmpty ||
        fatherName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        dob.isEmpty ||
        phoneNumber.isEmpty ||
        address.isEmpty ||
        university.isEmpty) {
      _showErrorDialog("Incomplete Information", "Please fill all the fields.");
      return;
    }

    await ref
        .read(studentSignupProvider.notifier)
        .studentSignupCont(
          fullName: fullName,
          fatherName: fatherName,
          dob: dob,
          phoneNumber: phoneNumber,
          university: university,
          address: address,
          password: password,
          email: email,
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<StudentSignupState>(studentSignupProvider, (previous, next) {
      if (next is StudentSignupSuccess) {
        _showSuccesssDialog(next.message);
      } else if (next is StudentSignupFailure) {
        _showErrorDialog("Signup Failed", next.error);
      }
    });
    final isLoading = ref.watch(studentSignupProvider) is StudentSignupLoading;
    return Scaffold(
      backgroundColor: AppColors.kBgDeep, // Updated to match premium UI
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.kTextPrimary, size: 18),
            ),
            onPressed: () => context.go(RouteNames.incomingUserScreen),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Beautiful Premium Header Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.35,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/signup_bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.kBgDeep.withValues(alpha: 0.7),
                      AppColors.kBgDeep,
                    ],
                    stops: const [0.3, 0.8, 1.0],
                  ),
                ),
              ),
            ),
          ),

          // Scrollable Form Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.12),

                    // Icon instead of circle
                    const Icon(Icons.school_rounded, color: AppColors.kBrand, size: 64),
                    const SizedBox(height: 16),

                    Text('Student Registration', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.kTextPrimary)),
                    const SizedBox(height: 8),
                    Text('Elevate your career\nYour Legal Journey Starts Here', textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, color: AppColors.kTextSecondary)),
                    const SizedBox(height: 40),

                    _buildForm(
                      "Full Name",
                      _fullNameController,
                      Icons.person,
                      AppValidation.validateFullName,
                    ),
                    SizedBox(height: 16),
                    _buildForm(
                      "Date of Birth",
                      _dobController,
                      Icons.calendar_month,
                      AppValidation.checkText,
                    ),
                    SizedBox(height: 16),
                    _buildForm(
                      "Father's Name",
                      _fatherNameController,
                      Icons.person,
                      AppValidation.validateFullName,
                    ),
                    SizedBox(height: 16),
                    _buildForm(
                      "Email Address",
                      _emailController,
                      Icons.mail,
                      AppValidation.validateEmail,
                    ),
                    SizedBox(height: 16),
                    _buildPasswordField(),
                    SizedBox(height: 16),
                    _buildForm(
                      "University/Institure",
                      _universityController,
                      Icons.account_balance_sharp,
                      AppValidation.checkText,
                    ),
                    SizedBox(height: 16),
                    _buildForm(
                      "Phone Number",
                      _phoneController,
                      Icons.phone,
                      AppValidation.validatePhoneNumber,
                    ),
                    SizedBox(height: 16),
                    _buildForm(
                      "Address",
                      _addressController,
                      Icons.location_on,
                      AppValidation.checkText,
                    ),
                    SizedBox(height: 32),
                    _buildStudentSignupButton(isLoading),
                    SizedBox(height: 24),
                    Center(child: _loginTagLine()),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(
    String hint,
    TextEditingController controller,
    IconData icon,
    String? Function(String?)? validator, {
    TextInputType? keyboardType,
  }) {
    return CustomTextField(
      controller: controller,
      hintText: hint,
      prefixIcon: Icon(icon, color: AppColors.kEmerald, size: 3.h),
      validator: validator,
      keyboardType: keyboardType,
      textColor: AppColors.kTextPrimary,
      hintTextColor: AppColors.kTextSecondary,
    );
  }

  Widget _buildPasswordField() {
    return CustomTextField(
      controller: _passwordController,
      hintText: "Create Password",
      prefixIcon: Icon(Icons.lock, color: AppColors.kEmerald, size: 22),
      obscureText: _obscurePassword,
      validator: AppValidation.checkText,
      textColor: AppColors.kTextPrimary,
      hintTextColor: AppColors.kTextSecondary,
      suffixIcon: IconButton(
        icon: Icon(
          _obscurePassword ? Icons.visibility_off : Icons.visibility,
          color: AppColors.kEmerald.withOpacity(0.8),
        ),
        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
      ),
    );
  }

  Widget _buildStudentSignupButton(bool isLoading) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: isLoading
          ? Center(child: LoadingIndicator(color: AppColors.kEmerald))
          : CustomButton(
              text: 'Register',
              onPressed: _studentSignup,
              gradient: LinearGradient(
                colors: [AppColors.kEmerald, AppColors.kEmeraldDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              textColor: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              borderRadius: 16,
            ),
    );
  }

  Widget _loginTagLine() {
    return RichText(
      text: TextSpan(
        text: "Already registered? ",
        style: TextStyle(color: AppColors.kTextSecondary, fontSize: 15.sp),
        children: [
          TextSpan(
            text: 'Sign In',
            style: TextStyle(
              color: AppColors.kEmerald,
              fontWeight: FontWeight.w600,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => context.go(RouteNames.studentLoginScreen),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return TextButton(
      onPressed: () => context.go(RouteNames.incomingUserScreen),
      child: Text(
        'â† Back to Role Selection',
        style: TextStyle(color: AppColors.kTextSecondary, fontSize: 14.sp),
      ),
    );
  }
}

