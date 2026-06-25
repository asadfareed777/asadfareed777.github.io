import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import '../utils/constants.dart';

// ── NAV BAR ─────────────────────────────────────────────────────────────────
class PortfolioNavBar extends StatelessWidget {
  final VoidCallback onAbout;
  final VoidCallback onExperience;
  final VoidCallback onProjects;
  final VoidCallback onSkills;
  final VoidCallback onContact;

  const PortfolioNavBar({
    super.key,
    required this.onAbout,
    required this.onExperience,
    required this.onProjects,
    required this.onSkills,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      color: AppColors.bg.withOpacity(0.95),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          child: Row(
            children: [
              Text(
                'AF',
                style: GoogleFonts.inter(
                  color: AppColors.primary,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                ),
              ),
              const Spacer(),
              if (!isMobile) ...[
                _NavLink('About', onAbout),
                _NavLink('Experience', onExperience),
                _NavLink('Projects', onProjects),
                _NavLink('Skills', onSkills),
                const SizedBox(width: 8),
                _ContactButton(onContact),
              ] else
                IconButton(
                  icon: const Icon(Icons.menu, color: AppColors.textPrimary),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: AppColors.bgCard,
                      builder: (_) => _MobileMenu(
                        onAbout: onAbout,
                        onExperience: onExperience,
                        onProjects: onProjects,
                        onSkills: onSkills,
                        onContact: onContact,
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _NavLink(this.label, this.onTap);

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: GoogleFonts.inter(
              color: _hover ? AppColors.primary : AppColors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}

class _ContactButton extends StatefulWidget {
  final VoidCallback onTap;
  const _ContactButton(this.onTap);

  @override
  State<_ContactButton> createState() => _ContactButtonState();
}

class _ContactButtonState extends State<_ContactButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: _hover ? AppColors.primary : Colors.transparent,
            border: Border.all(color: AppColors.primary),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'Contact',
            style: GoogleFonts.inter(
              color: _hover ? Colors.white : AppColors.primary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileMenu extends StatelessWidget {
  final VoidCallback onAbout, onExperience, onProjects, onSkills, onContact;
  const _MobileMenu(
      {required this.onAbout,
      required this.onExperience,
      required this.onProjects,
      required this.onSkills,
      required this.onContact});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('About', onAbout),
      ('Experience', onExperience),
      ('Projects', onProjects),
      ('Skills', onSkills),
      ('Contact', onContact),
    ];
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items
            .map((e) => ListTile(
                  title: Text(e.$1,
                      style: GoogleFonts.inter(
                          color: AppColors.textPrimary, fontSize: 16)),
                  onTap: () {
                    Navigator.pop(context);
                    e.$2();
                  },
                ))
            .toList(),
      ),
    );
  }
}

// ── SECTION HEADER ───────────────────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const SectionHeader({super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInUp(
          child: Row(
            children: [
              Container(
                width: 4,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 14),
              Text(
                title,
                style: GoogleFonts.inter(
                  color: AppColors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 10),
          FadeInUp(
            delay: const Duration(milliseconds: 100),
            child: Text(
              subtitle!,
              style: GoogleFonts.inter(
                color: AppColors.textSecondary,
                fontSize: 16,
              ),
            ),
          ),
        ],
        const SizedBox(height: 40),
      ],
    );
  }
}

// ── HOVER CARD ───────────────────────────────────────────────────────────────
class HoverCard extends StatefulWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double borderRadius;

  const HoverCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 12,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: widget.padding ?? const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _hover ? AppColors.bgCardHover : AppColors.bgCard,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: _hover ? AppColors.primary.withOpacity(0.5) : AppColors.divider,
            width: 1,
          ),
          boxShadow: _hover
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.08),
                    blurRadius: 24,
                    spreadRadius: 2,
                  )
                ]
              : [],
        ),
        child: widget.child,
      ),
    );
  }
}

// ── SKILL TAG ────────────────────────────────────────────────────────────────
class SkillTag extends StatelessWidget {
  final String label;
  const SkillTag(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.tagBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: AppColors.primaryLight,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// ── GRADIENT BUTTON ───────────────────────────────────────────────────────────
class GradientButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final bool outline;

  const GradientButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.outline = false,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            gradient: widget.outline
                ? null
                : LinearGradient(
                    colors: _hover
                        ? [AppColors.primaryLight, AppColors.primary]
                        : [AppColors.primary, AppColors.primaryDark],
                  ),
            color: widget.outline ? Colors.transparent : null,
            border: widget.outline
                ? Border.all(color: AppColors.primary, width: 1.5)
                : null,
            borderRadius: BorderRadius.circular(8),
            boxShadow: !widget.outline && _hover
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, color: Colors.white, size: 16),
                const SizedBox(width: 8),
              ],
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
