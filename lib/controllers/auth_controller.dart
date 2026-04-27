/* import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // ── Form fields ───────────────────────────────────────
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();

  // ── Reactive state ────────────────────────────────────
  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmVisible = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool rememberMe = true.obs;
  final RxBool agreedToTerms = true.obs;
  final RxString passwordStrength = ''.obs;
  final RxDouble strengthValue = 0.0.obs;
  final RxInt selectedTabIndex = 0.obs; // 0=login, 1=signup
  final RxInt onboardingStep = 0.obs;   // 0,1,2
  final RxInt selectedGoalIndex = 0.obs;
  final RxInt selectedDays = 5.obs;

  final List<Map<String, String>> goals = [
    {'emoji': '💪', 'title': 'Build muscle', 'sub': 'Strength & hypertrophy focus'},
    {'emoji': '🔥', 'title': 'Lose weight', 'sub': 'Cardio & calorie deficit'},
    {'emoji': '🏃', 'title': 'Improve endurance', 'sub': 'Stamina & cardio training'},
    {'emoji': '🧘', 'title': 'Stay active & healthy', 'sub': 'Balanced lifestyle plan'},
  ];

  // ── Computed ──────────────────────────────────────────
  String get userFirstName => firstNameCtrl.text.isEmpty ? 'Alex' : firstNameCtrl.text;
  String get selectedGoalTitle => goals[selectedGoalIndex.value]['title'] ?? '';

  @override
  void onInit() {
    super.onInit();
    passwordCtrl.addListener(_evaluateStrength);
  }

  void _evaluateStrength() {
    final p = passwordCtrl.text;
    int score = 0;
    if (p.length >= 8) score++;
    if (RegExp(r'[A-Z]').hasMatch(p)) score++;
    if (RegExp(r'[0-9]').hasMatch(p)) score++;
    if (RegExp(r'[!@#\$%^&*]').hasMatch(p)) score++;

    strengthValue.value = score / 4.0;
    if (score <= 1) passwordStrength.value = 'Weak';
    else if (score == 2) passwordStrength.value = 'Fair';
    else if (score == 3) passwordStrength.value = 'Good';
    else passwordStrength.value = 'Strong';
  }

  Color get strengthColor {
    switch (passwordStrength.value) {
      case 'Weak': return const Color(0xFFE24B4A);
      case 'Fair': return const Color(0xFFF59E0B);
      case 'Good': return const Color(0xFF00D4FF);
      default: return const Color(0xFF4ADE80);
    }
  }

  void togglePasswordVisibility() => isPasswordVisible.toggle();
  void toggleConfirmVisibility() => isConfirmVisible.toggle();
  void toggleRememberMe() => rememberMe.toggle();
  void toggleTerms() => agreedToTerms.toggle();
  void selectTab(int i) => selectedTabIndex.value = i;
  void selectGoal(int i) => selectedGoalIndex.value = i;
  void selectDays(int d) => selectedDays.value = d;

  Future<void> login() async {
    if (emailCtrl.text.isEmpty || passwordCtrl.text.isEmpty) {
      Get.snackbar('⚠️ Missing fields', 'Please enter email and password',
          backgroundColor: const Color(0xFFE94560).withOpacity(0.9),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(16),
          borderRadius: 16);
      return;
    }
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;
    Get.offAllNamed('/home');
  }

  Future<void> signUp() async {
    if (!agreedToTerms.value) {
      Get.snackbar('⚠️ Terms required', 'Please agree to the Terms of Service',
          backgroundColor: const Color(0xFFE94560).withOpacity(0.9),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(16),
          borderRadius: 16);
      return;
    }
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;
    Get.toNamed('/onboarding');
  }

  Future<void> finishOnboarding() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
    Get.toNamed('/success');
  }

  Future<void> googleSignIn() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
    Get.snackbar('🔗 Google', 'Google sign-in integration ready!',
        backgroundColor: const Color(0xFF7B2FF7).withOpacity(0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(16),
        borderRadius: 16);
  }

  Future<void> appleSignIn() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
    Get.snackbar('🍎 Apple', 'Apple sign-in integration ready!',
        backgroundColor: const Color(0xFF7B2FF7).withOpacity(0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(16),
        borderRadius: 16);
  }

  @override
  void onClose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    phoneCtrl.dispose();
    confirmPassCtrl.dispose();
    super.onClose();
  }
}
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // ── Form fields ───────────────────────────────────────
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();

  // ── Reactive state ────────────────────────────────────
  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmVisible = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool rememberMe = true.obs;
  final RxBool agreedToTerms = true.obs;

  final RxString passwordStrength = ''.obs;
  final RxDouble strengthValue = 0.0.obs;

  final RxInt selectedTabIndex = 0.obs;
  final RxInt onboardingStep = 0.obs;
  final RxInt selectedGoalIndex = 0.obs;
  final RxInt selectedDays = 5.obs;

  // ✅ FIX: make reactive
  final RxString userFirstName = 'Alex'.obs;
  final RxString selectedGoalTitle = ''.obs;

  final List<Map<String, String>> goals = [
    {
      'emoji': '💪',
      'title': 'Build muscle',
      'sub': 'Strength & hypertrophy focus',
    },
    {'emoji': '🔥', 'title': 'Lose weight', 'sub': 'Cardio & calorie deficit'},
    {
      'emoji': '🏃',
      'title': 'Improve endurance',
      'sub': 'Stamina & cardio training',
    },
    {
      'emoji': '🧘',
      'title': 'Stay active & healthy',
      'sub': 'Balanced lifestyle plan',
    },
  ];

  @override
  void onInit() {
    super.onInit();

    passwordCtrl.addListener(_evaluateStrength);

    /// ✅ FIX: first name reactive
    firstNameCtrl.addListener(() {
      userFirstName.value =
          firstNameCtrl.text.isEmpty ? 'Alex' : firstNameCtrl.text;
    });

    /// ✅ FIX: goal reactive
    ever(selectedGoalIndex, (_) {
      selectedGoalTitle.value = goals[selectedGoalIndex.value]['title'] ?? '';
    });

    /// initial value set
    selectedGoalTitle.value = goals[selectedGoalIndex.value]['title'] ?? '';
  }

  void _evaluateStrength() {
    final p = passwordCtrl.text;

    int score = 0;
    if (p.length >= 8) score++;
    if (RegExp(r'[A-Z]').hasMatch(p)) score++;
    if (RegExp(r'[0-9]').hasMatch(p)) score++;
    if (RegExp(r'[!@#\$%^&*]').hasMatch(p)) score++;

    strengthValue.value = score / 4.0;

    if (score <= 1)
      passwordStrength.value = 'Weak';
    else if (score == 2)
      passwordStrength.value = 'Fair';
    else if (score == 3)
      passwordStrength.value = 'Good';
    else
      passwordStrength.value = 'Strong';
  }

  Color get strengthColor {
    switch (passwordStrength.value) {
      case 'Weak':
        return const Color(0xFFE24B4A);
      case 'Fair':
        return const Color(0xFFF59E0B);
      case 'Good':
        return const Color(0xFF00D4FF);
      default:
        return const Color(0xFF4ADE80);
    }
  }

  // ── Actions ───────────────────────────────────────────
  void togglePasswordVisibility() => isPasswordVisible.toggle();
  void toggleConfirmVisibility() => isConfirmVisible.toggle();
  void toggleRememberMe() => rememberMe.toggle();
  void toggleTerms() => agreedToTerms.toggle();

  void selectTab(int i) => selectedTabIndex.value = i;

  void selectGoal(int i) {
    selectedGoalIndex.value = i;
  }

  void selectDays(int d) => selectedDays.value = d;

  Future<void> login() async {
    if (emailCtrl.text.isEmpty || passwordCtrl.text.isEmpty) {
      Get.snackbar(
        '⚠️ Missing fields',
        'Please enter email and password',
        backgroundColor: const Color(0xFFE94560).withOpacity(0.9),
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;

    Get.offAllNamed('/home');
  }

  Future<void> signUp() async {
    if (!agreedToTerms.value) {
      Get.snackbar(
        '⚠️ Terms required',
        'Please agree to the Terms of Service',
        backgroundColor: const Color(0xFFE94560).withOpacity(0.9),
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;

    Get.toNamed('/onboarding');
  }

  Future<void> finishOnboarding() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;

    Get.toNamed('/success');
  }

  Future<void> googleSignIn() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
  }

  Future<void> appleSignIn() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
  }

  @override
  void onClose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    phoneCtrl.dispose();
    confirmPassCtrl.dispose();
    super.onClose();
  }
}
