import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

// ─── Workout Model ───────────────────────────────────────
class WorkoutModel {
  final String id;
  final String title;
  final String subtitle;
  final String category;
  final String emoji;
  final int durationMin;
  final int calories;
  final String level;
  final double progress;
  final LinearGradient gradient;
  final Color accentColor;
  final List<ExerciseModel> exercises;

  const WorkoutModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.emoji,
    required this.durationMin,
    required this.calories,
    required this.level,
    required this.progress,
    required this.gradient,
    required this.accentColor,
    required this.exercises,
  });
}

class ExerciseModel {
  final String name;
  final String sets;
  final String reps;
  final String emoji;

  const ExerciseModel({
    required this.name,
    required this.sets,
    required this.reps,
    required this.emoji,
  });
}

// ─── Meal Model ──────────────────────────────────────────
class MealModel {
  final String name;
  final String items;
  final int calories;
  final String emoji;
  final Color iconBg;
  final int protein;
  final int carbs;
  final int fats;

  const MealModel({
    required this.name,
    required this.items,
    required this.calories,
    required this.emoji,
    required this.iconBg,
    required this.protein,
    required this.carbs,
    required this.fats,
  });
}

// ─── Membership Plan ─────────────────────────────────────
class PlanModel {
  final String id;
  final String name;
  final String price;
  final String period;
  final String emoji;
  final List<String> features;
  final List<String> lockedFeatures;
  final bool isPopular;
  final LinearGradient? gradient;
  final Color? borderColor;
  final String buttonLabel;

  const PlanModel({
    required this.id,
    required this.name,
    required this.price,
    required this.period,
    required this.emoji,
    required this.features,
    this.lockedFeatures = const [],
    this.isPopular = false,
    this.gradient,
    this.borderColor,
    required this.buttonLabel,
  });
}

// ─── Stat Model ──────────────────────────────────────────
class StatModel {
  final String label;
  final String value;
  final String emoji;
  final Color glowColor;

  const StatModel({
    required this.label,
    required this.value,
    required this.emoji,
    required this.glowColor,
  });
}

// ─── Progress Metric ─────────────────────────────────────
class MetricModel {
  final String label;
  final String value;
  final String unit;
  final String trend;
  final bool trendUp;
  final Color valueColor;

  const MetricModel({
    required this.label,
    required this.value,
    required this.unit,
    required this.trend,
    required this.trendUp,
    required this.valueColor,
  });
}

// ─── Sample Data ─────────────────────────────────────────
class AppData {
  static List<WorkoutModel> get workouts => [
    WorkoutModel(
      id: 'w1',
      title: 'Power Lift Pro',
      subtitle: 'Full body compound movements',
      category: 'STRENGTH',
      emoji: '🏋️',
      durationMin: 55,
      calories: 520,
      level: 'Advanced',
      progress: 0.68,
      gradient: AppGradients.workoutPurple,
      accentColor: AppColors.purple,
      exercises: const [
        ExerciseModel(name: 'Bench Press', sets: '4', reps: '8-10', emoji: '🏋️'),
        ExerciseModel(name: 'Squat', sets: '4', reps: '6-8', emoji: '🦵'),
        ExerciseModel(name: 'Deadlift', sets: '3', reps: '5', emoji: '💪'),
        ExerciseModel(name: 'OHP', sets: '3', reps: '8-10', emoji: '⬆️'),
        ExerciseModel(name: 'Pull-ups', sets: '3', reps: '8-12', emoji: '🔝'),
        ExerciseModel(name: 'Core Circuit', sets: '3', reps: '15', emoji: '🔥'),
      ],
    ),
    WorkoutModel(
      id: 'w2',
      title: 'Sprint & Burn',
      subtitle: 'Treadmill HIIT intervals',
      category: 'CARDIO',
      emoji: '🏃',
      durationMin: 30,
      calories: 380,
      level: 'Medium',
      progress: 0.40,
      gradient: AppGradients.workoutBlue,
      accentColor: AppColors.cyan,
      exercises: const [
        ExerciseModel(name: 'Warm-up Jog', sets: '1', reps: '5 min', emoji: '🚶'),
        ExerciseModel(name: 'Sprint Burst', sets: '8', reps: '30 sec', emoji: '⚡'),
        ExerciseModel(name: 'Active Rest', sets: '8', reps: '60 sec', emoji: '🧘'),
        ExerciseModel(name: 'Cool Down', sets: '1', reps: '5 min', emoji: '❄️'),
      ],
    ),
    WorkoutModel(
      id: 'w3',
      title: 'Combat Shred',
      subtitle: 'Boxing + core circuit',
      category: 'HIIT',
      emoji: '🥊',
      durationMin: 40,
      calories: 640,
      level: 'Intense',
      progress: 0.20,
      gradient: AppGradients.workoutRed,
      accentColor: AppColors.coral,
      exercises: const [
        ExerciseModel(name: 'Shadow Boxing', sets: '3', reps: '3 min', emoji: '🥊'),
        ExerciseModel(name: 'Burpees', sets: '4', reps: '15', emoji: '⬇️'),
        ExerciseModel(name: 'Mountain Climbers', sets: '4', reps: '20', emoji: '🏔️'),
        ExerciseModel(name: 'Jump Rope', sets: '3', reps: '2 min', emoji: '🪢'),
        ExerciseModel(name: 'Plank Hold', sets: '3', reps: '45 sec', emoji: '💪'),
      ],
    ),
  ];

