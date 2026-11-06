import 'package:flutter/material.dart';

import '../data.dart' as d;
import '../theme.dart';
import '../widgets/common.dart';

class ExperienceSection extends StatelessWidget {
  final AppTheme t;
  const ExperienceSection({super.key, required this.t});

  @override
  Widget build(BuildContext context) {
    return Section(
      t: t,
      title: 'Work Experience',
      subtitle: 'My journey: 6+ years of building mobile apps',
      child: Column(children: [
        for (var i = 0; i < d.jobs.length; i++)
          Reveal(
            child: _JobRow(t: t, job: d.jobs[i], last: i == d.jobs.length - 1),
          ),
      ]),
    );
  }
}

class _JobRow extends StatelessWidget {
  final AppTheme t;
  final d.Job job;
  final bool last;
  const _JobRow({required this.t, required this.job, required this.last});

  @override
  Widget build(BuildContext context) {
    final period = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: job.current ? t.accentSoft : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: job.current ? t.accent : t.border),
      ),
      child: Text(job.period,
          style: t.font(12,
              weight: FontWeight.w600,
              color: job.current ? t.accentText : t.textSoft)),
    );

    return Stack(children: [
      if (!last)
        Positioned(
          left: 6,
          top: 46,
          bottom: 0,
          child: Container(width: 2, color: t.border),
        ),
      Positioned(
        left: 0,
        top: 26,
        child: Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: job.current ? t.accent : t.border,
            boxShadow: job.current
                ? [BoxShadow(color: t.accent.withOpacity(0.6), blurRadius: 10)]
                : const [],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 42),
        child: Padding(
            padding: EdgeInsets.only(bottom: last ? 0 : 24),
            child: HoverBox(
              t: t,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Builder(builder: (context) {
                    final title = Text(job.role,
                        style: t.font(17, weight: FontWeight.w700));
                    if (MediaQuery.sizeOf(context).width > 800) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: title),
                          const SizedBox(width: 16),
                          period,
                        ],
                      );
                    }
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [title, const SizedBox(height: 10), period]);
                  }),
                  const SizedBox(height: 8),
                  Row(children: [
                    Icon(Icons.business_outlined, size: 16, color: t.accentText),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(job.company,
                          style: t.font(14,
                              weight: FontWeight.w600, color: t.accentText)),
                    ),
                  ]),
                  const SizedBox(height: 16),
                  for (final p in job.points)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                  color: t.accent, shape: BoxShape.circle),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(p,
                                style:
                                    t.font(14, color: t.textSoft, height: 1.6)),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
      ),
    ]);
  }
}
