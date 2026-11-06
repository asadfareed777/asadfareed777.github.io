import 'package:flutter/material.dart';

import 'data.dart' as d;
import 'sections/about.dart';
import 'sections/contact.dart';
import 'sections/education.dart';
import 'sections/experience.dart';
import 'sections/hero.dart';
import 'sections/projects.dart';
import 'sections/skills.dart';
import 'theme.dart';
import 'widgets/navbar.dart';

void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  bool _dark = true;
  int _palette = 0;

  @override
  Widget build(BuildContext context) {
    final t = AppTheme(_dark, palettes[_palette]);
    return MaterialApp(
      title: '${d.name} — ${d.title}',
      debugShowCheckedModeBanner: false,
      theme: t.material,
      home: HomePage(
        t: t,
        paletteIndex: _palette,
        onToggleDark: () => setState(() => _dark = !_dark),
        onPalette: (i) => setState(() => _palette = i),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final AppTheme t;
  final int paletteIndex;
  final VoidCallback onToggleDark;
  final ValueChanged<int> onPalette;
  const HomePage({
    super.key,
    required this.t,
    required this.paletteIndex,
    required this.onToggleDark,
    required this.onPalette,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _labels = <String>[
    'Home',
    'About',
    'Skills',
    'Experience',
    'Projects',
    'Education',
    'Contact',
  ];

  final _scroll = ScrollController();
  final _keys = List<GlobalKey>.generate(_labels.length, (_) => GlobalKey());
  int _active = 0;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    for (var i = _keys.length - 1; i >= 0; i--) {
      final box = _keys[i].currentContext?.findRenderObject() as RenderBox?;
      if (box == null || !box.attached) continue;
      if (box.localToGlobal(Offset.zero).dy <= 140) {
        if (_active != i) setState(() => _active = i);
        return;
      }
    }
  }

  void _goTo(int i) {
    final ctx = _keys[i].currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.t;
    return Scaffold(
      backgroundColor: t.bg,
      body: Stack(children: [
        SingleChildScrollView(
          controller: _scroll,
          child: Column(children: [
            KeyedSubtree(
              key: _keys[0],
              child: HeroSection(
                  t: t, onProjects: () => _goTo(4), onContact: () => _goTo(6)),
            ),
            KeyedSubtree(key: _keys[1], child: AboutSection(t: t)),
            KeyedSubtree(key: _keys[2], child: SkillsSection(t: t)),
            KeyedSubtree(key: _keys[3], child: ExperienceSection(t: t)),
            KeyedSubtree(key: _keys[4], child: ProjectsSection(t: t)),
            KeyedSubtree(key: _keys[5], child: EducationSection(t: t)),
            KeyedSubtree(key: _keys[6], child: ContactSection(t: t)),
          ]),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: NavBar(
            t: t,
            labels: _labels,
            active: _active,
            paletteIndex: widget.paletteIndex,
            onNav: _goTo,
            onToggleDark: widget.onToggleDark,
            onPalette: widget.onPalette,
          ),
        ),
      ]),
    );
  }
}
