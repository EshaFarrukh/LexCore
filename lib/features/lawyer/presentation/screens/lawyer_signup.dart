import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lex_core/core/constants/app_assets.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/validation/app_validation.dart';
import 'package:lex_core/features/lawyer/presentation/providers/lawyer_auth_provider/lawyer_signup_provider.dart';
import 'package:lex_core/app/router/route_names.dart';
import 'package:lex_core/features/lawyer/presentation/states/lawyer_auth_state/lawyer_signup_state.dart';
import 'package:lex_core/shared/widgets/custom_button.dart';
import 'package:lex_core/shared/widgets/custom_dialog.dart';
import 'package:lex_core/shared/widgets/custom_text.dart';
import 'package:lex_core/shared/widgets/custom_text_field.dart';
import 'package:lex_core/shared/widgets/loading_indicator.dart';
import 'package:sizer/sizer.dart';

class LawyerSignup extends ConsumerStatefulWidget {
  const LawyerSignup({super.key});

  @override
  ConsumerState<LawyerSignup> createState() => _LawyerSignupState();
}

class _LawyerSignupState extends ConsumerState<LawyerSignup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  late final ProviderSubscription<LawyerSignupState> _signupListener;

  @override
  void dispose() {
    _signupListener.close();
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _signupListener =
        ref.listenManual<LawyerSignupState>(lawyerSignupProvider, (prev, next) {
      if (next is LawyerSignupSuccess) {
        _showSuccessDialog(next.message);
      } else if (next is LawyerSignupFailure) {
        _showErrorDialog("Signup Failed", next.error);
      }
    });
  }

  void _showSuccessDialog(String message) {
    _fullNameController.clear();
    _emailController.clear();
    _phoneNumberController.clear();
    _passwordController.clear();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => CustomDialog(
        title: "Verification Pending",
        description: message,
        buttonText: "OK",
        icon: Icons.hourglass_empty_rounded,
        showCloseButton: false,
        onPressed: () {
          Navigator.of(context).pop();
          if (mounted) {
            context.go(RouteNames.lawyerloginScreen);
          }
        },
        buttonGradient: const [Color(0xFFF59E0B), Color(0xFFD97706)],
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

  Future<void> _lawyerSignup() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final phoneNumber = _phoneNumberController.text.trim();
    final password = _passwordController.text.trim();

    if (fullName.isEmpty ||
        email.isEmpty ||
        phoneNumber.isEmpty ||
        password.isEmpty) {
      _showErrorDialog("Validation Error", "All fields are required.");
      return;
    }

    await ref
        .read(lawyerSignupProvider.notifier)
        .lawyerSignUp(
          fullName: fullName,
          email: email,
          phoneNumber: phoneNumber,
          password: password,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(lawyerSignupProvider) is LawyerSignupLoading;

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
                    const Icon(Icons.gavel_rounded, color: AppColors.kBrand, size: 64),
                    const SizedBox(height: 16),

                    Text('Lawyer Registration', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.kTextPrimary)),
                    const SizedBox(height: 8),
                    Text('Join the professional legal network', textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, color: AppColors.kTextSecondary)),
                    const SizedBox(height: 40),

                    _buildField(
                      "Full Name",
                      _fullNameController,
                      Icons.person,
                      AppValidation.checkText,
                    ),
                    SizedBox(height: 16),
                    _buildField(
                      "Email Address",
                      _emailController,
                      Icons.mail,
                      AppValidation.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 16),
                    _buildField(
                      "Phone Number",
                      _phoneNumberController,
                      Icons.phone,
                      AppValidation.validatePhoneNumber,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 16),
                    _buildPasswordField(),
                    SizedBox(height: 32),
                    
                    _buildLawyerSignupButton(isLoading),
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

  Widget _buildField(
    String hint,
    TextEditingController controller,
    IconData icon,
    String? Function(String?)? validator, {
    TextInputType? keyboardType,
  }) {
    return CustomTextField(
      controller: controller,
      hintText: hint,
      prefixIcon: Icon(icon, color: AppColors.kEmerald, size: 22),
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

  Widget _buildLawyerSignupButton(bool isLoading) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: isLoading
          ? Center(child: LoadingIndicator(color: AppColors.kEmerald))
          : CustomButton(
              text: 'Create Lawyer Account',
              onPressed: _lawyerSignup,
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
              ..onTap = () => context.go(RouteNames.lawyerloginScreen),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return TextButton(
      onPressed: () => context.go(RouteNames.incomingUserScreen),
      child: Text(
        '← Back to Role Selection',
        style: TextStyle(color: AppColors.kTextSecondary, fontSize: 14.sp),
      ),
    );
  }
}

