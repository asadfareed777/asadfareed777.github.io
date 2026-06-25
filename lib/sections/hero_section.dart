import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/app_colors.dart';
import '../utils/constants.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onContactTap;
  const HeroSection({super.key, required this.onContactTap});
  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this, duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() { _pulse.dispose(); super.dispose(); }

  void _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: size.height * 0.92),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.background, Color(0xFF0D2040), AppColors.background],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Background grid dots
          Positioned.fill(child: CustomPaint(painter: _GridPainter())),
          // Glow blob
          Positioned(
            right: isMobile ? -100 : 50,
            top: 50,
            child: AnimatedBuilder(
              animation: _pulse,
              builder: (_, __) => Container(
                width: 500, height: 500,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    AppColors.accent.withOpacity(0.08 + _pulse.value * 0.04),
                    Colors.transparent,
                  ]),
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : size.width > 1200 ? 160 : 80,
              vertical: 80,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                FadeInDown(
                  duration: const Duration(milliseconds: 600),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.accent.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.accentGlow,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(width: 8, height: 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.success,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('Available for opportunities',
                          style: GoogleFonts.inter(
                            fontSize: 13, color: AppColors.accentLight,
                            fontWeight: FontWeight.w500,
                          )),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FadeInDown(delay: const Duration(milliseconds: 200),
                  child: Text("Hi, I'm",
                    style: GoogleFonts.inter(
                      fontSize: isMobile ? 18 : 22, color: AppColors.textSecondary,
                      fontWeight: FontWeight.w400,
                    )),
                ),
                FadeInDown(delay: const Duration(milliseconds: 300),
                  child: Text(AppConstants.name,
                    style: GoogleFonts.inter(
                      fontSize: isMobile ? 48 : 72, color: AppColors.white,
                      fontWeight: FontWeight.w900, height: 1.05, letterSpacing: -2,
                    )),
                ),
                FadeInDown(delay: const Duration(milliseconds: 400),
                  child: ShaderMask(
                    shaderCallback: (b) => const LinearGradient(
                      colors: [AppColors.accentLight, AppColors.accent],
                    ).createShader(b),
                    child: Text(AppConstants.title,
                      style: GoogleFonts.inter(
                        fontSize: isMobile ? 20 : 28, color: AppColors.white,
                        fontWeight: FontWeight.w700,
                      )),
                  ),
                ),
                const SizedBox(height: 16),
                FadeInDown(delay: const Duration(milliseconds: 500),
                  child: Text(AppConstants.subtitle,
                    style: GoogleFonts.inter(
                      fontSize: isMobile ? 13 : 15, color: AppColors.textSecondary,
                      fontWeight: FontWeight.w400, height: 1.6,
                    )),
                ),
                const SizedBox(height: 16),
                FadeInDown(delay: const Duration(milliseconds: 550),
                  child: Row(children: [
                    const Icon(Icons.location_on_outlined,
                      size: 16, color: AppColors.accent),
                    const SizedBox(width: 6),
                    Text(AppConstants.location,
                      style: GoogleFonts.inter(
                        fontSize: 13, color: AppColors.textSecondary)),
                  ]),
                ),
                const SizedBox(height: 40),
                FadeInUp(delay: const Duration(milliseconds: 600),
                  child: Wrap(spacing: 12, runSpacing: 12, children: [
                    _PrimaryButton(
                      label: 'View Projects',
                      icon: Icons.rocket_launch_outlined,
                      onTap: widget.onContactTap,
                    ),
                    _SecondaryButton(
                      label: 'Download CV',
                      icon: Icons.download_outlined,
                      onTap: () => _launch(AppConstants.github),
                    ),
                  ]),
                ),
                const SizedBox(height: 48),
                FadeInUp(delay: const Duration(milliseconds: 700),
                  child: Wrap(spacing: 16, children: [
                    _SocialIcon(icon: Icons.code, label: 'GitHub',
                      url: AppConstants.github),
                    _SocialIcon(icon: Icons.work_outline, label: 'LinkedIn',
                      url: AppConstants.linkedin),
                    _SocialIcon(icon: Icons.email_outlined, label: 'Email',
                      url: 'mailto:${AppConstants.email}'),
                  ]),
                ),
                const SizedBox(height: 60),
                // Stats row
                FadeInUp(delay: const Duration(milliseconds: 800),
                  child: Wrap(spacing: 32, runSpacing: 20, children: const [
                    _StatItem(number: '6+', label: 'Years Experience'),
                    _StatItem(number: '15+', label: 'Apps Delivered'),
                    _StatItem(number: '5', label: 'Play Store Apps'),
                    _StatItem(number: '3', label: 'ML Integrations'),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.border.withOpacity(0.3)
      ..strokeWidth = 0.5;
    const spacing = 40.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.2, paint);
      }
    }
  }
  @override bool shouldRepaint(_) => false;
}

class _StatItem extends StatelessWidget {
  final String number, label;
  const _StatItem({required this.number, required this.label});
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(number, style: GoogleFonts.inter(
        fontSize: 32, fontWeight: FontWeight.w800, color: AppColors.accent)),
      Text(label, style: GoogleFonts.inter(
        fontSize: 13, color: AppColors.textSecondary)),
    ],
  );
}

