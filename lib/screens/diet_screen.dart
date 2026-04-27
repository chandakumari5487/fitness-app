import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../controllers/controllers.dart';
import '../models/models.dart';
import '../utils/app_theme.dart';
import '../widgets/shared_widgets.dart';

class DietScreen extends StatelessWidget {
  const DietScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<DietController>();
    return GradientScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              FadeInDown(
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimens.paddingLg,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Diet Plan',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Fuel your performance',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              FadeInUp(
                delay: const Duration(milliseconds: 100),
                child: _MacroRingCard(c: c),
              ),
              const SizedBox(height: 14),
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: _WaterCard(c: c),
              ),
              const SizedBox(height: 6),
              FadeInUp(
                delay: const Duration(milliseconds: 250),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.paddingLg,
                  ),
                  child: SectionHeader(
                    title: 'Today\'s Meals',
                    actionLabel: '+ Add meal',
                    onAction:
                        () => Get.snackbar(
                          '🍽️ Add Meal',
                          'Meal logging coming soon!',
                          backgroundColor: AppColors.purple.withOpacity(0.9),
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP,
                          borderRadius: 16,
                          margin: const EdgeInsets.all(16),
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ...c.meals.asMap().entries.map(
                (e) => FadeInLeft(
                  delay: Duration(milliseconds: 300 + e.key * 80),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimens.paddingLg,
                      0,
                      AppDimens.paddingLg,
                      10,
                    ),
                    child: _MealCard(meal: e.value),
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

class _MacroRingCard extends StatelessWidget {
  final DietController c;
  const _MacroRingCard({required this.c});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLg),
      child: GlassCard(
        child: Row(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: const Size(100, 100),
                    painter: _MacroPainter(),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(
                        () => Text(
                          '${c.totalCalories}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Text(
                        'kcal',
                        style: TextStyle(
                          fontSize: 9,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                children: [
                  _macroRow('Protein', '38%', '175g', AppColors.purple),
                  const SizedBox(height: 8),
                  _macroRow('Carbs', '29%', '134g', AppColors.cyan),
                  const SizedBox(height: 8),
                  _macroRow('Fats', '29%', '59g', AppColors.amber),
                  const SizedBox(height: 8),
                  _macroRow('Fiber', '4%', '28g', AppColors.green),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _macroRow(String name, String pct, String grams, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            name,
            style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
          ),
        ),
        Text(
          '$pct  ',
          style: TextStyle(
            fontSize: 11,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          grams,
          style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
        ),
      ],
    );
  }
}

class _MacroPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const radius = 42.0;
    const strokeWidth = 10.0;

    final segments = [
      (sweep: 0.38 * 2 * 3.14159, color: AppColors.purple, start: -1.5708),
      (
        sweep: 0.29 * 2 * 3.14159,
        color: AppColors.cyan,
        start: -1.5708 + 0.38 * 2 * 3.14159,
      ),
      (
        sweep: 0.29 * 2 * 3.14159,
        color: AppColors.amber,
        start: -1.5708 + 0.67 * 2 * 3.14159,
      ),
      (
        sweep: 0.04 * 2 * 3.14159,
        color: AppColors.green,
        start: -1.5708 + 0.96 * 2 * 3.14159,
      ),
    ];

    // Track
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = Colors.white.withOpacity(0.07)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );

    for (final seg in segments) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        seg.start,
        seg.sweep,
        false,
        Paint()
          ..color = seg.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.butt,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _WaterCard extends StatelessWidget {
  final DietController c;
  const _WaterCard({required this.c});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLg),
      child: Container(
        padding: const EdgeInsets.all(AppDimens.paddingMd),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0x260096FF), Color(0x1400D4FF)],
          ),
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          border: Border.all(
            color: AppColors.cyan.withOpacity(0.3),
            width: 0.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '💧 Water Intake',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Obx(
                  () => Text(
                    '${c.waterCups.value * 0.25}L / 2L',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.cyan,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Obx(
              () => Row(
                children: List.generate(c.totalCups, (i) {
                  final filled = c.isCupFilled(i);
                  return GestureDetector(
                    onTap: () => c.toggleWaterCup(i),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(fontSize: filled ? 22 : 18),
                        child: Text(
                          filled ? '🥤' : '⬜',
                          style: TextStyle(
                            fontSize: filled ? 22 : 18,
                            color: filled ? null : Colors.white24,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MealCard extends StatelessWidget {
  final MealModel meal;
  const _MealCard({required this.meal});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: () {},
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: meal.iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(meal.emoji, style: const TextStyle(fontSize: 22)),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  meal.items,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              NeonText(
                text: '${meal.calories}',
                fontSize: 16,
                color: AppColors.cyan,
              ),
              const Text(
                'kcal',
                style: TextStyle(fontSize: 10, color: AppColors.textMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
