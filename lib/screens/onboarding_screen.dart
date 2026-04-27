import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../controllers/auth_controller.dart';
import '../utils/auth_theme.dart';

// ─── Onboarding Screen ────────────────────────────────────
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AuthController>();
    return AuthScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              FadeInDown(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const StepIndicator(currentStep: 3, totalSteps: 3),
                    const Text(
                      'Step 3 of 3',
                      style: TextStyle(
                        fontSize: 11,
                        color: AC.textHint,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              FadeInUp(
                delay: const Duration(milliseconds: 80),
                child: const Text(
                  'Your fitness goal 🎯',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AC.text,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              FadeInUp(
                delay: const Duration(milliseconds: 120),
                child: const Text(
                  "We'll personalize your plan based on this",
                  style: TextStyle(fontSize: 12, color: AC.textMuted),
                ),
              ),
              const SizedBox(height: 24),

              // Goal options
              ...c.goals.asMap().entries.map(
                (e) => FadeInLeft(
                  delay: Duration(milliseconds: 160 + e.key * 80),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _GoalOption(
                      index: e.key,
                      data: e.value,
                      controller: c,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Days per week
              FadeInUp(
                delay: const Duration(milliseconds: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'How many days/week can you train?',
                      style: TextStyle(
                        fontSize: 12,
                        color: AC.textMuted,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 12),
                    Obx(
                      () => Row(
                        children:
                            [2, 3, 4, 5, 6, 7].map((d) {
                              final isSelected = c.selectedDays.value == d;
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: GestureDetector(
                                    onTap: () => c.selectDays(d),
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      height: 40,
                                      decoration: BoxDecoration(
                                        gradient: isSelected ? AG.purple : null,
                                        color:
                                            isSelected
                                                ? null
                                                : Colors.white.withOpacity(
                                                  0.06,
                                                ),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow:
                                            isSelected
                                                ? [
                                                  BoxShadow(
                                                    color: AC.purple
                                                        .withOpacity(0.4),
                                                    blurRadius: 12,
                                                  ),
                                                ]
                                                : null,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '$d',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color:
                                              isSelected
                                                  ? Colors.white
                                                  : AC.textMuted,
                                          fontFamily: 'Poppins',
                                        ),
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

              const SizedBox(height: 32),

              // Body info section
              FadeInUp(
                delay: const Duration(milliseconds: 560),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Body details (optional)',
                      style: TextStyle(
                        fontSize: 12,
                        color: AC.textMuted,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _InfoPill(
                            label: 'Height',
                            value: '175 cm',
                            emoji: '📏',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _InfoPill(
                            label: 'Weight',
                            value: '80 kg',
                            emoji: '⚖️',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _InfoPill(
                            label: 'Age',
                            value: '26',
                            emoji: '🎂',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              FadeInUp(
                delay: const Duration(milliseconds: 620),
                child: Obx(
                  () => AuthGradientButton(
                    label: 'Start My Journey 🚀',
                    isLoading: c.isLoading.value,
                    onTap: c.finishOnboarding,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoalOption extends StatelessWidget {
  final int index;
  final Map<String, String> data;
  final AuthController controller;

  const _GoalOption({
    required this.index,
    required this.data,
    required this.controller,
  });

  static const List<Color> _bgColors = [
    Color(0xFF7B2FF7),
    Color(0xFFE94560),
    Color(0xFF00D4FF),
    Color(0xFF4ADE80),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.selectedGoalIndex.value == index;
      final color = _bgColors[index];
      return GestureDetector(
        onTap: () => controller.selectGoal(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color:
                isSelected
                    ? color.withOpacity(0.18)
                    : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color:
                  isSelected
                      ? color.withOpacity(0.6)
                      : Colors.white.withOpacity(0.12),
              width: isSelected ? 1.5 : 0.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? color.withOpacity(0.3)
                          : color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Center(
                  child: Text(
                    data['emoji'] ?? '',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['title'] ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AC.text,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      data['sub'] ?? '',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AC.textMuted,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: isSelected ? AG.purple : null,
                  border:
                      isSelected
                          ? null
                          : Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child:
                    isSelected
                        ? const Icon(Icons.check, size: 12, color: Colors.white)
                        : null,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _InfoPill extends StatelessWidget {
  final String label, value, emoji;
  const _InfoPill({
    required this.label,
    required this.value,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: AC.glass,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AC.glassBorder, width: 0.5),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AC.text,
              fontFamily: 'Poppins',
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 9,
              color: AC.textMuted,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Success Screen ───────────────────────────────────────
class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _confettiCtrl;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _confettiCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnim = CurvedAnimation(
      parent: _confettiCtrl,
      curve: Curves.elasticOut,
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      _confettiCtrl.forward();
    });
  }

  @override
  void dispose() {
    _confettiCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AuthController>();

    return AuthScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),

                  /// 🎉 ANIMATION
                  ScaleTransition(
                    scale: _scaleAnim,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                AC.green.withOpacity(0.25),
                                AC.purple.withOpacity(0.15),
                              ],
                            ),
                            border: Border.all(
                              color: AC.green.withOpacity(0.5),
                              width: 2,
                            ),
                          ),
                          child: const Center(
                            child: Text('🎉', style: TextStyle(fontSize: 50)),
                          ),
                        ),
                        Positioned(
                          top: -4,
                          right: -4,
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [AC.green, Color(0xFF22C55E)],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AC.green.withOpacity(0.5),
                                  blurRadius: 12,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  /// ✅ FIXED (userFirstName.value)
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: Obx(
                      () => Text(
                        "You're all set, ${c.userFirstName.value}! 💪",
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: AC.text,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  FadeInUp(
                    delay: const Duration(milliseconds: 480),
                    child: const Text(
                      'Your personalized APEX plan is ready.\nTime to crush those goals.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: AC.textMuted,
                        height: 1.7,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  /// ✅ FIXED PLAN SUMMARY (ALL Rx used properly)
                  FadeInUp(
                    delay: const Duration(milliseconds: 560),
                    child: Obx(
                      () => Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 0.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'YOUR PLAN SUMMARY',
                              style: TextStyle(
                                fontSize: 10,
                                color: AC.textHint,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.5,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(height: 14),

                            _summaryRow(
                              '🎯',
                              'Goal',
                              c.selectedGoalTitle.value,
                              AC.purpleL,
                            ),

                            _divider(),

                            _summaryRow(
                              '📅',
                              'Frequency',
                              '${c.selectedDays.value} days/week',
                              AC.cyan,
                            ),

                            _divider(),

                            _summaryRow('🤖', 'AI Coach', 'Active', AC.green),

                            _divider(),

                            _summaryRow('⚡', 'Free Trial', '7 days', AC.amber),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  FadeInUp(
                    delay: const Duration(milliseconds: 660),
                    child: AuthGradientButton(
                      label: 'Go to Dashboard',
                      onTap: () => Get.offAllNamed('/home'),
                    ),
                  ),

                  const SizedBox(height: 10),

                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    child: const Center(
                      child: Text(
                        'No credit card required · Cancel anytime',
                        style: TextStyle(
                          fontSize: 11,
                          color: AC.textHint,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// SUMMARY ROW
  Widget _summaryRow(
    String emoji,
    String label,
    String value,
    Color valueColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: valueColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AC.textMuted,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: valueColor,
              fontFamily: 'Poppins',
              shadows: [
                Shadow(color: valueColor.withOpacity(0.5), blurRadius: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() =>
      Container(height: 0.5, color: Colors.white.withOpacity(0.06));
}
