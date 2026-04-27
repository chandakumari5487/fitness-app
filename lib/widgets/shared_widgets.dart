import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

// ─── Glass Card ───────────────────────────────────────────
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Color? borderColor;
  final Gradient? gradient;
  final VoidCallback? onTap;
  final double elevation;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = AppDimens.radiusLg,
    this.borderColor,
    this.gradient,
    this.onTap,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          gradient: gradient ?? const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.glass, Color(0x08FFFFFF)],
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: borderColor ?? AppColors.glassBorder,
            width: 0.5,
          ),
          boxShadow: elevation > 0
              ? [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: elevation * 4, offset: Offset(0, elevation))]
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Stack(
            children: [
              // Shine overlay
              Positioned(
                top: 0, left: 0, right: 0,
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white.withOpacity(0.06), Colors.transparent],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: padding ?? const EdgeInsets.all(AppDimens.paddingMd),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Gradient Button ──────────────────────────────────────
class GradientButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final Gradient gradient;
  final double? width;
  final double height;
  final double borderRadius;
  final Widget? prefix;
  final Color shadowColor;

  const GradientButton({
    super.key,
    required this.label,
    this.onTap,
    this.gradient = AppGradients.purple,
    this.width,
    this.height = 52,
    this.borderRadius = AppDimens.radiusFull,
    this.prefix,
    this.shadowColor = AppColors.purple,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
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
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            gradient: widget.gradient,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: [
              BoxShadow(
                color: widget.shadowColor.withOpacity(0.45),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.prefix != null) ...[widget.prefix!, const SizedBox(width: 8)],
              Text(
                widget.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Outline Button ───────────────────────────────────────
class OutlineGlassButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final double? width;

  const OutlineGlassButton({
    super.key,
    required this.label,
    this.onTap,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.glassBorder),
          borderRadius: BorderRadius.circular(AppDimens.radiusFull),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

// ─── Neon Glow Text ───────────────────────────────────────
class NeonText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;

  const NeonText({
    super.key,
    required this.text,
    this.fontSize = 20,
    this.color = AppColors.cyan,
    this.fontWeight = FontWeight.w700,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        shadows: [
          Shadow(color: color.withOpacity(0.8), blurRadius: 12),
          Shadow(color: color.withOpacity(0.4), blurRadius: 24),
        ],
      ),
    );
  }
}

// ─── Badge Chip ───────────────────────────────────────────
class BadgeChip extends StatelessWidget {
  final String label;
  final Color color;

  const BadgeChip({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppDimens.radiusFull),
        border: Border.all(color: color.withOpacity(0.5), width: 0.5),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

// ─── Section Header ───────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        if (actionLabel != null)
          GestureDetector(
            onTap: onAction,
            child: Text(actionLabel!, style: const TextStyle(fontSize: 11, color: AppColors.purpleLight)),
          ),
      ],
    );
  }
}

// ─── Gradient Background ─────────────────────────────────
class GradientScaffold extends StatelessWidget {
  final Widget child;
  final bool showAppBar;
  final String? title;
  final List<Widget>? actions;

  const GradientScaffold({
    super.key,
    required this.child,
    this.showAppBar = false,
    this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: showAppBar
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(title ?? '', style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700)),
              actions: actions,
            )
          : null,
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.background),
        child: child,
      ),
    );
  }
}

// ─── Glowing Radial Background ───────────────────────────
class GlowCircle extends StatelessWidget {
  final Color color;
  final double size;
  final Alignment alignment;

  const GlowCircle({
    super.key,
    required this.color,
    this.size = 200,
    this.alignment = Alignment.topRight,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color.withOpacity(0.3), Colors.transparent],
          ),
        ),
      ),
    );
  }
}
