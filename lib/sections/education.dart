import 'package:flutter/material.dart';

import '../data.dart' as d;
import '../theme.dart';
import '../widgets/common.dart';

class EducationSection extends StatelessWidget {
  final AppTheme t;
  const EducationSection({super.key, required this.t});

  @override
  Widget build(BuildContext context) {
    return Section(
      t: t,
      title: 'Education',
      subtitle: 'Academic background, certifications and awards',
      child: LayoutBuilder(builder: (context, c) {
        final cols = c.maxWidth >= 900 ? 3 : (c.maxWidth >= 600 ? 2 : 1);
        return EqualGrid(columns: cols, children: [
          for (final e in d.education)
            Reveal(
              child: _Card(
                t: t,
                icon: Icons.school_outlined,
                title: e.degree,
                subtitle: e.school,
                trailing: e.note == null ? e.year : '${e.year} · ${e.note}',
              ),
            ),
          for (final c in d.certifications)
            Reveal(
              child: _Card(
                  t: t,
                  icon: Icons.verified_outlined,
                  title: 'Certification',
                  subtitle: c),
            ),
          for (final a in d.awards)
            Reveal(
              child: _Card(
                  t: t,
                  icon: Icons.emoji_events_outlined,
                  title: 'Award',
                  subtitle: a),
            ),
        ]);
      }),
    );
  }
}

class _Card extends StatelessWidget {
  final AppTheme t;
  final IconData icon;
  final String title;
  final String subtitle;
  final String? trailing;
  const _Card({
    required this.t,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) => HoverBox(
        t: t,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: t.accentSoft, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: t.accentText),
          ),
          const SizedBox(height: 16),
          Text(title, style: t.font(16, weight: FontWeight.w700, height: 1.3)),
          const SizedBox(height: 6),
          Text(subtitle, style: t.font(14, color: t.textSoft, height: 1.5)),
          if (trailing != null) ...[
            const SizedBox(height: 12),
            Text(trailing!,
                style: t.font(13, weight: FontWeight.w600, color: t.accentText)),
          ],
        ]),
      );
}
