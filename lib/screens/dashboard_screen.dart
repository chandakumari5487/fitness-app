import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../controllers/controllers.dart';
import '../utils/app_theme.dart';
import '../widgets/shared_widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<DashboardController>();
    return GradientScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DashHeader(c: c),
              const SizedBox(height: 16),
              FadeInUp(
                delay: const Duration(milliseconds: 100),
                child: _HeroSection(),
              ),
              const SizedBox(height: 16),
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: _StatsRow(c: c),
              ),
              const SizedBox(height: 20),
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.paddingLg,
                  ),
                  child: const SectionHeader(
                    title: 'Weekly Activity',
                    actionLabel: 'View all',
                  ),
                ),
              ),
              const SizedBox(height: 12),
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: _ActivityRingCard(),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashHeader extends StatelessWidget {
  final DashboardController c;
  const _DashHeader({required this.c});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimens.paddingLg,
        16,
        AppDimens.paddingLg,
        0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    c.greetingTime.value,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    c.userName.value,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppGradients.purpleCyan,
              border: Border.all(color: AppColors.glassBorder, width: 0.5),
            ),
            child: const Center(
              child: Text(
                'AJ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLg),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2D1B69), Color(0xFF1A0A3E)],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.purple.withOpacity(0.4),
            width: 0.5,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            GlowCircle(
              color: AppColors.purple,
              size: 180,
              alignment: Alignment.topRight,
            ),
            GlowCircle(
              color: AppColors.cyan,
              size: 120,
              alignment: Alignment.bottomLeft,
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimens.paddingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'TODAY\'S GOAL',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                      color: AppColors.purpleLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Chest &\nTriceps Day',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '6 exercises · 45 min',
                    style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 14),
                  GradientButton(
                    label: '▶  Start Workout',
                    gradient: AppGradients.purple,
                    height: 42,
                    width: 155,
                    onTap:
                        () => Get.snackbar(
                          '🏋️ Let\'s Go!',
                          'Starting Chest & Triceps Day...',
                          backgroundColor: AppColors.purple.withOpacity(0.9),
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP,
                          borderRadius: 16,
                          margin: const EdgeInsets.all(16),
                        ),
                  ),
                ],
              ),
            ),
            // 3D Avatar SVG-style figure
            Positioned(
              right: 0,
              bottom: 0,
              child: SizedBox(
                width: 120,
                height: 185,
                child: CustomPaint(painter: _AvatarPainter()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AvatarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final purplePaint = Paint()..color = const Color(0xFF7B2FF7);
    final darkPurplePaint = Paint()..color = const Color(0xFF4C1D95);
    final cyanPaint = Paint()..color = const Color(0xFF00D4FF);
    final lightPaint = Paint()..color = Colors.white.withOpacity(0.2);
    final accentPaint = Paint()..color = const Color(0xFFA855F7);

    // Glow
    final glowPaint =
        Paint()
          ..color = const Color(0xFF7B2FF7).withOpacity(0.15)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.6),
        width: 80,
        height: 120,
      ),
      glowPaint,
    );

    // Legs
    final legPaint =
        Paint()
          ..color = const Color(0xFF4C1D95)
          ..strokeWidth = 12
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(size.width * 0.42, size.height * 0.60),
      Offset(size.width * 0.32, size.height * 0.84),
      legPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.58, size.height * 0.60),
      Offset(size.width * 0.68, size.height * 0.84),
      legPaint,
    );

    // Shoes
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.30, size.height * 0.88),
        width: 18,
        height: 10,
      ),
      darkPurplePaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.70, size.height * 0.88),
        width: 18,
        height: 10,
      ),
      darkPurplePaint,
    );

    // Torso
    final rrect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width * 0.50, size.height * 0.48),
        width: 36,
        height: 44,
      ),
      const Radius.circular(10),
    );
    canvas.drawRRect(rrect, purplePaint);

    // Chest highlights
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.28, size.height * 0.38, 14, 16),
        const Radius.circular(6),
      ),
      lightPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.44, size.height * 0.38, 14, 16),
        const Radius.circular(6),
      ),
      lightPaint,
    );

    // Arms - raised up holding dumbbells
    final armPaint =
        Paint()
          ..color = const Color(0xFF7B2FF7)
          ..strokeWidth = 8
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;
    final forearmPaint =
        Paint()
          ..color = const Color(0xFF6020C0)
          ..strokeWidth = 7
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;

    // Left arm
    canvas.drawLine(
      Offset(size.width * 0.32, size.height * 0.42),
      Offset(size.width * 0.14, size.height * 0.30),
      armPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.14, size.height * 0.30),
      Offset(size.width * 0.08, size.height * 0.18),
      forearmPaint,
    );

    // Right arm
    canvas.drawLine(
      Offset(size.width * 0.68, size.height * 0.42),
      Offset(size.width * 0.86, size.height * 0.30),
      armPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.86, size.height * 0.30),
      Offset(size.width * 0.92, size.height * 0.18),
      forearmPaint,
    );

    // Dumbbells
    for (final isLeft in [true, false]) {
      final bx = isLeft ? size.width * 0.04 : size.width * 0.88;
      final by = size.height * 0.13;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset(bx, by), width: 10, height: 10),
          const Radius.circular(4),
        ),
        cyanPaint,
      );
      final barPaint =
          Paint()
            ..color = Colors.white.withOpacity(0.7)
            ..strokeWidth = 6
            ..strokeCap = StrokeCap.round
            ..style = PaintingStyle.stroke;
      canvas.drawLine(
        Offset(bx + (isLeft ? 4 : -4), by),
        Offset(bx + (isLeft ? 14 : -14), by),
        barPaint,
      );
    }

    // Head
    canvas.drawCircle(
      Offset(size.width * 0.50, size.height * 0.26),
      18,
      accentPaint,
    );

    // Eyes
    canvas.drawCircle(
      Offset(size.width * 0.44, size.height * 0.24),
      3,
      Colors.white.withOpacity(0.9) as Paint? ??
          (Paint()..color = Colors.white.withOpacity(0.9)),
    );
    canvas.drawCircle(
      Offset(size.width * 0.56, size.height * 0.24),
      3,
      Paint()..color = Colors.white.withOpacity(0.9),
    );

    // Smile
    final smilePaint =
        Paint()
          ..color = Colors.white.withOpacity(0.9)
          ..strokeWidth = 1.5
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;
    final smilePath =
        Path()
          ..moveTo(size.width * 0.42, size.height * 0.29)
          ..quadraticBezierTo(
            size.width * 0.50,
            size.height * 0.33,
            size.width * 0.58,
            size.height * 0.29,
          );
    canvas.drawPath(smilePath, smilePaint);

    // Energy sparks
    final sparkPaint =
        Paint()
          ..color = AppColors.cyan.withOpacity(0.8)
          ..strokeWidth = 1.5
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(size.width * 0.05, size.height * 0.09),
      Offset(size.width * 0.02, size.height * 0.04),
      sparkPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.94, size.height * 0.09),
      Offset(size.width * 0.97, size.height * 0.04),
      sparkPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StatsRow extends StatelessWidget {
  final DashboardController c;
  const _StatsRow({required this.c});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLg),
      child: Row(
        children:
            c.stats.asMap().entries.map((e) {
              final stat = e.value;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: e.key < c.stats.length - 1 ? 10 : 0,
                  ),
                  child: GlassCard(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 8,
                    ),
                    child: Column(
                      children: [
                        Text(stat.emoji, style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 4),
                        NeonText(
                          text: stat.value,
                          fontSize: 17,
                          color: stat.glowColor,
                          fontWeight: FontWeight.w700,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          stat.label,
                          style: const TextStyle(
                            fontSize: 9,
                            color: AppColors.textMuted,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}

class _ActivityRingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLg),
      child: GlassCard(
        child: Row(
          children: [
            SizedBox(
              width: 90,
              height: 90,
              child: CustomPaint(painter: _RingsPainter()),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Weekly Goal',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                _ringLegendRow(AppColors.purple, 'Move 3.2 km'),
                _ringLegendRow(AppColors.cyan, 'Exercise 42 min'),
                _ringLegendRow(AppColors.coral, 'Stand 8 / 10 hrs'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _ringLegendRow(Color color, String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

class _RingsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final rings = [
      (radius: 38.0, color: AppColors.purple, sweep: 0.80),
      (radius: 27.0, color: AppColors.cyan, sweep: 0.65),
      (radius: 16.0, color: AppColors.coral, sweep: 0.55),
    ];

    for (final ring in rings) {
      // Track
      canvas.drawCircle(
        center,
        ring.radius,
        Paint()
          ..color = Colors.white.withOpacity(0.07)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 8,
      );
      // Fill
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: ring.radius),
        -1.5708,
        ring.sweep * 2 * 3.14159,
        false,
        Paint()
          ..color = ring.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 8
          ..strokeCap = StrokeCap.round,
      );
    }

    // Center text
    final textPainter = TextPainter(
      text: const TextSpan(
        text: '84%',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(
      canvas,
      center - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
