import 'package:flutter/material.dart';

import '../theme.dart';
import 'common.dart';

class NavBar extends StatelessWidget {
  final AppTheme t;
  final List<String> labels;
  final int active;
  final int paletteIndex;
  final ValueChanged<int> onNav;
  final VoidCallback onToggleDark;
  final ValueChanged<int> onPalette;

  const NavBar({
    super.key,
    required this.t,
    required this.labels,
    required this.active,
    required this.paletteIndex,
    required this.onNav,
    required this.onToggleDark,
    required this.onPalette,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final mobile = w < 1000;
    final side = w > kMaxW ? (w - kMaxW) / 2 + 48 : hPad(w);

    return Container(
      height: 64,
      padding: EdgeInsets.symmetric(horizontal: side),
      decoration: BoxDecoration(
        color: t.bg.withOpacity(0.94),
        border: Border(bottom: BorderSide(color: t.border)),
      ),
      child: Row(children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => onNav(0),
            child: Text.rich(TextSpan(children: [
              TextSpan(
                  text: 'Asad ',
                  style: t.font(21, weight: FontWeight.w800, color: t.accent)),
              TextSpan(
                  text: 'Fareed',
                  style: t.font(21, weight: FontWeight.w800)),
            ])),
          ),
        ),
        const Spacer(),
        if (!mobile)
          for (var i = 0; i < labels.length; i++)
            _NavLink(
              t: t,
              label: labels[i],
              active: active == i,
              onTap: () => onNav(i),
            ),
        const SizedBox(width: 12),
        _RoundBtn(
          t: t,
          tooltip: t.dark ? 'Light mode' : 'Dark mode',
          onTap: onToggleDark,
          child: Icon(
              t.dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
              size: 19,
              color: t.textSoft),
        ),
        const SizedBox(width: 10),
        PopupMenuButton<int>(
          tooltip: 'Color palette',
          color: t.card,
          padding: EdgeInsets.zero,
          onSelected: onPalette,
          itemBuilder: (_) => [
            for (var i = 0; i < palettes.length; i++)
              PopupMenuItem<int>(
                value: i,
                child: Row(children: [
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                        color: palettes[i].color, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 10),
                  Text(palettes[i].name, style: t.font(13)),
                  if (i == paletteIndex) ...[
                    const SizedBox(width: 8),
                    Icon(Icons.check, size: 16, color: t.accent),
                  ],
                ]),
              ),
          ],
          child: _RoundBtn(
            t: t,
            child: Icon(Icons.palette_outlined, size: 19, color: t.accent),
          ),
        ),
        if (!mobile) ...[
          const SizedBox(width: 16),
          Btn(t: t, label: 'Resume', icon: Icons.download, onTap: openCv),
        ],
        if (mobile) const SizedBox(width: 6),
        if (mobile)
          PopupMenuButton<int>(
            tooltip: 'Menu',
            color: t.card,
            icon: Icon(Icons.menu, color: t.textSoft),
            onSelected: (i) => i == labels.length ? openCv() : onNav(i),
            itemBuilder: (_) => [
              for (var i = 0; i < labels.length; i++)
                PopupMenuItem<int>(
                  value: i,
                  child: Text(labels[i],
                      style: t.font(14,
                          weight:
                              active == i ? FontWeight.w700 : FontWeight.w400,
                          color: active == i ? t.accentText : t.text)),
                ),
              PopupMenuItem<int>(
                value: labels.length,
                child: Text('Resume', style: t.font(14, color: t.accentText)),
              ),
            ],
          ),
      ]),
    );
  }
}

class _NavLink extends StatefulWidget {
  final AppTheme t;
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _NavLink(
      {required this.t,
      required this.label,
      required this.active,
      required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    final t = widget.t;
    final on = widget.active || _h;
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(widget.label,
                style: t.font(14,
                    weight: widget.active ? FontWeight.w700 : FontWeight.w500,
                    color: on ? t.accentText : t.textSoft)),
            const SizedBox(height: 3),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              height: 2,
              width: on ? 20 : 0,
              decoration: BoxDecoration(
                  color: t.accent, borderRadius: BorderRadius.circular(1)),
            ),
          ]),
        ),
      ),
    );
  }
}

/// 40x40 bordered circle used for the navbar controls.
class _RoundBtn extends StatelessWidget {
  final AppTheme t;
  final Widget child;
  final String? tooltip;
  final VoidCallback? onTap;
  const _RoundBtn(
      {required this.t, required this.child, this.tooltip, this.onTap});

  @override
  Widget build(BuildContext context) {
    Widget w = MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: t.border),
          ),
          child: child,
        ),
      ),
    );
    if (tooltip != null) w = Tooltip(message: tooltip!, child: w);
    return w;
  }
}
