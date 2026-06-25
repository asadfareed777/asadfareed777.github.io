import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import '../models/experience_model.dart';
import '../widgets/section_wrapper.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      sectionKey: 'experience',
      title: 'Work Experience',
      subtitle: '6+ years building enterprise mobile applications',
      child: Column(
        children: List.generate(experiences.length, (i) =>
          _ExperienceCard(exp: experiences[i], isLast: i == experiences.length - 1)),
      ),
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  final Experience exp;
  final bool isLast;
  const _ExperienceCard({required this.exp, required this.isLast});
  @override State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline column
          SizedBox(
            width: 28,
            child: Column(children: [
              Container(
                width: 12, height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.exp.isCurrent ? AppColors.accent : AppColors.border,
                  border: Border.all(
                    color: widget.exp.isCurrent ? AppColors.accentLight : AppColors.border,
                    width: 2),
                  boxShadow: widget.exp.isCurrent ? [BoxShadow(
                    color: AppColors.accent.withOpacity(0.5), blurRadius: 8)] : [],
                ),
              ),
              if (!widget.isLast)
                Expanded(child: Container(
                  width: 2,
                  color: AppColors.border,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                )),
            ]),
          ),
          const SizedBox(width: 16),
          // Card
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: widget.isLast ? 0 : 24),
              child: MouseRegion(
                onEnter: (_) => setState(() => _hov = true),
                onExit:  (_) => setState(() => _hov = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: _hov ? AppColors.surfaceLight : AppColors.cardBg,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: _hov ? AppColors.accent : AppColors.border),
                    boxShadow: _hov ? [BoxShadow(
                      color: AppColors.accent.withOpacity(0.1),
                      blurRadius: 20, offset: const Offset(0, 6))] : [],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header row
                      if (isMobile)
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          _buildTitleBadge(),
                          const SizedBox(height: 8),
                          _buildDateBadge(),
                        ])
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildTitleBadge()),
                            const SizedBox(width: 16),
                            _buildDateBadge(),
                          ],
                        ),
                      const SizedBox(height: 6),
                      Row(children: [
                        const Icon(Icons.business_outlined, size: 14,
                          color: AppColors.textSecondary),
                        const SizedBox(width: 5),
                        Text(widget.exp.company,
                          style: GoogleFonts.inter(
                            fontSize: 13, color: AppColors.accentLight,
                            fontWeight: FontWeight.w600)),
                        const SizedBox(width: 12),
                        const Icon(Icons.location_on_outlined, size: 14,
                          color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Text(widget.exp.location,
                          style: GoogleFonts.inter(
                            fontSize: 12, color: AppColors.textSecondary)),
                      ]),
                      const SizedBox(height: 16),
                      // Bullet highlights
                      ...widget.exp.highlights.map((h) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Container(width: 5, height: 5,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: AppColors.accent)),
                            ),
                            const SizedBox(width: 10),
                            Expanded(child: Text(h, style: GoogleFonts.inter(
                              fontSize: 13, color: AppColors.textSecondary, height: 1.6))),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleBadge() => Text(widget.exp.role,
    style: GoogleFonts.inter(
      fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.white));

  Widget _buildDateBadge() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    decoration: BoxDecoration(
      color: widget.exp.isCurrent
          ? AppColors.accentGlow
          : AppColors.surface,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: widget.exp.isCurrent ? AppColors.accent : AppColors.border),
    ),
    child: Text(widget.exp.period,
      style: GoogleFonts.inter(
        fontSize: 12, fontWeight: FontWeight.w600,
        color: widget.exp.isCurrent ? AppColors.accentLight : AppColors.textSecondary)),
  );
}
