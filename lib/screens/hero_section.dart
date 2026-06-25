import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/constants.dart';
import '../widgets/common.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onContact;
  final VoidCallback onProjects;

  const HeroSection(
      {super.key, required this.onContact, required this.onProjects});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 768;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 600),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(-0.6, -0.4),
          radius: 1.2,
          colors: [
            AppColors.primary.withOpacity(0.15),
            AppColors.bg,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Grid lines decoration
          Positioned.fill(child: _GridDecoration()),
          // Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : 80,
              vertical: 80,
            ),
            child: isMobile
                ? _MobileHero(onContact: onContact, onProjects: onProjects)
                : _DesktopHero(onContact: onContact, onProjects: onProjects),
          ),
        ],
      ),
    );
  }
}

class _GridDecoration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _GridPainter());
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(0.04)
      ..strokeWidth = 1;

    const step = 60.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class _DesktopHero extends StatelessWidget {
  final VoidCallback onContact, onProjects;
  const _DesktopHero({required this.onContact, required this.onProjects});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 3, child: _HeroText(onContact: onContact, onProjects: onProjects)),
        const SizedBox(width: 60),
        Expanded(flex: 2, child: _HeroVisual()),
      ],
    );
  }
}

class _MobileHero extends StatelessWidget {
  final VoidCallback onContact, onProjects;
  const _MobileHero({required this.onContact, required this.onProjects});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HeroText(onContact: onContact, onProjects: onProjects),
        const SizedBox(height: 48),
        Center(child: _HeroVisual()),
      ],
    );
  }
}

class _HeroText extends StatelessWidget {
  final VoidCallback onContact, onProjects;
  const _HeroText({required this.onContact, required this.onProjects});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeInDown(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8, height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Available for opportunities',
                  style: GoogleFonts.inter(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        FadeInDown(
          delay: const Duration(milliseconds: 100),
          child: Text(
            'Hi, I\'m',
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: 20,
            ),
          ),
        ),
        FadeInDown(
          delay: const Duration(milliseconds: 150),
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.white, AppColors.primaryLight],
            ).createShader(bounds),
            child: Text(
              AppStrings.name,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 56,
                fontWeight: FontWeight.w800,
                height: 1.1,
                letterSpacing: -1,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        FadeInDown(
          delay: const Duration(milliseconds: 200),
          child: Text(
            AppStrings.title,
            style: GoogleFonts.inter(
              color: AppColors.primary,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 16),
        FadeInDown(
          delay: const Duration(milliseconds: 250),
          child: Text(
            AppStrings.subtitle,
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: 15,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 36),
        FadeInUp(
          delay: const Duration(milliseconds: 300),
          child: Row(
            children: [
              GradientButton(
                label: 'View Projects',
                onTap: onProjects,
                icon: Icons.work_outline,
              ),
              const SizedBox(width: 16),
              GradientButton(
                label: 'Contact Me',
                onTap: onContact,
                outline: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        FadeInUp(
          delay: const Duration(milliseconds: 380),
          child: Row(
            children: [
              _SocialIcon(
                icon: FontAwesomeIcons.github,
                url: AppStrings.github,
              ),
              const SizedBox(width: 16),
              _SocialIcon(
                icon: FontAwesomeIcons.linkedin,
                url: AppStrings.linkedin,
              ),
              const SizedBox(width: 16),
              _SocialIcon(
                icon: FontAwesomeIcons.googlePlay,
                url: AppStrings.playstore,
              ),
              const SizedBox(width: 16),
              _SocialIcon(
                icon: Icons.email_outlined,
                url: 'mailto:${AppStrings.email}',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final dynamic icon;
  final String url;
  const _SocialIcon({required this.icon, required this.url});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 40, height: 40,
          decoration: BoxDecoration(
            color: _hover ? AppColors.primary.withOpacity(0.2) : Colors.transparent,
            border: Border.all(
              color: _hover ? AppColors.primary : AppColors.divider,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: widget.icon is IconData
                ? Icon(widget.icon as IconData,
                    color: _hover ? AppColors.primary : AppColors.textSecondary,
                    size: 18)
                : FaIcon(widget.icon as IconDataSolid,
                    color: _hover ? AppColors.primary : AppColors.textSecondary,
                    size: 16),
          ),
        ),
      ),
    );
  }
}

class _HeroVisual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 380, maxHeight: 380),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer glow ring
            Container(
              width: 340,
              height: 340,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.15),
                  width: 1,
                ),
              ),
            ),
            Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.25),
                  width: 1,
                ),
              ),
            ),
            // Center avatar placeholder
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary.withOpacity(0.3),
                    AppColors.primaryDark.withOpacity(0.6),
                  ],
                ),
                border: Border.all(color: AppColors.primary, width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('AF',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 52,
                        fontWeight: FontWeight.w800,
                      )),
                  Text('Dev',
                      style: GoogleFonts.inter(
                        color: AppColors.primaryLight,
                        fontSize: 14,
                        letterSpacing: 4,
                      )),
                ],
              ),
            ),
            // Floating tech badges
            ..._floatingBadges(),
          ],
        ),
      ),
    );
  }

  List<Widget> _floatingBadges() {
    final badges = [
      ('Kotlin', const Offset(145, 30)),
      ('Flutter', const Offset(-30, 80)),
      ('ML / AI', const Offset(155, 240)),
      ('NFC', const Offset(-20, 210)),
      ('AFC', const Offset(60, 10)),
    ];
    return badges
        .map((b) => Positioned(
              left: 170 + b.$2.dx,
              top: 70 + b.$2.dy,
              child: _TechBadge(b.$1),
            ))
        .toList();
  }
}

class _TechBadge extends StatelessWidget {
  final String label;
  const _TechBadge(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.primary.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
              color: AppColors.primary.withOpacity(0.15),
              blurRadius: 8),
        ],
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: AppColors.primaryLight,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
