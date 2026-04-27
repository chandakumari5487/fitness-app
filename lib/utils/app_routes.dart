import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../screens/auth_screen.dart';
import '../screens/home_shell.dart';
import '../screens/onboarding_screen.dart';
import '../screens/splash_screen.dart';
import '../bindings/app_binding.dart';

/// AUTH BINDING
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
  }
}

/// ROUTES
class AppRoutes {
  static const String splash = '/splash';
  static const String auth = '/auth';
  static const String onboarding = '/onboarding';
  static const String success = '/success';
  static const String home = '/home';

  static final routes = [
    /// SPLASH (no controller needed usually)
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
    ),

    /// AUTH
    GetPage(
      name: auth,
      page: () => const AuthScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeftWithFade,
    ),

    /// ONBOARDING
    GetPage(
      name: onboarding,
      page: () => const OnboardingScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeftWithFade,
    ),

    /// SUCCESS
    GetPage(
      name: success,
      page: () => const SuccessScreen(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
    ),

    /// HOME (app-level binding)
    GetPage(
      name: home,
      page: () => const HomeShell(),
      binding: AppBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}
