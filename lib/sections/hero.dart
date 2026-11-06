import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../data.dart' as d;
import '../theme.dart';
import '../widgets/common.dart';

class HeroSection extends StatelessWidget {
  final AppTheme t;
  final VoidCallback onProjects;
  final VoidCallback onContact;
  const HeroSection({
    super.key,
    required this.t,
    required this.onProjects,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final wide = size.width >= 900;
    final pad = hPad(size.width);

    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (d.openToWork) ...[
          _Pill(t: t, label: 'Open to new opportunities'),
          const SizedBox(height: 24),
        ],
        Text("Hi, I'm", style: t.font(20, color: t.textSoft)),
        const SizedBox(height: 4),
        Text(d.name,
            style: t.font(wide ? 76 : 46,
                weight: FontWeight.w800, height: 1.05, spacing: -2)),
        const SizedBox(height: 12),
        Typewriter(
          words: d.roles,
          style: t.font(wide ? 28 : 20,
              weight: FontWeight.w600, color: t.accentText),
        ),
        const SizedBox(height: 18),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(d.tagline,
              style: t.font(17, color: t.textSoft, height: 1.6)),
        ),
        const SizedBox(height: 32),
        Wrap(spacing: 12, runSpacing: 12, children: [
          Btn(
              t: t,
              filled: true,
              label: 'View Projects',
              icon: Icons.rocket_launch_outlined,
              onTap: onProjects),
          Btn(t: t, label: 'Download CV', icon: Icons.download, onTap: openCv),
          Btn(
              t: t,
              label: 'Contact Me',
              icon: Icons.mail_outline,
              onTap: onContact),
        ]),
        const SizedBox(height: 28),
        SocialRow(t: t),
        const SizedBox(height: 44),
        Wrap(spacing: 40, runSpacing: 20, children: [
          for (final s in d.stats) _StatTile(t: t, stat: s),
        ]),
      ],
    );

    final avatar = _Avatar(t: t, size: wide ? 320 : 210);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: size.height),
      color: t.bg,
      child: Stack(clipBehavior: Clip.hardEdge, children: [
        Positioned.fill(child: CustomPaint(painter: _DotsPainter(t.border))),
        Positioned(
          top: -140,
          right: -140,
          child: Container(
            width: 560,
            height: 560,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                  colors: [t.accent.withOpacity(0.2), Colors.transparent]),
            ),
          ),
        ),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kMaxW),
            child: Padding(
              padding: EdgeInsets.fromLTRB(pad, 120, pad, 64),
              child: wide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(flex: 6, child: text),
                        const SizedBox(width: 48),
                        Expanded(flex: 4, child: Center(child: avatar)),
                      ],
                    )
                  : Column(children: [
                      avatar,
                      const SizedBox(height: 36),
                      Align(alignment: Alignment.centerLeft, child: text),
                    ]),
            ),
          ),
        ),
      ]),
    );
  }
}

class _Pill extends StatelessWidget {
  final AppTheme t;
  final String label;
  const _Pill({required this.t, required this.label});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: t.accentSoft,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: t.accent.withOpacity(0.4)),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
                color: Color(0xFF2ECC71), shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(label,
              style: t.font(13, weight: FontWeight.w600, color: t.accentText)),
        ]),
      );
}

class _StatTile extends StatelessWidget {
  final AppTheme t;
  final d.Stat stat;
  const _StatTile({required this.t, required this.stat});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(stat.value,
              style: t.font(34, weight: FontWeight.w800, color: t.accentText)),
          Text(stat.label, style: t.font(13, color: t.textSoft)),
        ],
      );
}

/// Profile photo if assets/images/profile.jpg exists, otherwise initials.
class _Avatar extends StatelessWidget {
  final AppTheme t;
  final double size;
  const _Avatar({required this.t, required this.size});

  @override
  Widget build(BuildContext context) {
    final initialsBox = Container(
      color: t.card,
      alignment: Alignment.center,
      child: Text(d.initials,
          style: t.font(size * 0.34,
              weight: FontWeight.w800, color: t.accentText)),
    );
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
            colors: [t.accent, t.accentLight.withOpacity(0.3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        boxShadow: [
          BoxShadow(color: t.accent.withOpacity(0.35), blurRadius: 60)
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/profile.jpg',
          fit: BoxFit.cover,
          alignment: const Alignment(0, -0.35),
          errorBuilder: (_, __, ___) => initialsBox,
        ),
      ),
    );
  }
}

class _DotsPainter extends CustomPainter {
  final Color color;
  _DotsPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = color.withOpacity(0.55);
    for (double x = 18; x < size.width; x += 36) {
      for (double y = 18; y < size.height; y += 36) {
        canvas.drawCircle(Offset(x, y), 1.1, p);
      }
    }
  }

  @override
  bool shouldRepaint(_DotsPainter old) => old.color != color;
}

/// Types each word out, pauses, deletes it, then moves to the next.
class Typewriter extends StatefulWidget {
  final List<String> words;
  final TextStyle style;
  const Typewriter({super.key, required this.words, required this.style});

  @override
  State<Typewriter> createState() => _TypewriterState();
}

class _TypewriterState extends State<Typewriter> {
  Timer? _timer;
  int _word = 0;
  int _chars = 0;
  bool _deleting = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 500), _tick);
  }

  void _tick() {
    if (!mounted) return;
    final word = widget.words[_word];
    var delay = 70;
    setState(() {
      if (!_deleting) {
        if (_chars < word.length) {
          _chars++;
          delay = 70;
        } else {
          _deleting = true;
          delay = 1500;
        }
      } else {
        if (_chars > 0) {
          _chars--;
          delay = 35;
        } else {
          _deleting = false;
          _word = (_word + 1) % widget.words.length;
          delay = 300;
        }
      }
      _timer = Timer(Duration(milliseconds: delay), _tick);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shown = widget.words[_word].substring(0, _chars);
    return Text('$shown|',
        maxLines: 1, overflow: TextOverflow.ellipsis, style: widget.style);
  }
}
