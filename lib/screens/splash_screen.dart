import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../utils/auth_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseCtrl;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulse = Tween<double>(
      begin: 1.0,
      end: 1.08,
    ).animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

                  // Animated logo
                  FadeInDown(
                    duration: const Duration(milliseconds: 800),
                    child: AnimatedBuilder(
                      animation: _pulse,
                      builder:
                          (_, child) => Transform.scale(
                            scale: _pulse.value,
                            child: child,
                          ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              gradient: AG.brand,
                              boxShadow: [
                                BoxShadow(
                                  color: AC.purple.withOpacity(0.55),
                                  blurRadius: 40,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text('💪', style: TextStyle(fontSize: 52)),
                            ),
                          ),
                          Positioned(
                            top: -8,
                            right: -8,
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [AC.coral, Color(0xFFFF6B8A)],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AC.coral.withOpacity(0.5),
                                    blurRadius: 12,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  '⚡',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Brand name
                  FadeInUp(
                    delay: const Duration(milliseconds: 300),
                    child: ShaderMask(
                      shaderCallback: (b) => AG.brand.createShader(b),
                      child: const Text(
                        'FITO',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1.5,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: const Text(
                      'FITNESS',
                      style: TextStyle(
                        fontSize: 13,
                        letterSpacing: 4,
                        fontWeight: FontWeight.w700,
                        color: AC.textMuted,
                      ),
                    ),
                  ),
                  FadeInUp(
                    delay: const Duration(milliseconds: 500),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 48),
                      child: Text(
                        'Train smarter. Live stronger.',
                        style: TextStyle(fontSize: 13, color: AC.textHint),
                      ),
                    ),
                  ),

                  // Buttons
                  FadeInUp(
                    delay: const Duration(milliseconds: 600),
                    child: AuthGradientButton(
                      label: 'Get Started',
                      onTap: () => Get.toNamed('/auth'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  FadeInUp(
                    delay: const Duration(milliseconds: 700),
                    child: GestureDetector(
                      onTap: () => Get.toNamed('/auth', arguments: {'tab': 0}),
                      child: Container(
                        width: double.infinity,
                        height: 52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'I already have an account',
                          style: TextStyle(
                            color: AC.textMuted,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Social proof
                  FadeInUp(
                    delay: const Duration(milliseconds: 800),
                    child: _SocialProof(),
                  ),

                  const SizedBox(height: 28),

                  // Stats row
                  FadeInUp(
                    delay: const Duration(milliseconds: 900),
                    child: _StatsRow(),
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
}

class _SocialProof extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 0.5),
      ),
      child: Row(
        children: [
          // Avatar stack
          SizedBox(
            width: 76,
            height: 26,
            child: Stack(
              children: [
                _miniAvatar(
                  0,
                  'AJ',
                  const LinearGradient(colors: [AC.purple, AC.purpleL]),
                ),
                _miniAvatar(
                  22,
                  'MR',
                  const LinearGradient(colors: [AC.coral, Color(0xFFFF6B8A)]),
                ),
                _miniAvatar(
                  44,
                  'SK',
                  const LinearGradient(colors: [AC.cyan, Color(0xFF0099FF)]),
                ),
                Positioned(
                  left: 60,
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1),
                      border: Border.all(color: AC.bg1, width: 1.5),
                    ),
                    child: const Center(
                      child: Text(
                        '+2k',
                        style: TextStyle(
                          fontSize: 7,
                          fontWeight: FontWeight.w700,
                          color: AC.textMuted,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '2,400+ athletes',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AC.text,
                  ),
                ),
                Text(
                  'already crushing goals',
                  style: TextStyle(fontSize: 10, color: AC.textMuted),
                ),
              ],
            ),
          ),
          const Text('★★★★★', style: TextStyle(fontSize: 11, color: AC.amber)),
        ],
      ),
    );
  }

  Widget _miniAvatar(double left, String initials, Gradient gradient) {
    return Positioned(
      left: left,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: gradient,
          border: Border.all(color: AC.bg1, width: 1.5),
        ),
        child: Center(
          child: Text(
            initials,
            style: const TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _stat('500+', 'Workouts', AC.purpleL),
        Container(
          width: 0.5,
          height: 32,
          color: Colors.white.withOpacity(0.1),
          margin: const EdgeInsets.symmetric(horizontal: 28),
        ),
        _stat('AI', 'Coach', AC.cyan),
        Container(
          width: 0.5,
          height: 32,
          color: Colors.white.withOpacity(0.1),
          margin: const EdgeInsets.symmetric(horizontal: 28),
        ),
        _stat('Free', 'Trial', AC.green),
      ],
    );
  }

  Widget _stat(String val, String label, Color color) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback:
              (_) => LinearGradient(
                colors: [color, color],
              ).createShader(Rect.zero),
          child: Text(
            val,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 10, color: AC.textHint)),
      ],
    );
  }
}
