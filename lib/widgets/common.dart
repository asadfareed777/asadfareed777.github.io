import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../data.dart' as d;
import '../theme.dart';

Future<void> openUrl(String url) =>
    launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);

/// Opens the CV that is served from the site root (web/Asad_Fareed_CV.pdf).
Future<void> openCv() => launchUrl(
      Uri.base.resolve('Asad_Fareed_CV.pdf'),
      mode: LaunchMode.externalApplication,
    );

/// Max width of the page content (sections, hero, navbar).
const double kMaxW = 1360;

double hPad(double w) => w > 1100 ? 48 : (w > 700 ? 32 : 20);

/// Grid whose items in the same row all get the same height (no intrinsics).
/// [weights] sets relative column widths (default: equal).
class EqualGrid extends MultiChildRenderObjectWidget {
  final int columns;
  final double spacing;
  final double runSpacing;
  final List<double>? weights;
  const EqualGrid({
    super.key,
    required this.columns,
    this.spacing = 20,
    this.runSpacing = 20,
    this.weights,
    required super.children,
  });

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderEqualGrid(columns, spacing, runSpacing, weights);

  @override
  void updateRenderObject(BuildContext context, _RenderEqualGrid r) {
    r
      ..columns = columns
      ..spacing = spacing
      ..runSpacing = runSpacing
      ..weights = weights;
  }
}

class _GridParentData extends ContainerBoxParentData<RenderBox> {}

class _RenderEqualGrid extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _GridParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _GridParentData> {
  _RenderEqualGrid(this._columns, this._spacing, this._runSpacing, this._weights);

  int _columns;
  double _spacing;
  double _runSpacing;
  List<double>? _weights;

  set columns(int v) {
    if (v == _columns) return;
    _columns = v;
    markNeedsLayout();
  }

  set spacing(double v) {
    if (v == _spacing) return;
    _spacing = v;
    markNeedsLayout();
  }

  set runSpacing(double v) {
    if (v == _runSpacing) return;
    _runSpacing = v;
    markNeedsLayout();
  }

  set weights(List<double>? v) {
    _weights = v;
    markNeedsLayout();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _GridParentData) {
      child.parentData = _GridParentData();
    }
  }

  @override
  void performLayout() {
    final w = constraints.maxWidth;
    final cols = math.max(1, _columns);
    final avail = w - _spacing * (cols - 1);
    final ws = (_weights != null && _weights!.length >= cols)
        ? _weights!.sublist(0, cols)
        : List<double>.filled(cols, 1);
    final total = ws.fold<double>(0, (a, b) => a + b);
    final widths = [for (final x in ws) avail * x / total];

    var y = 0.0;
    RenderBox? child = firstChild;
    var first = true;
    while (child != null) {
      final row = <RenderBox>[];
      while (child != null && row.length < cols) {
        row.add(child);
        child = childAfter(child);
      }
      var h = 0.0;
      for (var i = 0; i < row.length; i++) {
        row[i].layout(BoxConstraints.tightFor(width: widths[i]),
            parentUsesSize: true);
        h = math.max(h, row[i].size.height);
      }
      if (!first) y += _runSpacing;
      first = false;
      var x = 0.0;
      for (var i = 0; i < row.length; i++) {
        row[i].layout(BoxConstraints.tightFor(width: widths[i], height: h),
            parentUsesSize: true);
        (row[i].parentData! as _GridParentData).offset = Offset(x, y);
        x += widths[i] + _spacing;
      }
      y += h;
    }
    size = constraints.constrain(Size(w, y));
  }

  @override
  void paint(PaintingContext context, Offset offset) =>
      defaultPaint(context, offset);

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      defaultHitTestChildren(result, position: position);
}

/// Fade + slide in the first time the child scrolls into view.
class Reveal extends StatefulWidget {
  final Widget child;
  final int delayMs;
  const Reveal({super.key, required this.child, this.delayMs = 0});

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 650));
  late final Animation<double> _fade =
      CurvedAnimation(parent: _c, curve: Curves.easeOut);
  late final Animation<Offset> _slide =
      Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
          .animate(_fade);
  final Key _vk = UniqueKey();
  bool _shown = false;

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => VisibilityDetector(
        key: _vk,
        onVisibilityChanged: (info) {
          if (_shown || info.visibleFraction < 0.05) return;
          _shown = true;
          Future.delayed(Duration(milliseconds: widget.delayMs), () {
            if (mounted) _c.forward();
          });
        },
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(position: _slide, child: widget.child),
        ),
      );
}

