import 'package:flutter/material.dart';

import '../data.dart' as d;
import '../theme.dart';
import '../widgets/common.dart';

class AboutSection extends StatelessWidget {
  final AppTheme t;
  const AboutSection({super.key, required this.t});

  @override
  Widget build(BuildContext context) {
    return Section(
      t: t,
      title: 'About Me',
      subtitle: 'Passionate about mobile systems that work in the real world',
      child: LayoutBuilder(builder: (context, c) {
        final wide = c.maxWidth >= 900;
        final story = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final p in d.aboutParagraphs)
              Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Text(p, style: t.font(16, color: t.textSoft, height: 1.8)),
              ),
            const SizedBox(height: 10),
            _Highlights(t: t),
          ],
        );
        final info = _InfoCard(t: t);
        return wide
            ? EqualGrid(columns: 2, spacing: 40, weights: const [6, 4], children: [
                Reveal(child: story),
                Reveal(delayMs: 150, child: info),
              ])
            : Column(children: [
                Reveal(child: story),
                const SizedBox(height: 28),
                Reveal(child: info),
              ]);
      }),
    );
  }
}

class _Highlights extends StatelessWidget {
  final AppTheme t;
  const _Highlights({required this.t});

  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: (context, c) {
        final cols = c.maxWidth >= 520 ? 2 : 1;
        return EqualGrid(columns: cols, spacing: 16, runSpacing: 16, children: [
          for (final h in d.highlights)
            HoverBox(
              t: t,
              padding: const EdgeInsets.all(18),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(h.icon, color: t.accentText, size: 26),
                    const SizedBox(height: 10),
                    Text(h.title, style: t.font(15, weight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(h.text,
                        style: t.font(13, color: t.textSoft, height: 1.5)),
                  ]),
            ),
        ]);
      });
}

class _InfoCard extends StatelessWidget {
  final AppTheme t;
  const _InfoCard({required this.t});

  Widget _row(IconData icon, String label, String value, {VoidCallback? onTap}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: MouseRegion(
          cursor: onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
          child: GestureDetector(
            onTap: onTap,
            child: Row(children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                    color: t.accentSoft, borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, size: 20, color: t.accentText),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label, style: t.font(12, color: t.textSoft)),
                      Text(value,
                          style: t.font(14, weight: FontWeight.w600)),
                    ]),
              ),
            ]),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => HoverBox(
        t: t,
        padding: const EdgeInsets.all(26),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Text('Quick Info', style: t.font(18, weight: FontWeight.w700)),
          const SizedBox(height: 22),
          _row(Icons.mail_outline, 'Email', d.email,
              onTap: () => openUrl('mailto:${d.email}')),
          _row(Icons.phone_outlined, 'Phone', d.phone,
              onTap: () => openUrl('tel:${d.phoneRaw}')),
          _row(Icons.location_on_outlined, 'Location', d.location),
          _row(Icons.school_outlined, 'Education',
              'BS Computer Science, COMSATS (2019)'),
        ]),
      );
}