  static List<MealModel> get meals => [
    MealModel(
      name: 'Breakfast',
      items: 'Oats · Eggs · Banana',
      calories: 480,
      emoji: '🌅',
      iconBg: const Color(0x26EAB308),
      protein: 32, carbs: 58, fats: 12,
    ),
    MealModel(
      name: 'Lunch',
      items: 'Chicken rice bowl · Greens',
      calories: 620,
      emoji: '🥗',
      iconBg: const Color(0x2622C55E),
      protein: 48, carbs: 72, fats: 14,
    ),
    MealModel(
      name: 'Snack',
      items: 'Protein bar · Apple',
      calories: 240,
      emoji: '🍎',
      iconBg: const Color(0x26EF4444),
      protein: 20, carbs: 28, fats: 6,
    ),
    MealModel(
      name: 'Dinner',
      items: 'Salmon · Sweet potato',
      calories: 500,
      emoji: '🌙',
      iconBg: const Color(0x26A855F7),
      protein: 42, carbs: 44, fats: 16,
    ),
  ];

  static List<PlanModel> get plans => [
    PlanModel(
      id: 'basic',
      name: 'Basic',
      price: 'Free',
      period: 'forever',
      emoji: '⚡',
      features: ['3 workouts per week', 'Basic diet tracking'],
      lockedFeatures: ['AI coach', 'Custom plans'],
      buttonLabel: 'Current Plan',
    ),
    PlanModel(
      id: 'pro',
      name: 'Pro',
      price: '₹999',
      period: 'month',
      emoji: '🚀',
      features: ['Unlimited workouts', 'AI personal coach', 'Custom meal plans', 'Advanced analytics'],
      isPopular: true,
      gradient: AppGradients.workoutPurple,
      borderColor: AppColors.purple,
      buttonLabel: 'Upgrade to Pro',
    ),
    PlanModel(
      id: 'elite',
      name: 'Elite',
      price: '₹2,499',
      period: 'month',
      emoji: '👑',
      features: ['Everything in Pro', 'Live trainer sessions', 'Supplement guidance', 'Priority support 24/7'],
      gradient: AppGradients.eliteGold,
      borderColor: AppColors.amber,
      buttonLabel: 'Go Elite',
    ),
  ];

  static List<StatModel> get dashStats => [
    StatModel(label: 'Cal burned', value: '847', emoji: '🔥', glowColor: AppColors.coral),
    StatModel(label: 'Steps today', value: '12.4k', emoji: '⚡', glowColor: AppColors.cyan),
    StatModel(label: 'Water intake', value: '2.1L', emoji: '💧', glowColor: AppColors.purpleLight),
  ];

  static List<MetricModel> get metrics => [
    MetricModel(label: 'Body Weight', value: '78.4', unit: 'kg', trend: '↓ 1.2 kg this month', trendUp: false, valueColor: AppColors.cyan),
    MetricModel(label: 'Body Fat', value: '16.2', unit: '%', trend: '↓ 0.8% this month', trendUp: false, valueColor: AppColors.coral),
    MetricModel(label: 'Muscle Mass', value: '61.8', unit: 'kg', trend: '↑ 0.5 kg this month', trendUp: true, valueColor: AppColors.purpleLight),
    MetricModel(label: 'Workouts', value: '24', unit: '/ mo', trend: '↑ 4 vs last month', trendUp: true, valueColor: AppColors.cyan),
  ];

  static List<double> get weeklyCalories => [420, 580, 510, 760, 680, 847, 720];
  static const List<String> weekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  static const List<String> streakDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  static const List<bool> streakDone = [true, true, true, false, false, false, false];
}
