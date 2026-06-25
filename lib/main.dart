import 'package:flutter/material.dart';
import 'utils/app_theme.dart';
import 'utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/nav_bar.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/experience_section.dart';
import 'sections/projects_section.dart';
import 'sections/contact_section.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asad Fareed — Senior Android & Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});
  @override State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final _scrollCtrl = ScrollController();
  final List<GlobalKey> _keys = List.generate(6, (_) => GlobalKey());
  int _activeNav = 0;

  final _sections = ['Home', 'About', 'Skills', 'Experience', 'Projects', 'Contact'];

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _onScroll() {
    for (int i = _keys.length - 1; i >= 0; i--) {
      final ctx = _keys[i].currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) continue;
      final pos = box.localToGlobal(Offset.zero);
      if (pos.dy <= 100) {
        if (_activeNav != i) setState(() => _activeNav = i);
        break;
      }
    }
  }

  void _scrollTo(int index) {
    final ctx = _keys[index].currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut);
    setState(() => _activeNav = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollCtrl,
            child: Column(
              children: [
                const SizedBox(height: 64), // nav height offset
                KeyedSubtree(key: _keys[0],
                  child: HeroSection(onContactTap: () => _scrollTo(4))),
                KeyedSubtree(key: _keys[1], child: const AboutSection()),
                KeyedSubtree(key: _keys[2], child: const SkillsSection()),
                KeyedSubtree(key: _keys[3], child: const ExperienceSection()),
                KeyedSubtree(key: _keys[4], child: const ProjectsSection()),
                KeyedSubtree(key: _keys[5], child: const ContactSection()),
              ],
            ),
          ),
          // Sticky nav
          Positioned(
            top: 0, left: 0, right: 0,
            child: NavBar(
              sections: _sections,
              onTap: _scrollTo,
              activeIndex: _activeNav,
            ),
          ),
        ],
      ),
    );
  }
}
