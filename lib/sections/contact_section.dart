import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/app_colors.dart';
import '../utils/constants.dart';
import '../widgets/section_wrapper.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  void _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      sectionKey: 'contact',
      title: 'Get In Touch',
      subtitle: 'Open to senior roles, consulting, and freelance projects',
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: AppColors.cardBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                    colors: [AppColors.cardBg, Color(0xFF0F2040)]),
                ),
                child: Column(children: [
                  ShaderMask(
                    shaderCallback: (b) => const LinearGradient(
                      colors: [AppColors.accentLight, AppColors.accent],
                    ).createShader(b),
                    child: Text("Let's Work Together",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 32, fontWeight: FontWeight.w800,
                        color: Colors.white)),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Whether you're looking for a senior Android/Flutter developer, need a technical consultant, "
                    "or want to discuss an exciting project — I'd love to hear from you.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 15, color: AppColors.textSecondary, height: 1.7)),
                  const SizedBox(height: 36),
                  Wrap(spacing: 16, runSpacing: 16, alignment: WrapAlignment.center,
                    children: [
                      _ContactCard(
                        icon: Icons.email_outlined,
                        label: 'Email',
                        value: AppConstants.email,
                        onTap: () => _launch('mailto:${AppConstants.email}'),
                      ),
                      _ContactCard(
                        icon: Icons.phone_outlined,
                        label: 'Phone',
                        value: AppConstants.phone,
                        onTap: () => _launch('tel:${AppConstants.phone}'),
                      ),
                      _ContactCard(
                        icon: Icons.work_outline,
                        label: 'LinkedIn',
                        value: 'asad-fareed',
                        onTap: () => _launch(AppConstants.linkedin),
                      ),
                      _ContactCard(
                        icon: Icons.code,
                        label: 'GitHub',
                        value: 'asadfareed777',
                        onTap: () => _launch(AppConstants.github),
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),
                  _BigEmailButton(onTap: () => _launch('mailto:${AppConstants.email}')),
                ]),
              ),
              const SizedBox(height: 60),
              // Footer
              Column(children: [
                const Divider(color: AppColors.border),
                const SizedBox(height: 20),
                Text('© 2024 Asad Fareed · Senior Android & Flutter Developer',
                  style: GoogleFonts.inter(
                    fontSize: 13, color: AppColors.textSecondary)),
                const SizedBox(height: 6),
                Text('Built with Flutter Web ❤️',
                  style: GoogleFonts.inter(
                    fontSize: 12, color: AppColors.border)),
                const SizedBox(height: 32),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactCard extends StatefulWidget {
  final IconData icon; final String label, value; final VoidCallback onTap;
  const _ContactCard({required this.icon, required this.label,
    required this.value, required this.onTap});
  @override State<_ContactCard> createState() => _ContactCardState();
}
class _ContactCardState extends State<_ContactCard> {
  bool _hov = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _hov = true),
    onExit:  (_) => setState(() => _hov = false),
    child: GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: _hov ? AppColors.surfaceLight : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _hov ? AppColors.accent : AppColors.border),
          boxShadow: _hov ? [BoxShadow(
            color: AppColors.accent.withOpacity(0.15),
            blurRadius: 16, offset: const Offset(0, 4))] : [],
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(widget.icon, size: 18,
            color: _hov ? AppColors.accent : AppColors.textSecondary),
          const SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(widget.label, style: GoogleFonts.inter(
              fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
            Text(widget.value, style: GoogleFonts.inter(
              fontSize: 13, color: _hov ? AppColors.accentLight : AppColors.textPrimary,
              fontWeight: FontWeight.w600)),
          ]),
        ]),
      ),
    ),
  );
}

class _BigEmailButton extends StatefulWidget {
  final VoidCallback onTap;
  const _BigEmailButton({required this.onTap});
  @override State<_BigEmailButton> createState() => _BigEmailButtonState();
}
class _BigEmailButtonState extends State<_BigEmailButton> {
  bool _hov = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _hov = true),
    onExit:  (_) => setState(() => _hov = false),
    child: GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: _hov
            ? [AppColors.accentLight, AppColors.accent]
            : [AppColors.accent, const Color(0xFF1A5A9A)]),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(
            color: AppColors.accent.withOpacity(_hov ? 0.5 : 0.25),
            blurRadius: _hov ? 30 : 15, offset: const Offset(0, 8))],
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.email_outlined, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Text('Send me an Email', style: GoogleFonts.inter(
            fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
        ]),
      ),
    ),
  );
}
