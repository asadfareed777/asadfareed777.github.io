import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/app_colors.dart';
import '../models/project_model.dart';
import '../widgets/section_wrapper.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final featured = projects.where((p) => p.featured).toList();
    final others   = projects.where((p) => !p.featured).toList();
    final w = MediaQuery.of(context).size.width;

    return Container(
      color: AppColors.surface,
      child: SectionWrapper(
        sectionKey: 'projects',
        title: 'Projects',
        subtitle: 'Apps I\'ve built and shipped to production',
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Featured Projects', style: GoogleFonts.inter(
            fontSize: 16, fontWeight: FontWeight.w700,
            color: AppColors.accentLight)),
          const SizedBox(height: 20),
          // Featured — larger cards
          ...featured.map((p) => _FeaturedCard(project: p)),
          const SizedBox(height: 40),
          Text('Other Projects', style: GoogleFonts.inter(
            fontSize: 16, fontWeight: FontWeight.w700,
            color: AppColors.accentLight)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16, runSpacing: 16,
            children: others.map((p) => _SmallCard(project: p, maxW: w > 768 ? 300.0 : double.infinity)).toList(),
          ),
        ]),
      ),
    );
  }
}

class _FeaturedCard extends StatefulWidget {
  final Project project;
  const _FeaturedCard({required this.project});
  @override State<_FeaturedCard> createState() => _FeaturedCardState();
}

class _FeaturedCardState extends State<_FeaturedCard> {
  bool _hov = false;
  void _launch() async {
    if (widget.project.playStoreUrl == null) return;
    final uri = Uri.parse(widget.project.playStoreUrl!);
    if (await canLaunchUrl(uri)) launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hov = true),
        onExit:  (_) => setState(() => _hov = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: _hov ? AppColors.surfaceLight : AppColors.cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _hov ? AppColors.accent : AppColors.border),
            boxShadow: _hov ? [BoxShadow(
              color: AppColors.accent.withOpacity(0.15),
              blurRadius: 30, offset: const Offset(0, 10))] : [],
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.accentGlow, borderRadius: BorderRadius.circular(4)),
                  child: Text('Featured', style: GoogleFonts.inter(
                    fontSize: 11, color: AppColors.accentLight, fontWeight: FontWeight.w700)),
                ),
                const SizedBox(height: 8),
                Text(widget.project.title, style: GoogleFonts.inter(
                  fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.white)),
                const SizedBox(height: 4),
                Text(widget.project.organization, style: GoogleFonts.inter(
                  fontSize: 13, color: AppColors.accentLight, fontWeight: FontWeight.w500)),
              ])),
              if (widget.project.playStoreUrl != null)
                _LaunchButton(onTap: _launch),
            ]),
            const SizedBox(height: 16),
            Text(widget.project.description, style: GoogleFonts.inter(
              fontSize: 14, color: AppColors.textSecondary, height: 1.7)),
            const SizedBox(height: 16),
            Wrap(spacing: 8, runSpacing: 8, children: widget.project.tags.map((tag) =>
              _Tag(tag: tag)).toList()),
            const SizedBox(height: 12),
            Row(children: [
              const Icon(Icons.calendar_today_outlined, size: 13,
                color: AppColors.textSecondary),
              const SizedBox(width: 5),
              Text(widget.project.period, style: GoogleFonts.inter(
                fontSize: 12, color: AppColors.textSecondary)),
            ]),
          ]),
        ),
      ),
    );
  }
}

class _SmallCard extends StatefulWidget {
  final Project project; final double maxW;
  const _SmallCard({required this.project, required this.maxW});
  @override State<_SmallCard> createState() => _SmallCardState();
}

class _SmallCardState extends State<_SmallCard> {
  bool _hov = false;
  void _launch() async {
    if (widget.project.playStoreUrl == null) return;
    final uri = Uri.parse(widget.project.playStoreUrl!);
    if (await canLaunchUrl(uri)) launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hov = true),
      onExit:  (_) => setState(() => _hov = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: widget.maxW == double.infinity
            ? MediaQuery.of(context).size.width - 48
            : widget.maxW,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _hov ? AppColors.surfaceLight : AppColors.cardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _hov ? AppColors.accent : AppColors.border),
          boxShadow: _hov ? [BoxShadow(
            color: AppColors.accent.withOpacity(0.1),
            blurRadius: 20, offset: const Offset(0, 6))] : [],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(child: Text(widget.project.title, style: GoogleFonts.inter(
              fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.white))),
            if (widget.project.playStoreUrl != null)
              GestureDetector(onTap: _launch,
                child: Icon(Icons.open_in_new, size: 16,
                  color: _hov ? AppColors.accent : AppColors.textSecondary)),
          ]),
          const SizedBox(height: 4),
          Text(widget.project.organization, style: GoogleFonts.inter(
            fontSize: 11, color: AppColors.accentLight)),
          const SizedBox(height: 10),
          Text(widget.project.description, maxLines: 3, overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 12, color: AppColors.textSecondary, height: 1.6)),
          const SizedBox(height: 12),
          Wrap(spacing: 6, runSpacing: 6,
            children: widget.project.tags.take(3).map((t) => _Tag(tag: t, small: true)).toList()),
        ]),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String tag; final bool small;
  const _Tag({required this.tag, this.small = false});
  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(
      horizontal: small ? 8 : 10, vertical: small ? 3 : 5),
    decoration: BoxDecoration(
      color: AppColors.accentGlow,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: AppColors.accent.withOpacity(0.3)),
    ),
    child: Text(tag, style: GoogleFonts.inter(
      fontSize: small ? 11 : 12, color: AppColors.accentLight,
      fontWeight: FontWeight.w600)),
  );
}

class _LaunchButton extends StatefulWidget {
  final VoidCallback onTap;
  const _LaunchButton({required this.onTap});
  @override State<_LaunchButton> createState() => _LaunchButtonState();
}
class _LaunchButtonState extends State<_LaunchButton> {
  bool _hov = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _hov = true),
    onExit:  (_) => setState(() => _hov = false),
    child: GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: _hov ? AppColors.accent : AppColors.accentGlow,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.accent),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.play_arrow, size: 16,
            color: _hov ? Colors.white : AppColors.accent),
          const SizedBox(width: 6),
          Text('Play Store', style: GoogleFonts.inter(
            fontSize: 12, fontWeight: FontWeight.w600,
            color: _hov ? Colors.white : AppColors.accent)),
        ]),
      ),
    ),
  );
}