class _PrimaryButton extends StatefulWidget {
  final String label; final IconData icon; final VoidCallback onTap;
  const _PrimaryButton({required this.label, required this.icon, required this.onTap});
  @override State<_PrimaryButton> createState() => _PrimaryButtonState();
}
class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _hov = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _hov = true),
    onExit:  (_) => setState(() => _hov = false),
    child: GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: _hov
            ? [AppColors.accentLight, AppColors.accent]
            : [AppColors.accent, const Color(0xFF1A5A9A)]),
          borderRadius: BorderRadius.circular(10),
          boxShadow: _hov ? [BoxShadow(
            color: AppColors.accent.withOpacity(0.4), blurRadius: 20, offset: const Offset(0,8))] : [],
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(widget.icon, size: 18, color: Colors.white),
          const SizedBox(width: 8),
          Text(widget.label, style: GoogleFonts.inter(
            fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
        ]),
      ),
    ),
  );
}

class _SecondaryButton extends StatefulWidget {
  final String label; final IconData icon; final VoidCallback onTap;
  const _SecondaryButton({required this.label, required this.icon, required this.onTap});
  @override State<_SecondaryButton> createState() => _SecondaryButtonState();
}
class _SecondaryButtonState extends State<_SecondaryButton> {
  bool _hov = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _hov = true),
    onExit:  (_) => setState(() => _hov = false),
    child: GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: _hov ? AppColors.surfaceLight : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(widget.icon, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 8),
          Text(widget.label, style: GoogleFonts.inter(
            fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
        ]),
      ),
    ),
  );
}

class _SocialIcon extends StatefulWidget {
  final IconData icon; final String label, url;
  const _SocialIcon({required this.icon, required this.label, required this.url});
  @override State<_SocialIcon> createState() => _SocialIconState();
}
class _SocialIconState extends State<_SocialIcon> {
  bool _hov = false;
  void _launch() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) launchUrl(uri);
  }
  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _hov = true),
    onExit:  (_) => setState(() => _hov = false),
    child: GestureDetector(
      onTap: _launch,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: _hov ? AppColors.accentGlow : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _hov ? AppColors.accent : AppColors.border),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(widget.icon, size: 16,
            color: _hov ? AppColors.accentLight : AppColors.textSecondary),
          const SizedBox(width: 6),
          Text(widget.label, style: GoogleFonts.inter(
            fontSize: 13, color: _hov ? AppColors.accentLight : AppColors.textSecondary)),
        ]),
      ),
    ),
  );
}
