import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../utils/app_colors.dart';

class SectionWrapper extends StatefulWidget {
  final String sectionKey;
  final String title;
  final String? subtitle;
  final Widget child;
  final VoidCallback? onVisible;

  const SectionWrapper({
    super.key, required this.sectionKey, required this.title,
    this.subtitle, required this.child, this.onVisible,
  });

  @override
  State<SectionWrapper> createState() => _SectionWrapperState();
}

class _SectionWrapperState extends State<SectionWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _fade  = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  void _onVisible(VisibilityInfo info) {
    if (info.visibleFraction > 0.1 && !_triggered) {
      _triggered = true;
      _ctrl.forward();
      widget.onVisible?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final hPad = w > 1200 ? 160.0 : w > 768 ? 80.0 : 24.0;

    return VisibilityDetector(
      key: Key(widget.sectionKey),
      onVisibilityChanged: _onVisible,
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section header
                Row(
                  children: [
                    Container(width: 4, height: 32, color: AppColors.accent,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(2))),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title,
                          style: GoogleFonts.inter(
                            fontSize: 28, fontWeight: FontWeight.w800,
                            color: AppColors.white, letterSpacing: -0.5,
                          )),
                        if (widget.subtitle != null)
                          Text(widget.subtitle!,
                            style: GoogleFonts.inter(
                              fontSize: 14, color: AppColors.textSecondary,
                              fontWeight: FontWeight.w400,
                            )),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                widget.child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
