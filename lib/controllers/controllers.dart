import 'package:get/get.dart';
import '../models/models.dart';
import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

// ─── Nav Controller ──────────────────────────────────────
class NavController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changePage(int index) => currentIndex.value = index;
}

// ─── Dashboard Controller ─────────────────────────────────
class DashboardController extends GetxController {
  final RxInt caloriesBurned = 847.obs;
  final RxInt stepsToday = 12400.obs;
  final RxDouble waterLiters = 2.1.obs;
  final RxDouble weeklyGoalPercent = 0.84.obs;
  final RxString userName = 'Alex Johnson'.obs;
  final RxString greetingTime = ''.obs;
  final RxBool isLoading = false.obs;

  final List<StatModel> stats = AppData.dashStats;

  @override
  void onInit() {
    super.onInit();
    _setGreeting();
  }

  void _setGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      greetingTime.value = 'Good morning 💪';
    } else if (hour < 17) {
      greetingTime.value = 'Good afternoon 🏋️';
    } else {
      greetingTime.value = 'Good evening 🌙';
    }
  }

  void addWater() {
    if (waterLiters.value < 3.0) {
      waterLiters.value = double.parse(
        (waterLiters.value + 0.25).toStringAsFixed(2),
      );
    }
  }
}

// ─── Workout Controller ───────────────────────────────────
class WorkoutController extends GetxController {
  final RxList<WorkoutModel> workouts = AppData.workouts.obs;
  final RxList<WorkoutModel> filteredWorkouts = <WorkoutModel>[].obs;
  final RxInt selectedFilter = 0.obs;
  final RxString activeWorkoutId = ''.obs;
  final RxBool isStarting = false.obs;

  final List<String> filters = ['All', 'Strength', 'Cardio', 'HIIT', 'Yoga'];

  @override
  void onInit() {
    super.onInit();
    filteredWorkouts.assignAll(workouts);
  }

  void selectFilter(int index) {
    selectedFilter.value = index;
    final filter = filters[index];
    if (filter == 'All') {
      filteredWorkouts.assignAll(workouts);
    } else {
      filteredWorkouts.assignAll(
        workouts.where((w) => w.category.toLowerCase() == filter.toLowerCase()),
      );
    }
  }

  void startWorkout(WorkoutModel workout) {
    isStarting.value = true;
    activeWorkoutId.value = workout.id;
    Future.delayed(const Duration(milliseconds: 300), () {
      isStarting.value = false;
      Get.snackbar(
        '🏋️ Workout Started!',
        '${workout.title} - Let\'s crush it!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.purple.withOpacity(0.9),
        colorText: AppColors.textPrimary,
        borderRadius: 16,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      );
    });
  }
}

// Need to import AppColors for snackbar

// ─── Progress Controller ──────────────────────────────────
class ProgressController extends GetxController {
  final RxList<double> weeklyCalories = AppData.weeklyCalories.obs;
  final RxList<MetricModel> metrics = AppData.metrics.obs;
  final RxList<bool> streakDays = AppData.streakDone.obs;
  final RxInt streakCount = 14.obs;
  final RxInt selectedChip = 0.obs;

  final List<String> chips = ['💪 Strength', '🏃 Cardio', '🔥 Fat Loss'];

  double get maxCalorie => weeklyCalories.reduce((a, b) => a > b ? a : b);
  double get totalWeekCalories => weeklyCalories.fold(0, (a, b) => a + b);
}

// ─── Diet Controller ─────────────────────────────────────
class DietController extends GetxController {
  final RxList<MealModel> meals = AppData.meals.obs;
  final RxInt waterCups = 5.obs;
  final int totalCups = 8;

  double get proteinPct => 0.38;
  double get carbsPct => 0.29;
  double get fatsPct => 0.29;
  double get fiberPct => 0.04;

  int get totalCalories => meals.fold(0, (sum, m) => sum + m.calories);

  void toggleWaterCup(int index) {
    waterCups.value = index + 1;
  }

  bool isCupFilled(int index) => index < waterCups.value;
}

// ─── Membership Controller ────────────────────────────────
class MembershipController extends GetxController {
  final RxList<PlanModel> plans = AppData.plans.obs;
  final RxString selectedPlan = 'basic'.obs;
  final RxBool isProcessing = false.obs;

  void selectPlan(String planId) {
    if (planId == 'basic') return;
    selectedPlan.value = planId;
  }

  void subscribe(PlanModel plan) {
    if (plan.id == 'basic') return;
    isProcessing.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isProcessing.value = false;
      Get.snackbar(
        '🎉 Subscribed!',
        'Welcome to ${plan.name}! Your 7-day free trial has started.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.purple.withOpacity(0.9),
        colorText: Colors.white,
        borderRadius: 16,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      );
    });
  }
}
