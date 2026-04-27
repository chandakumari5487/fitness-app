import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../controllers/auth_controller.dart';
import '../utils/auth_theme.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AuthController>();

    return AuthScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// LOGO
              FadeInDown(
                child: Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        gradient: AG.purple,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: const Center(
                        child: Text('💪', style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ShaderMask(
                      shaderCallback: (b) => AG.brand.createShader(b),
                      child: const Text(
                        'FITO',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// ✅ FIXED TAB ROW (NO Obx here)
              FadeInUp(
                delay: const Duration(milliseconds: 100),
                child: _TabRow(c: c),
              ),

              const SizedBox(height: 24),

              /// SCREEN SWITCH
              Obx(
                () =>
                    c.selectedTabIndex.value == 0
                        ? _LoginForm(c: c)
                        : _SignUpForm(c: c),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// TAB ROW (FIXED)
////////////////////////////////////////////////////////////

class _TabRow extends StatelessWidget {
  final AuthController c;
  const _TabRow({required this.c});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        height: 48,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(children: [_tab('Log In', 0), _tab('Sign Up', 1)]),
      );
    });
  }

  Widget _tab(String label, int index) {
    final isActive = c.selectedTabIndex.value == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => c.selectTab(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            gradient: isActive ? AG.purple : null,
            borderRadius: BorderRadius.circular(10),
            boxShadow:
                isActive
                    ? [
                      BoxShadow(
                        color: AC.purple.withOpacity(0.4),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ]
                    : null,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              color: isActive ? Colors.white : AC.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Login Form ───────────────────────────────────────────
class _LoginForm extends StatelessWidget {
  final AuthController c;
  const _LoginForm({required this.c});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInUp(
          child: const Text(
            'Welcome back 👋',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AC.text,
            ),
          ),
        ),
        const SizedBox(height: 4),
        FadeInUp(
          delay: const Duration(milliseconds: 80),
          child: const Text(
            'Enter your credentials to continue',
            style: TextStyle(fontSize: 12, color: AC.textMuted),
          ),
        ),
        const SizedBox(height: 24),

        FadeInUp(
          delay: const Duration(milliseconds: 120),
          child: GlassInput(
            controller: c.emailCtrl,
            hint: 'Email address',
            prefixEmoji: '✉️',
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        const SizedBox(height: 12),

        FadeInUp(
          delay: const Duration(milliseconds: 160),
          child: Obx(
            () => GlassInput(
              controller: c.passwordCtrl,
              hint: 'Password',
              prefixEmoji: '🔒',
              obscure: !c.isPasswordVisible.value,
              suffix: IconButton(
                icon: Icon(
                  c.isPasswordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  size: 18,
                  color: AC.textMuted,
                ),
                onPressed: c.togglePasswordVisibility,
              ),
              textInputAction: TextInputAction.done,
            ),
          ),
        ),

        FadeInUp(
          delay: const Duration(milliseconds: 180),
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: GestureDetector(
                onTap: () => _showForgotPassword(context, c),
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(
                    fontSize: 12,
                    color: AC.purpleL,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),

        FadeInUp(
          delay: const Duration(milliseconds: 220),
          child: Obx(
            () => AuthGradientButton(
              label: 'Log In',
              isLoading: c.isLoading.value,
              onTap: c.login,
            ),
          ),
        ),

        OrDivider(),

        FadeInUp(
          delay: const Duration(milliseconds: 280),
          child: Column(
            children: [
              AuthGradientButton(
                label: 'Continue with Google',
                gradient: const LinearGradient(colors: [AC.glass, AC.glass]),
                borderColor: AC.glassBorder,
                textColor: AC.text,
                icon: const GoogleIcon(size: 18),
                onTap: c.googleSignIn,
              ),
              const SizedBox(height: 10),
              SocialButton(
                label: 'Continue with Apple',
                icon: const AppleIcon(size: 20, color: Colors.black),
                bgColor: Colors.white.withOpacity(0.95),
                textColor: const Color(0xFF111111),
                onTap: c.appleSignIn,
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),
        FadeInUp(
          delay: const Duration(milliseconds: 320),
          child: Center(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 12,
                  color: AC.textMuted,
                  fontFamily: 'Poppins',
                ),
                children: [
                  const TextSpan(text: "Don't have an account? "),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () => c.selectTab(1),
                      child: const Text(
                        'Sign up free',
                        style: TextStyle(
                          color: AC.purpleL,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showForgotPassword(BuildContext context, AuthController c) {
    final resetCtrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder:
          (_) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              decoration: const BoxDecoration(
                gradient: AG.bg,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                border: BorderDirectional(
                  top: BorderSide(color: AC.glassBorder, width: 0.5),
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Reset password 🔑',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AC.text,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Enter your email and we\'ll send a reset link',
                    style: TextStyle(fontSize: 12, color: AC.textMuted),
                  ),
                  const SizedBox(height: 20),
                  GlassInput(
                    controller: resetCtrl,
                    hint: 'Email address',
                    prefixEmoji: '✉️',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  AuthGradientButton(
                    label: 'Send Reset Link',
                    onTap: () {
                      Get.back();
                      Get.snackbar(
                        '📧 Sent!',
                        'Check your inbox for the reset link',
                        backgroundColor: AC.purple.withOpacity(0.9),
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                        borderRadius: 16,
                        margin: const EdgeInsets.all(16),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
    );
  }
}

// ─── Sign Up Form ─────────────────────────────────────────

class _SignUpForm extends StatelessWidget {
  final AuthController c;
  const _SignUpForm({required this.c});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInUp(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Create account 🚀',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AC.text,
                ),
              ),
              const StepIndicator(currentStep: 2, totalSteps: 3),
            ],
          ),
        ),
        const SizedBox(height: 4),

        FadeInUp(
          delay: const Duration(milliseconds: 100),
          child: const Text(
            'Start your fitness journey today',
            style: TextStyle(fontSize: 12, color: AC.textMuted),
          ),
        ),

        const SizedBox(height: 20),

        /// NAME ROW
        FadeInUp(
          delay: const Duration(milliseconds: 100),
          child: Row(
            children: [
              Expanded(
                child: GlassInput(
                  controller: c.firstNameCtrl,
                  hint: 'First name',
                  prefixEmoji: '👤',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GlassInput(
                  controller: c.lastNameCtrl,
                  hint: 'Last name',
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        FadeInUp(
          delay: const Duration(milliseconds: 130),
          child: GlassInput(
            controller: c.emailCtrl,
            hint: 'Email address',
            prefixEmoji: '✉️',
            keyboardType: TextInputType.emailAddress,
          ),
        ),

        const SizedBox(height: 12),

        FadeInUp(
          delay: const Duration(milliseconds: 155),
          child: GlassInput(
            controller: c.phoneCtrl,
            hint: 'Phone number',
            prefixEmoji: '📱',
            keyboardType: TextInputType.phone,
          ),
        ),

        const SizedBox(height: 12),

        /// PASSWORD FIELD (CORRECT)
        FadeInUp(
          delay: const Duration(milliseconds: 175),
          child: Obx(
            () => GlassInput(
              controller: c.passwordCtrl,
              hint: 'Create password',
              prefixEmoji: '🔒',
              obscure: !c.isPasswordVisible.value,
              suffix: IconButton(
                icon: Icon(
                  c.isPasswordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  size: 18,
                  color: AC.textMuted,
                ),
                onPressed: c.togglePasswordVisibility,
              ),
            ),
          ),
        ),

        const SizedBox(height: 8),

        /// ✅ FIXED PASSWORD STRENGTH (NO ERROR)
        FadeInUp(
          delay: const Duration(milliseconds: 195),
          child: Obx(() {
            // 👇 IMPORTANT: ONLY Rx use karo
            if (c.strengthValue.value == 0) {
              return const SizedBox();
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: PasswordStrengthBar(
                value: c.strengthValue.value,
                label: c.passwordStrength.value,
                color: c.strengthColor,
              ),
            );
          }),
        ),

        /// TERMS
        FadeInUp(
          delay: const Duration(milliseconds: 210),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Obx(
              () => GestureDetector(
                onTap: c.toggleTerms,
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        gradient: c.agreedToTerms.value ? AG.purple : null,
                        border:
                            c.agreedToTerms.value
                                ? null
                                : Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child:
                          c.agreedToTerms.value
                              ? const Icon(
                                Icons.check,
                                size: 13,
                                color: Colors.white,
                              )
                              : null,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 11,
                            color: AC.textMuted,
                            fontFamily: 'Poppins',
                          ),
                          children: [
                            TextSpan(text: 'I agree to the '),
                            TextSpan(
                              text: 'Terms of Service',
                              style: TextStyle(
                                color: AC.purpleL,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                color: AC.purpleL,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        /// BUTTON
        FadeInUp(
          delay: const Duration(milliseconds: 240),
          child: Obx(
            () => AuthGradientButton(
              label: 'Create My Account',
              isLoading: c.isLoading.value,
              onTap: c.signUp,
            ),
          ),
        ),

        OrDivider(),

        /// SOCIAL
        FadeInUp(
          delay: const Duration(milliseconds: 290),
          child: Row(
            children: [
              Expanded(
                child: AuthGradientButton(
                  label: 'Google',
                  gradient: const LinearGradient(colors: [AC.glass, AC.glass]),
                  borderColor: AC.glassBorder,
                  textColor: AC.text,
                  icon: const GoogleIcon(size: 16),
                  onTap: c.googleSignIn,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SocialButton(
                  label: 'Apple',
                  icon: const AppleIcon(size: 18, color: Colors.black),
                  bgColor: Colors.white.withOpacity(0.95),
                  textColor: const Color(0xFF111111),
                  onTap: c.appleSignIn,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        /// LOGIN LINK
        FadeInUp(
          delay: const Duration(milliseconds: 320),
          child: Center(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 12,
                  color: AC.textMuted,
                  fontFamily: 'Poppins',
                ),
                children: [
                  const TextSpan(text: 'Already have an account? '),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () => c.selectTab(0),
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                          color: AC.purpleL,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
