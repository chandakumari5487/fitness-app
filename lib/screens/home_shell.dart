import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/controllers.dart';
import '../utils/app_theme.dart';
import 'dashboard_screen.dart';
import 'workout_screen.dart';
import 'progress_screen.dart';
import 'diet_screen.dart';
import 'membership_screen.dart';

class HomeShell extends StatelessWidget {
  const HomeShell({super.key});

  static const _screens = [
    DashboardScreen(),
    WorkoutScreen(),
    ProgressScreen(),
    DietScreen(),
    MembershipScreen(),
  ];

  static const _navItems = [
    _NavItem(emoji: '🏠', label: 'Home'),
    _NavItem(emoji: '💪', label: 'Workouts'),
    _NavItem(emoji: '📊', label: 'Progress'),
    _NavItem(emoji: '🥗', label: 'Diet'),
    _NavItem(emoji: '👑', label: 'Plans'),
  ];

  @override
  Widget build(BuildContext context) {
    final nav = Get.find<NavController>();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: Stack(
        children: [
          // Gradient background
          Container(decoration: const BoxDecoration(gradient: AppGradients.background)),

          // Screens
          Obx(() => IndexedStack(
            index: nav.currentIndex.value,
            children: _screens,
          )),

          // Bottom Nav
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: _BottomNav(nav: nav, items: _navItems),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  final String emoji;
  final String label;
  const _NavItem({required this.emoji, required this.label});
}

class _BottomNav extends StatelessWidget {
  final NavController nav;
  final List<_NavItem> items;

  const _BottomNav({required this.nav, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xF00F0C29),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.08), width: 0.5)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: items.asMap().entries.map((e) {
              return Expanded(
                child: Obx(() {
                  final isActive = nav.currentIndex.value == e.key;
                  return GestureDetector(
                    onTap: () => nav.changePage(e.key),
                    behavior: HitTestBehavior.opaque,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedScale(
                            scale: isActive ? 1.15 : 1.0,
                            duration: const Duration(milliseconds: 200),
                            child: Text(e.value.emoji, style: const TextStyle(fontSize: 22)),
                          ),
                          const SizedBox(height: 2),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: isActive ? 4 : 0,
                            height: isActive ? 4 : 0,
                            decoration: const BoxDecoration(
                              color: AppColors.purpleLight,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(height: 1),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              color: isActive ? AppColors.purpleLight : AppColors.textMuted,
                            ),
                            child: Text(e.value.label),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
