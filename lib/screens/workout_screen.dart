import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../controllers/controllers.dart';
import '../models/models.dart';
import '../utils/app_theme.dart';
import '../widgets/shared_widgets.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<WorkoutController>();
    return GradientScaffold(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            FadeInDown(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Workout Plans', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    SizedBox(height: 2),
                    Text('Personalized for your goals', style: TextStyle(fontSize: 13, color: AppColors.textMuted)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            FadeInLeft(child: _FilterTabs(c: c)),
            const SizedBox(height: 4),
            Expanded(
              child: Obx(() => ListView.builder(
                padding: const EdgeInsets.fromLTRB(
                    AppDimens.paddingLg, 8, AppDimens.paddingLg, 100),
                physics: const BouncingScrollPhysics(),
                itemCount: c.filteredWorkouts.length,
                itemBuilder: (ctx, i) => FadeInUp(
                  delay: Duration(milliseconds: i * 120),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _WorkoutCard(workout: c.filteredWorkouts[i], controller: c),
                  ),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterTabs extends StatelessWidget {
  final WorkoutController c;
  const _FilterTabs({required this.c});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLg),
        scrollDirection: Axis.horizontal,
        itemCount: c.filters.length,
        itemBuilder: (ctx, i) => Obx(() {
          final isActive = c.selectedFilter.value == i;
          return GestureDetector(
            onTap: () => c.selectFilter(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
              decoration: BoxDecoration(
                gradient: isActive ? AppGradients.purple : null,
                color: isActive ? null : AppColors.glass,
                borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                border: Border.all(
                  color: isActive ? Colors.transparent : AppColors.glassBorder,
                  width: 0.5,
                ),
                boxShadow: isActive
                    ? [BoxShadow(color: AppColors.purple.withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 4))]
                    : null,
              ),
              child: Text(
                c.filters[i],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isActive ? Colors.white : AppColors.textMuted,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  final WorkoutModel workout;
  final WorkoutController controller;

  const _WorkoutCard({required this.workout, required this.controller});

  Color get _badgeColor {
    switch (workout.category) {
      case 'STRENGTH': return AppColors.purpleLight;
      case 'CARDIO': return AppColors.cyan;
      default: return AppColors.coral;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showWorkoutDetail(context),
      child: Container(
        decoration: BoxDecoration(
          gradient: workout.gradient,
          borderRadius: BorderRadius.circular(AppDimens.radiusLg),
          border: Border.all(color: workout.accentColor.withOpacity(0.4), width: 0.5),
        ),
        child: Stack(
          children: [
            GlowCircle(color: workout.accentColor, size: 110, alignment: Alignment.topRight),
            Padding(
              padding: const EdgeInsets.all(AppDimens.paddingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BadgeChip(label: workout.category, color: _badgeColor),
                      Text(workout.emoji, style: const TextStyle(fontSize: 38)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(workout.title,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                  const SizedBox(height: 4),
                  Text(workout.subtitle,
                      style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      _statChip('⏱', '${workout.durationMin} min'),
                      const SizedBox(width: 18),
                      _statChip('🔥', '${workout.calories} cal'),
                      const SizedBox(width: 18),
                      _statChip('⚡', workout.level),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Progress bar
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Progress', style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
                          Text('${(workout.progress * 100).round()}%',
                              style: TextStyle(fontSize: 10, color: workout.accentColor, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: workout.progress,
                          backgroundColor: Colors.white.withOpacity(0.1),
                          valueColor: AlwaysStoppedAnimation<Color>(workout.accentColor),
                          minHeight: 5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statChip(String icon, String label) {
    return Row(
      children: [
        Text(icon, style: const TextStyle(fontSize: 14)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
      ],
    );
  }

  void _showWorkoutDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _WorkoutDetailSheet(workout: workout, controller: controller),
    );
  }
}

class _WorkoutDetailSheet extends StatelessWidget {
  final WorkoutModel workout;
  final WorkoutController controller;

  const _WorkoutDetailSheet({required this.workout, required this.controller});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      maxChildSize: 0.92,
      minChildSize: 0.4,
      builder: (_, scrollController) => Container(
        decoration: BoxDecoration(
          gradient: workout.gradient,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          border: Border.all(color: workout.accentColor.withOpacity(0.3), width: 0.5),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.all(AppDimens.paddingLg),
                children: [
                  Row(
                    children: [
                      Text(workout.emoji, style: const TextStyle(fontSize: 44)),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(workout.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white)),
                          BadgeChip(label: workout.category, color: workout.accentColor),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('Exercises', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                  const SizedBox(height: 12),
                  ...workout.exercises.asMap().entries.map((e) {
                    final ex = e.value;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.white12, width: 0.5),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36, height: 36,
                            decoration: BoxDecoration(
                              color: workout.accentColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(child: Text(ex.emoji)),
                          ),
                          const SizedBox(width: 12),
                          Expanded(child: Text(ex.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white))),
                          Text('${ex.sets} × ${ex.reps}', style: TextStyle(fontSize: 12, color: workout.accentColor, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 20),
                  GradientButton(
                    label: '▶  Start Now',
                    gradient: LinearGradient(colors: [workout.accentColor, workout.accentColor.withOpacity(0.7)]),
                    shadowColor: workout.accentColor,
                    onTap: () { Get.back(); controller.startWorkout(workout); },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
