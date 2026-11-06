import 'package:flutter/material.dart';

import '../data.dart' as d;
import '../theme.dart';
import '../widgets/common.dart';

class SkillsSection extends StatelessWidget {
  final AppTheme t;
  const SkillsSection({super.key, required this.t});

  @override
  Widget build(BuildContext context) {
    return Section(
      t: t,
      alt: true,
      title: 'Skills & Tech Stack',
      subtitle: 'My toolkit',
      child: LayoutBuilder(builder: (context, c) {
        final cols = c.maxWidth >= 1000 ? 3 : (c.maxWidth >= 640 ? 2 : 1);
        return EqualGrid(columns: cols, children: [
          for (var i = 0; i < d.skillGroups.length; i++)
            Reveal(
              delayMs: (i % cols) * 90,
              child: _SkillCard(t: t, group: d.skillGroups[i]),
            ),
        ]);
      }),
    );
  }
}

class _SkillCard extends StatelessWidget {
  final AppTheme t;
  final d.SkillGroup group;
  const _SkillCard({required this.t, required this.group});

  @override
  Widget build(BuildContext context) => HoverBox(
        t: t,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: t.accentSoft, borderRadius: BorderRadius.circular(10)),
              child: Icon(group.icon, size: 20, color: t.accentText),
            ),
            const SizedBox(width: 12),
            Expanded(
                child: Text(group.title,
                    style: t.font(16, weight: FontWeight.w700))),
          ]),
          const SizedBox(height: 16),
          Wrap(spacing: 8, runSpacing: 8, children: [
            for (final s in group.items) Tag(t: t, label: s),
          ]),
        ]),
      );
}
