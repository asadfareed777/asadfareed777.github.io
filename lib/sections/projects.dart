import 'package:flutter/material.dart';

import '../data.dart' as d;
import '../theme.dart';
import '../widgets/common.dart';

class ProjectsSection extends StatelessWidget {
  final AppTheme t;
  const ProjectsSection({super.key, required this.t});

  @override
  Widget build(BuildContext context) {
    return Section(
      t: t,
      alt: true,
      title: 'Featured Projects',
      subtitle: 'My work: apps shipped to production',
      child: LayoutBuilder(builder: (context, c) {
        final cols = c.maxWidth >= 900 ? 2 : 1;
        return EqualGrid(columns: cols, spacing: 24, runSpacing: 24, children: [
          for (var i = 0; i < d.projects.length; i++)
            Reveal(
              delayMs: (i % cols) * 100,
              child: _ProjectCard(t: t, p: d.projects[i]),
            ),
        ]);
      }),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final AppTheme t;
  final d.Project p;
  const _ProjectCard({required this.t, required this.p});

  @override
  Widget build(BuildContext context) => HoverBox(
        t: t,
        padding: const EdgeInsets.all(26),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            if (p.featured) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    color: t.accentSoft, borderRadius: BorderRadius.circular(5)),
                child: Text('FEATURED',
                    style: t.font(11,
                        weight: FontWeight.w800,
                        color: t.accentText,
                        spacing: 1)),
              ),
              const SizedBox(width: 10),
            ],
            Expanded(
              child: Text(p.period, style: t.font(12, color: t.textSoft)),
            ),
          ]),
          const SizedBox(height: 14),
          Text(p.title, style: t.font(22, weight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(p.org,
              style: t.font(13, weight: FontWeight.w600, color: t.accentText)),
          const SizedBox(height: 16),
          Text('Overview',
              style: t.font(12,
                  weight: FontWeight.w700, color: t.textSoft, spacing: 1)),
          const SizedBox(height: 6),
          Text(p.overview, style: t.font(14, color: t.text, height: 1.6)),
          const SizedBox(height: 16),
          Text('Key Features',
              style: t.font(12,
                  weight: FontWeight.w700, color: t.textSoft, spacing: 1)),
          const SizedBox(height: 8),
          for (final f in p.features)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Icon(Icons.check_circle_outline,
                          size: 16, color: t.accent),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(f,
                          style: t.font(13, color: t.textSoft, height: 1.5)),
                    ),
                  ]),
            ),
          const SizedBox(height: 14),
          Wrap(spacing: 8, runSpacing: 8, children: [
            for (final tag in p.tags) Tag(t: t, label: tag),
          ]),
          if (p.playStore != null) ...[
            const SizedBox(height: 20),
            Btn(
              t: t,
              label: 'Play Store',
              icon: Icons.play_arrow_rounded,
              onTap: () => openUrl(p.playStore!),
            ),
          ],
        ]),
      );
}