/// Full-width page section with the accent-bar header.
class Section extends StatelessWidget {
  final AppTheme t;
  final String title;
  final String subtitle;
  final Widget child;
  final bool alt;
  const Section({
    super.key,
    required this.t,
    required this.title,
    required this.subtitle,
    required this.child,
    this.alt = false,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return Container(
      width: double.infinity,
      color: alt ? t.surface : t.bg,
      padding: EdgeInsets.symmetric(vertical: w > 700 ? 88 : 56),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kMaxW),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad(w)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Reveal(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          width: 4,
                          height: 32,
                          decoration: BoxDecoration(
                            color: t.accent,
                            borderRadius: BorderRadius.circular(2),
                            boxShadow: [
                              BoxShadow(
                                  color: t.accent.withOpacity(0.5),
                                  blurRadius: 10)
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),
                        Flexible(
                          child: Text(title,
                              style: t.font(w > 700 ? 36 : 28,
                                  weight: FontWeight.w800, spacing: -0.5)),
                        ),
                      ]),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Text(subtitle,
                            style: t.font(15, color: t.textSoft)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 44),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Card with hover lift + accent border.
class HoverBox extends StatefulWidget {
  final AppTheme t;
  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  const HoverBox({
    super.key,
    required this.t,
    required this.child,
    this.padding = const EdgeInsets.all(22),
    this.onTap,
  });

  @override
  State<HoverBox> createState() => _HoverBoxState();
}

class _HoverBoxState extends State<HoverBox> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    final t = widget.t;
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: widget.padding,
          decoration: BoxDecoration(
            color: _h ? t.cardHover : t.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _h ? t.accent : t.border),
            boxShadow: _h
                ? [
                    BoxShadow(
                        color: t.accent.withOpacity(0.18),
                        blurRadius: 28,
                        offset: const Offset(0, 10))
                  ]
                : const [],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

class Btn extends StatefulWidget {
  final AppTheme t;
  final String label;
  final IconData? icon;
  final VoidCallback onTap;
  final bool filled;
  const Btn({
    super.key,
    required this.t,
    required this.label,
    required this.onTap,
    this.icon,
    this.filled = false,
  });

  @override
  State<Btn> createState() => _BtnState();
}

class _BtnState extends State<Btn> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    final t = widget.t;
    final fg = widget.filled ? t.onAccent : (_h ? t.accentText : t.textSoft);
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          decoration: BoxDecoration(
            gradient: widget.filled
                ? LinearGradient(
                    colors: _h
                        ? [t.accentLight, t.accent]
                        : [t.accent, t.accent.withOpacity(0.82)])
                : null,
            color: widget.filled ? null : (_h ? t.cardHover : Colors.transparent),
            borderRadius: BorderRadius.circular(10),
            border: widget.filled
                ? null
                : Border.all(color: _h ? t.accent : t.border),
            boxShadow: widget.filled
                ? [
                    BoxShadow(
                        color: t.accent.withOpacity(_h ? 0.5 : 0.25),
                        blurRadius: _h ? 28 : 14,
                        offset: const Offset(0, 6))
                  ]
                : const [],
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            if (widget.icon != null) ...[
              Icon(widget.icon, size: 18, color: fg),
              const SizedBox(width: 8),
            ],
            Text(widget.label,
                style: t.font(14, weight: FontWeight.w700, color: fg)),
          ]),
        ),
      ),
    );
  }
}

class Tag extends StatelessWidget {
  final AppTheme t;
  final String label;
  const Tag({super.key, required this.t, required this.label});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: t.accentSoft,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: t.accent.withOpacity(0.3)),
        ),
        child: Text(label,
            style: t.font(12, weight: FontWeight.w600, color: t.accentText)),
      );
}

/// Small round icon button used for social links.
class IconLink extends StatefulWidget {
  final AppTheme t;
  final FaIconData icon;
  final String tooltip;
  final VoidCallback onTap;
  const IconLink({
    super.key,
    required this.t,
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  State<IconLink> createState() => _IconLinkState();
}

class _IconLinkState extends State<IconLink> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    final t = widget.t;
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _h = true),
        onExit: (_) => setState(() => _h = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _h ? t.accentSoft : Colors.transparent,
              border: Border.all(color: _h ? t.accent : t.border),
            ),
            child: Center(child: FaIcon(widget.icon,
                size: 18, color: _h ? t.accentText : t.textSoft)),
          ),
        ),
      ),
    );
  }
}

/// LinkedIn / GitHub / Email / WhatsApp icon buttons.
class SocialRow extends StatelessWidget {
  final AppTheme t;
  final MainAxisAlignment align;
  const SocialRow({super.key, required this.t, this.align = MainAxisAlignment.start});

  @override
  Widget build(BuildContext context) => Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: align == MainAxisAlignment.center
            ? WrapAlignment.center
            : WrapAlignment.start,
        children: [
          IconLink(
              t: t,
              icon: FontAwesomeIcons.linkedinIn,
              tooltip: 'LinkedIn',
              onTap: () => openUrl(d.linkedinUrl)),
          IconLink(
              t: t,
              icon: FontAwesomeIcons.github,
              tooltip: 'GitHub',
              onTap: () => openUrl(d.githubUrl)),
          IconLink(
              t: t,
              icon: FontAwesomeIcons.envelope,
              tooltip: 'Email',
              onTap: () => openUrl('mailto:${d.email}')),
          IconLink(
              t: t,
              icon: FontAwesomeIcons.whatsapp,
              tooltip: 'WhatsApp',
              onTap: () => openUrl(
                  'https://wa.me/${d.phoneRaw.replaceAll(RegExp(r'[^0-9]'), '')}')),
        ],
      );
}
