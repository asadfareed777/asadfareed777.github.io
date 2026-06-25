import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import '../models/skill_model.dart';
import '../widgets/section_wrapper.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      child: SectionWrapper(
        sectionKey: 'skills',
        title: 'Skills & Technologies',
        subtitle: 'Tools and technologies I work with daily',
        child: Wrap(
          spacing: 16, runSpacing: 16,
          children: skillCategories.map((cat) => _SkillCard(category: cat)).toList(),
        ),
      ),
    );
  }
}

class _SkillCard extends StatefulWidget {
  final SkillCategory category;
  const _SkillCard({required this.category});
  @override State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final cardW = w > 1200 ? 280.0 : w > 768 ? 260.0 : double.infinity;

    return MouseRegion(
      onEnter: (_) => setState(() => _hov = true),
      onExit:  (_) => setState(() => _hov = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: cardW == double.infinity ? w - 48 : cardW,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: _hov ? AppColors.surfaceLight : AppColors.cardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _hov ? AppColors.accent : AppColors.border, width: 1),
          boxShadow: _hov ? [BoxShadow(
            color: AppColors.accent.withOpacity(0.15),
            blurRadius: 24, offset: const Offset(0, 8))] : [],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text(widget.category.icon, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 10),
            Expanded(child: Text(widget.category.title,
              style: GoogleFonts.inter(
                fontSize: 14, fontWeight: FontWeight.w700,
                color: _hov ? AppColors.accentLight : AppColors.white,
              ))),
          ]),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: widget.category.skills.map((skill) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: _hov
                    ? AppColors.accent.withOpacity(0.15)
                    : AppColors.surface,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _hov
                    ? AppColors.accent.withOpacity(0.4)
                    : AppColors.border),
              ),
              child: Text(skill, style: GoogleFonts.inter(
                fontSize: 12, color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              )),
            )).toList(),
          ),
        ]),
      ),
    );
  }
}
