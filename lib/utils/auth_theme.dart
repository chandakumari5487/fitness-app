import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── Colors ──────────────────────────────────────────────
class AC {
  static const Color bg1 = Color(0xFF0F0C29);
  static const Color bg2 = Color(0xFF302B63);
  static const Color bg3 = Color(0xFF24243E);
  static const Color purple = Color(0xFF7B2FF7);
  static const Color purpleL = Color(0xFFA855F7);
  static const Color cyan = Color(0xFF00D4FF);
  static const Color coral = Color(0xFFE94560);
  static const Color amber = Color(0xFFF59E0B);
  static const Color green = Color(0xFF4ADE80);
  static const Color glass = Color(0x12FFFFFF);
  static const Color glassBorder = Color(0x25FFFFFF);
  static const Color text = Color(0xFFFFFFFF);
  static const Color textMuted = Color(0x8CFFFFFF);
  static const Color textHint = Color(0x4DFFFFFF);
}

// ─── Gradients ────────────────────────────────────────────
class AG {
  static const LinearGradient bg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AC.bg1, AC.bg2, AC.bg3],
  );
  static const LinearGradient purple = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AC.purple, AC.purpleL],
  );
  static const LinearGradient brand = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AC.purple, AC.purpleL, AC.cyan],
  );
}

// ─── Auth Theme ───────────────────────────────────────────
class AuthTheme {
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AC.bg1,
    textTheme: GoogleFonts.poppinsTextTheme(
      const TextTheme(
        displayLarge: TextStyle(color: AC.text, fontWeight: FontWeight.w800),
        headlineLarge: TextStyle(color: AC.text, fontWeight: FontWeight.w700),
        titleLarge: TextStyle(color: AC.text, fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(color: AC.textMuted),
      ),
    ),
  );
}

// ─── Gradient Background ──────────────────────────────────
class AuthScaffold extends StatelessWidget {
  final Widget child;
  final bool resizeToAvoidBottomInset;
  const AuthScaffold({super.key, required this.child, this.resizeToAvoidBottomInset = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(gradient: AG.bg),
        child: Stack(children: [_GlowOrbs(), child]),
      ),
    );
  }
}

class _GlowOrbs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(top: -80, right: -60, child: _orb(280, AC.purple, 0.35)),
        Positioned(bottom: 100, left: -60, child: _orb(200, AC.cyan, 0.20)),
        Positioned(top: 200, right: -40, child: _orb(150, AC.coral, 0.18)),
      ],
    );
  }

  Widget _orb(double size, Color color, double opacity) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withOpacity(opacity), Colors.transparent],
        ),
      ),
    );
  }
}

// ─── Glass Input Field ────────────────────────────────────
class GlassInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? prefixEmoji;
  final bool obscure;
  final Widget? suffix;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final VoidCallback? onEditingComplete;

  const GlassInput({
    super.key,
    required this.controller,
    required this.hint,
    this.prefixEmoji,
    this.obscure = false,
    this.suffix,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AC.glass,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AC.glassBorder, width: 0.5),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onEditingComplete: onEditingComplete,
        style: const TextStyle(color: AC.text, fontSize: 13, fontFamily: 'Poppins'),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: AC.textHint, fontSize: 13),
          prefixIcon: prefixEmoji != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 14, right: 8),
                  child: Text(prefixEmoji!, style: const TextStyle(fontSize: 16, color: AC.textMuted)),
                )
              : null,
          prefixIconConstraints: const BoxConstraints(minWidth: 44),
          suffixIcon: suffix,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: prefixEmoji == null ? 16 : 0, vertical: 14),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}

// ─── Gradient Button ──────────────────────────────────────
class AuthGradientButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isLoading;
  final Gradient gradient;
  final Color? borderColor;
  final Color textColor;
  final Widget? icon;

  const AuthGradientButton({
    super.key,
    required this.label,
    this.onTap,
    this.isLoading = false,
    this.gradient = AG.purple,
    this.borderColor,
    this.textColor = Colors.white,
    this.icon,
  });

  @override
  State<AuthGradientButton> createState() => _AuthGradientButtonState();
}

class _AuthGradientButtonState extends State<AuthGradientButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) { setState(() => _pressed = false); widget.onTap?.call(); },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            gradient: widget.gradient,
            borderRadius: BorderRadius.circular(50),
            border: widget.borderColor != null
                ? Border.all(color: widget.borderColor!, width: 1)
                : null,
            boxShadow: [
              BoxShadow(
                color: AC.purple.withOpacity(0.45),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: widget.isLoading
              ? const Center(child: SizedBox(width: 22, height: 22,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5)))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.icon != null) ...[widget.icon!, const SizedBox(width: 10)],
                    Text(widget.label,
                        style: TextStyle(color: widget.textColor, fontSize: 14,
                            fontWeight: FontWeight.w700, letterSpacing: 0.3,
                            fontFamily: 'Poppins')),
                  ],
                ),
        ),
      ),
    );
  }
}

