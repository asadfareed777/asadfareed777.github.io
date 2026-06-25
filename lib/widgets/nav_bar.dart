import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class NavBar extends StatefulWidget {
  final List<String> sections;
  final Function(int) onTap;
  final int activeIndex;
  const NavBar({super.key, required this.sections, required this.onTap, required this.activeIndex});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.95),
        border: const Border(bottom: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Asad',
                  style: GoogleFonts.inter(
                    fontSize: 22, fontWeight: FontWeight.w800,
                    color: AppColors.white,
                  ),
                ),
                TextSpan(
                  text: 'Fareed',
                  style: GoogleFonts.inter(
                    fontSize: 22, fontWeight: FontWeight.w800,
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),
          ),
          if (!isMobile)
            Row(
              children: List.generate(widget.sections.length, (i) {
                final isActive = widget.activeIndex == i;
                final isHovered = _hoveredIndex == i;
                return MouseRegion(
                  onEnter: (_) => setState(() => _hoveredIndex = i),
                  onExit:  (_) => setState(() => _hoveredIndex = null),
                  child: GestureDetector(
                    onTap: () => widget.onTap(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppColors.accentGlow
                            : isHovered
                                ? AppColors.border.withOpacity(0.5)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: isActive
                            ? Border.all(color: AppColors.accent, width: 1)
                            : Border.all(color: Colors.transparent),
                      ),
                      child: Text(
                        widget.sections[i],
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                          color: isActive ? AppColors.accentLight : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
        ],
      ),
    );
  }
}
