import 'package:fito/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:fl_chart/fl_chart.dart';
import '../controllers/controllers.dart';
import '../utils/app_theme.dart';
import '../widgets/shared_widgets.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProgressController>();
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
                        'My Progress',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Track your fitness journey',
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
                child: _CalorieChart(c: c),
              ),
              const SizedBox(height: 14),
              FadeInUp(
                delay: const Duration(milliseconds: 150),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.paddingLg,
                  ),
                  child: _ChipRow(c: c),
                ),
              ),
              const SizedBox(height: 14),
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: _MetricsGrid(c: c),
              ),
              const SizedBox(height: 14),
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: _StreakCard(c: c),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

class _CalorieChart extends StatelessWidget {
  final ProgressController c;
  const _CalorieChart({required this.c});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLg),
      child: GlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Calories Burned',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                  ),
                  child: const Text(
                    'This week',
                    style: TextStyle(fontSize: 10, color: AppColors.textMuted),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 130,
              child: Obx(
                () => LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (val, meta) {
                            const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                            final i = val.toInt();
                            if (i < 0 || i >= days.length)
                              return const SizedBox();
                            return Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                days[i],
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots:
                            c.weeklyCalories
                                .asMap()
                                .entries
                                .map((e) => FlSpot(e.key.toDouble(), e.value))
                                .toList(),
                        isCurved: true,
                        gradient: const LinearGradient(
                          colors: [AppColors.purple, AppColors.cyan],
                        ),
                        barWidth: 2.5,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter:
                              (spot, pct, bar, idx) => FlDotCirclePainter(
                                radius: idx == 5 ? 5 : 3,
                                color:
                                    idx == 5
                                        ? AppColors.purple
                                        : AppColors.cyan,
                                strokeWidth: idx == 5 ? 2 : 0,
                                strokeColor: Colors.white,
                              ),
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.purple.withOpacity(0.4),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ],
                    minX: 0,
                    maxX: 6,
                    minY: 300,
                    maxY: 900,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChipRow extends StatelessWidget {
  final ProgressController c;
  const _ChipRow({required this.c});

  static const colors = [
    AppColors.purpleLight,
    AppColors.cyan,
    AppColors.coral,
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children:
            c.chips.asMap().entries.map((e) {
              final isSelected = c.selectedChip.value == e.key;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => c.selectedChip.value = e.key,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? colors[e.key].withOpacity(0.2)
                              : AppColors.glass,
                      borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                      border: Border.all(
                        color:
                            isSelected
                                ? colors[e.key].withOpacity(0.5)
                                : AppColors.glassBorder,
                        width: 0.5,
                      ),
                    ),
                    child: Text(
                      e.value,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? colors[e.key] : AppColors.textMuted,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}

class _MetricsGrid extends StatelessWidget {
  final ProgressController c;
  const _MetricsGrid({required this.c});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLg),
      child: Obx(
        () => GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.4,
          ),
          itemCount: c.metrics.length,
          itemBuilder: (_, i) {
            final m = c.metrics[i];
            return GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    m.label,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textMuted,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      NeonText(
                        text: m.value,
                        fontSize: 22,
                        color: m.valueColor,
                      ),
                      const SizedBox(width: 4),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text(
                          m.unit,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    m.trend,
                    style: TextStyle(
                      fontSize: 10,
                      color: m.trendUp ? AppColors.green : AppColors.coral,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _StreakCard extends StatefulWidget {
  final ProgressController c;
  const _StreakCard({required this.c});

  @override
  State<_StreakCard> createState() => _StreakCardState();
}

class _StreakCardState extends State<_StreakCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingLg),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHover = true),
        onExit: (_) => setState(() => isHover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform:
              Matrix4.identity()..scale(isHover ? 1.03 : 1.0), // 🔥 zoom effect
          padding: const EdgeInsets.all(AppDimens.paddingMd),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0x337B2FF7), Color(0x1A00D4FF)],
            ),
            borderRadius: BorderRadius.circular(AppDimens.radiusLg),
            border: Border.all(
              color:
                  isHover
                      ? AppColors.purple
                      : AppColors.purple.withOpacity(0.3),
              width: isHover ? 1.2 : 0.5,
            ),
            boxShadow:
                isHover
                    ? [
                      BoxShadow(
                        color: AppColors.purple.withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                    ]
                    : [],
          ),

          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShaderMask(
                    shaderCallback:
                        (bounds) =>
                            AppGradients.purpleCyan.createShader(bounds),
                    child: const Text(
                      '🔥 14',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Text(
                    'Day streak',
                    style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                  ),
                  const Text(
                    'Keep it up!',
                    style: TextStyle(fontSize: 11, color: AppColors.textHint),
                  ),
                ],
              ),

              const Spacer(),

              /// 🔥 ONLY reactive part
              Obx(
                () => Row(
                  children:
                      AppData.streakDays.asMap().entries.map((e) {
                        final isDone = widget.c.streakDays[e.key];
                        final isToday = e.key == 3;

                        return Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 25,
                            height: 30,
                            decoration: BoxDecoration(
                              gradient: isDone ? AppGradients.purple : null,
                              color:
                                  isDone
                                      ? null
                                      : isToday
                                      ? Colors.transparent
                                      : Colors.white.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  isToday
                                      ? Border.all(
                                        color: AppColors.purple,
                                        width: 1.5,
                                      )
                                      : null,
                            ),
                            child: Center(
                              child: Text(
                                e.value,
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      isDone
                                          ? Colors.white
                                          : AppColors.textMuted,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/* class _StreakCard extends StatelessWidget {
  final ProgressController c;
  const _StreakCard({required this.c});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingLg),
      child: Container(
        padding: const EdgeInsets.all(AppDimens.paddingMd),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0x337B2FF7), Color(0x1A00D4FF)],
          ),
          borderRadius: BorderRadius.circular(AppDimens.radiusLg),
          border: Border.all(
            color: AppColors.purple.withOpacity(0.3),
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback:
                      (bounds) => AppGradients.purpleCyan.createShader(bounds),
                  child: const Text(
                    '🔥 14',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Text(
                  'Day streak',
                  style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                ),
                const Text(
                  'Keep it up!',
                  style: TextStyle(fontSize: 11, color: AppColors.textHint),
                ),
              ],
            ),
            const Spacer(),
            Obx(
              () => Row(
                children:
                    AppData.streakDays.asMap().entries.map((e) {
                      final isDone = c.streakDays[e.key];
                      final isToday = e.key == 3;
                      return Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            gradient: isDone ? AppGradients.purple : null,
                            color:
                                isDone
                                    ? null
                                    : isToday
                                    ? Colors.transparent
                                    : Colors.white.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(8),
                            border:
                                isToday
                                    ? Border.all(
                                      color: AppColors.purple,
                                      width: 1.5,
                                    )
                                    : null,
                          ),
                          child: Center(
                            child: Text(
                              e.value,
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color:
                                    isDone ? Colors.white : AppColors.textMuted,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 */