// ─── Social Button (Glass) ────────────────────────────────
class SocialButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final VoidCallback? onTap;
  final Color? bgColor;
  final Color? textColor;

  const SocialButton({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
    this.bgColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: bgColor ?? AC.glass,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: AC.glassBorder, width: 0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 10),
            Text(label,
                style: TextStyle(
                  color: textColor ?? AC.text,
                  fontSize: 13, fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                )),
          ],
        ),
      ),
    );
  }
}

// ─── OR Divider ───────────────────────────────────────────
class OrDivider extends StatelessWidget {
  final String text;
  const OrDivider({super.key, this.text = 'or continue with'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(child: Container(height: 0.5, color: Colors.white12)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(text, style: const TextStyle(fontSize: 11, color: AC.textHint,
                fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
          ),
          Expanded(child: Container(height: 0.5, color: Colors.white12)),
        ],
      ),
    );
  }
}

// ─── Step Indicator ───────────────────────────────────────
class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepIndicator({super.key, required this.currentStep, required this.totalSteps});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalSteps * 2 - 1, (i) {
        if (i.isOdd) {
          final stepIndex = i ~/ 2;
          return Container(
            width: 20, height: 1.5,
            color: stepIndex < currentStep
                ? AC.purple : Colors.white.withOpacity(0.12),
          );
        }
        final step = i ~/ 2 + 1;
        final isDone = step < currentStep;
        final isActive = step == currentStep;
        return Container(
          width: 26, height: 26,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: isDone || isActive ? AG.purple : null,
            border: !isDone && !isActive
                ? Border.all(color: Colors.white.withOpacity(0.15)) : null,
          ),
          child: Center(
            child: isDone
                ? const Icon(Icons.check, size: 13, color: Colors.white)
                : Text('$step',
                    style: TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                      color: isActive ? AC.purpleL : AC.textHint,
                    )),
          ),
        );
      }),
    );
  }
}

// ─── Password Strength Bar ────────────────────────────────
class PasswordStrengthBar extends StatelessWidget {
  final double value;
  final String label;
  final Color color;

  const PasswordStrengthBar({
    super.key,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Password strength', style: TextStyle(fontSize: 10, color: AC.textHint, fontFamily: 'Poppins')),
            if (label.isNotEmpty)
              Text(label, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w600, fontFamily: 'Poppins')),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: List.generate(4, (i) {
            final filled = i < (value * 4).ceil();
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: i < 3 ? 4 : 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 4,
                    color: filled ? color : Colors.white.withOpacity(0.08),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

// ─── Google SVG Icon ─────────────────────────────────────
class GoogleIcon extends StatelessWidget {
  final double size;
  const GoogleIcon({super.key, this.size = 18});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size, height: size,
      child: CustomPaint(painter: _GooglePainter()),
    );
  }
}

class _GooglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Simplified Google G using rect segments
    final blue = Paint()..color = const Color(0xFF4285F4);
    final green = Paint()..color = const Color(0xFF34A853);
    final yellow = Paint()..color = const Color(0xFFFBBC05);
    final red = Paint()..color = const Color(0xFFEA4335);
    final c = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2;

    canvas.drawArc(Rect.fromCircle(center: c, radius: r), -0.5, 1.0, false, blue..style = PaintingStyle.stroke..strokeWidth = size.width * 0.28);
    canvas.drawArc(Rect.fromCircle(center: c, radius: r), 0.5, 1.05, false, green..style = PaintingStyle.stroke..strokeWidth = size.width * 0.28);
    canvas.drawArc(Rect.fromCircle(center: c, radius: r), 1.55, 1.05, false, yellow..style = PaintingStyle.stroke..strokeWidth = size.width * 0.28);
    canvas.drawArc(Rect.fromCircle(center: c, radius: r), 2.6, 0.8, false, red..style = PaintingStyle.stroke..strokeWidth = size.width * 0.28);
    canvas.drawRect(Rect.fromLTWH(c.dx, c.dy - size.height * 0.14, r * 0.85, size.height * 0.28), blue);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── Apple Icon ───────────────────────────────────────────
class AppleIcon extends StatelessWidget {
  final double size;
  final Color color;
  const AppleIcon({super.key, this.size = 18, this.color = const Color(0xFF111111)});

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.apple, size: size + 2, color: color);
  }
}
