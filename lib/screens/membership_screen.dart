/* import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../controllers/controllers.dart';
import '../models/models.dart';
import '../utils/app_theme.dart';
import '../widgets/shared_widgets.dart';

class MembershipScreen extends StatelessWidget {
  const MembershipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<MembershipController>();
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
                  padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingLg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Membership', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                      SizedBox(height: 2),
                      Text('Unlock your full potential', style: TextStyle(fontSize: 13, color: AppColors.textMuted)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ...c.plans.asMap().entries.map((e) => FadeInUp(
                delay: Duration(milliseconds: e.key * 120),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(AppDimens.paddingLg, 0, AppDimens.paddingLg, 14),
                  child: _PlanCard(plan: e.value, controller: c),
                ),
              )),
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLg),
                  child: _PerksStrip(),
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

class _PlanCard extends StatelessWidget {
  final PlanModel plan;
  final MembershipController controller;

  const _PlanCard({required this.plan, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isBasic = plan.id == 'basic';
    final isElite = plan.id == 'elite';

    return Obx(() {
      final isSelected = controller.selectedPlan.value == plan.id;

      return GestureDetector(
        onTap: () => controller.selectPlan(plan.id),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            gradient: plan.gradient ?? const LinearGradient(colors: [AppColors.glass, AppColors.glass]),
            borderRadius: BorderRadius.circular(AppDimens.radiusLg),
            border: Border.all(
              color: plan.borderColor?.withOpacity(isSelected ? 0.8 : 0.4) ?? AppColors.glassBorder,
              width: plan.isPopular ? 1.5 : 0.5,
            ),
            boxShadow: plan.isPopular
                ? [BoxShadow(color: AppColors.purple.withOpacity(0.25), blurRadius: 32, offset: const Offset(0, 8))]
                : isElite
                    ? [BoxShadow(color: AppColors.amber.withOpacity(0.2), blurRadius: 24, offset: const Offset(0, 6))]
                    : null,
          ),
          child: Stack(
            children: [
              if (!isBasic) GlowCircle(
                color: plan.id == 'pro' ? AppColors.purple : AppColors.amber,
                size: 120,
                alignment: Alignment.topRight,
              ),
              Padding(
                padding: const EdgeInsets.all(AppDimens.paddingLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(plan.emoji, style: const TextStyle(fontSize: 30)),
                        if (plan.isPopular)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                            decoration: BoxDecoration(
                              gradient: AppGradients.purple,
                              borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                              boxShadow: [BoxShadow(color: AppColors.purple.withOpacity(0.4), blurRadius: 12)],
                            ),
                            child: const Text('MOST POPULAR',
                                style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 0.5)),
                          ),
                        if (isElite)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [Color(0xFFD97706), AppColors.amber]),
                              borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                            ),
                            child: const Text('PREMIUM',
                                style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 0.5)),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(plan.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          plan.price,
                          style: TextStyle(
                            fontSize: isBasic ? 24 : 30,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            '/ ${plan.period}',
                            style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    // Features
                    ...plan.features.map((f) => Padding(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: Row(
                        children: [
                          Container(
                            width: 18, height: 18,
                            decoration: BoxDecoration(
                              color: AppColors.green.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text('✓', style: TextStyle(color: AppColors.green, fontSize: 11, fontWeight: FontWeight.w700)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(f, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                        ],
                      ),
                    )),
                    // Locked features
                    ...plan.lockedFeatures.map((f) => Padding(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: Row(
                        children: [
                          Container(
                            width: 18, height: 18,
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), shape: BoxShape.circle),
                            child: const Center(child: Text('✗', style: TextStyle(color: AppColors.textHint, fontSize: 11))),
                          ),
                          const SizedBox(width: 10),
                          Text(f, style: const TextStyle(fontSize: 12, color: AppColors.textHint)),
                        ],
                      ),
                    )),
                    const SizedBox(height: 16),
                    // Button
                    Obx(() => SizedBox(
                      width: double.infinity,
                      child: isBasic
                          ? OutlineGlassButton(label: plan.buttonLabel, width: double.infinity)
                          : plan.isPopular
                              ? GradientButton(
                                  label: controller.isProcessing.value && controller.selectedPlan.value == plan.id
                                      ? 'Processing...' : plan.buttonLabel,
                                  gradient: AppGradients.purple,
                                  shadowColor: AppColors.purple,
                                  width: double.infinity,
                                  onTap: () => controller.subscribe(plan),
                                )
                              : GradientButton(
                                  label: controller.isProcessing.value && controller.selectedPlan.value == plan.id
                                      ? 'Processing...' : plan.buttonLabel,
                                  gradient: const LinearGradient(colors: [Color(0xFFD97706), AppColors.amber]),
                                  shadowColor: AppColors.amber,
                                  width: double.infinity,
                                  onTap: () => controller.subscribe(plan),
                                ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _PerksStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingMd),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0x26E94560), Color(0x1A7B2FF7)],
        ),
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: AppColors.coral.withOpacity(0.3), width: 0.5),
      ),
      child: Row(
        children: [
          const Text('🎁', style: TextStyle(fontSize: 26)),
          const SizedBox(width: 14),
          Expanded(
            child: RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 12, color: AppColors.textMuted, height: 1.6),
                children: [
                  TextSpan(text: '7-day free trial ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  TextSpan(text: 'on Pro & Elite. No credit card required to start. Cancel anytime.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../controllers/controllers.dart';
import '../models/models.dart';
import '../utils/app_theme.dart';
import '../widgets/shared_widgets.dart';

class MembershipScreen extends StatelessWidget {
  const MembershipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<MembershipController>();

    return GradientScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              /// HEADER
              FadeInDown(
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimens.paddingLg,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Membership',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Unlock your full potential',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// PLANS
              ...c.plans.asMap().entries.map(
                (e) => FadeInUp(
                  delay: Duration(milliseconds: e.key * 120),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimens.paddingLg,
                      0,
                      AppDimens.paddingLg,
                      14,
                    ),
                    child: _PlanCard(plan: e.value, controller: c),
                  ),
                ),
              ),

              /// PERKS
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.paddingLg,
                  ),
                  child: _PerksStrip(),
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

class _PlanCard extends StatelessWidget {
  final PlanModel plan;
  final MembershipController controller;

  const _PlanCard({required this.plan, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isBasic = plan.id == 'basic';
    final isElite = plan.id == 'elite';

    return GestureDetector(
      onTap: () => controller.selectPlan(plan.id),

      /// ✅ Only needed part reactive
      child: Obx(() {
        final isSelected = controller.selectedPlan.value == plan.id;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            gradient:
                plan.gradient ??
                const LinearGradient(
                  colors: [AppColors.glass, AppColors.glass],
                ),
            borderRadius: BorderRadius.circular(AppDimens.radiusLg),
            border: Border.all(
              color:
                  plan.borderColor?.withOpacity(isSelected ? 0.8 : 0.4) ??
                  AppColors.glassBorder,
              width: plan.isPopular ? 1.5 : 0.5,
            ),
            boxShadow:
                plan.isPopular
                    ? [
                      BoxShadow(
                        color: AppColors.purple.withOpacity(0.25),
                        blurRadius: 32,
                        offset: const Offset(0, 8),
                      ),
                    ]
                    : isElite
                    ? [
                      BoxShadow(
                        color: AppColors.amber.withOpacity(0.2),
                        blurRadius: 24,
                        offset: const Offset(0, 6),
                      ),
                    ]
                    : null,
          ),
          child: Stack(
            children: [
              if (!isBasic)
                GlowCircle(
                  color: plan.id == 'pro' ? AppColors.purple : AppColors.amber,
                  size: 120,
                  alignment: Alignment.topRight,
                ),

              Padding(
                padding: const EdgeInsets.all(AppDimens.paddingLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TOP ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(plan.emoji, style: const TextStyle(fontSize: 30)),

                        if (plan.isPopular)
                          _badge('MOST POPULAR', AppGradients.purple),

                        if (isElite)
                          _badge(
                            'PREMIUM',
                            const LinearGradient(
                              colors: [Color(0xFFD97706), AppColors.amber],
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Text(
                      plan.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 6),

                    /// PRICE
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          plan.price,
                          style: TextStyle(
                            fontSize: isBasic ? 24 : 30,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            '/ ${plan.period}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    /// FEATURES
                    ...plan.features.map((f) => _feature(f, true)),
                    ...plan.lockedFeatures.map((f) => _feature(f, false)),

                    const SizedBox(height: 16),

                    /// BUTTON (reactive)
                    _buildButton(isBasic, isSelected),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildButton(bool isBasic, bool isSelected) {
    return Obx(() {
      final isProcessing = controller.isProcessing.value;

      return SizedBox(
        width: double.infinity,
        child:
            isBasic
                ? OutlineGlassButton(label: plan.buttonLabel)
                : GradientButton(
                  label:
                      isProcessing && isSelected
                          ? 'Processing...'
                          : plan.buttonLabel,
                  gradient:
                      plan.isPopular
                          ? AppGradients.purple
                          : const LinearGradient(
                            colors: [Color(0xFFD97706), AppColors.amber],
                          ),
                  onTap: () => controller.subscribe(plan),
                ),
      );
    });
  }

  Widget _feature(String text, bool active) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color:
                  active
                      ? AppColors.green.withOpacity(0.15)
                      : Colors.white.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                active ? '✓' : '✗',
                style: TextStyle(
                  color: active ? AppColors.green : AppColors.textHint,
                  fontSize: 11,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: active ? AppColors.textMuted : AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }

  Widget _badge(String text, Gradient gradient) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(AppDimens.radiusFull),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _PerksStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingMd),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0x26E94560), Color(0x1A7B2FF7)],
        ),
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
      ),
      child: Row(
        children: [
          const Text('🎁', style: TextStyle(fontSize: 26)),
          const SizedBox(width: 14),
          Expanded(
            child: RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textMuted,
                  height: 1.6,
                ),
                children: [
                  TextSpan(
                    text: '7-day free trial ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(text: 'on Pro & Elite. Cancel anytime.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
