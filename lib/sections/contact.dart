import 'package:flutter/material.dart';

import '../data.dart' as d;
import '../theme.dart';
import '../widgets/common.dart';

class ContactSection extends StatelessWidget {
  final AppTheme t;
  const ContactSection({super.key, required this.t});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Section(
        t: t,
        alt: true,
        title: 'Get In Touch',
        subtitle: 'Open to senior roles, consulting and freelance projects',
        child: LayoutBuilder(builder: (context, c) {
          final wide = c.maxWidth >= 900;
          final info = Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            _Tile(t: t, icon: Icons.mail_outline, label: 'Email', value: d.email,
                onTap: () => openUrl('mailto:${d.email}')),
            _Tile(t: t, icon: Icons.phone_outlined, label: 'Phone', value: d.phone,
                onTap: () => openUrl('tel:${d.phoneRaw}')),
            _Tile(t: t, icon: Icons.work_outline, label: 'LinkedIn',
                value: 'asad-fareed', onTap: () => openUrl(d.linkedinUrl)),
            _Tile(t: t, icon: Icons.code, label: 'GitHub',
                value: 'asadfareed777', onTap: () => openUrl(d.githubUrl)),
            _Tile(t: t, icon: Icons.location_on_outlined, label: 'Location',
                value: d.location),
          ]);
          final form = _ContactForm(t: t);
          return wide
              ? EqualGrid(columns: 2, spacing: 32, weights: const [4, 6], children: [
                  Reveal(child: info),
                  Reveal(delayMs: 120, child: form),
                ])
              : Column(children: [
                  Reveal(child: info),
                  const SizedBox(height: 24),
                  Reveal(child: form),
                ]);
        }),
      ),
      _Footer(t: t),
    ]);
  }
}

class _Tile extends StatelessWidget {
  final AppTheme t;
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;
  const _Tile({
    required this.t,
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: HoverBox(
          t: t,
          onTap: onTap,
          padding: const EdgeInsets.all(16),
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
                    Text(value, style: t.font(14, weight: FontWeight.w600)),
                  ]),
            ),
          ]),
        ),
      );
}

class _ContactForm extends StatefulWidget {
  final AppTheme t;
  const _ContactForm({required this.t});

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _name = TextEditingController();
  final _from = TextEditingController();
  final _msg = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _from.dispose();
    _msg.dispose();
    super.dispose();
  }

  // Opens the visitor's mail app with everything pre-filled (no backend needed).
  void _send() {
    final subject = Uri.encodeComponent('Portfolio enquiry from ${_name.text}');
    final body = Uri.encodeComponent(
        '${_msg.text}\n\n— ${_name.text} (${_from.text})');
    openUrl('mailto:${d.email}?subject=$subject&body=$body');
  }

  InputDecoration _dec(String hint) {
    final t = widget.t;
    OutlineInputBorder b(Color c) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: c),
        );
    return InputDecoration(
      hintText: hint,
      hintStyle: t.font(14, color: t.textSoft),
      filled: true,
      fillColor: t.bg,
      contentPadding: const EdgeInsets.all(16),
      enabledBorder: b(t.border),
      focusedBorder: b(t.accent),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.t;
    return HoverBox(
      t: t,
      padding: const EdgeInsets.all(26),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Let's work together", style: t.font(22, weight: FontWeight.w800)),
        const SizedBox(height: 20),
        TextField(controller: _name, style: t.font(14), decoration: _dec('Your Name')),
        const SizedBox(height: 14),
        TextField(
            controller: _from,
            keyboardType: TextInputType.emailAddress,
            style: t.font(14),
            decoration: _dec('Your Email')),
        const SizedBox(height: 14),
        TextField(
            controller: _msg,
            minLines: 5,
            maxLines: 8,
            style: t.font(14),
            decoration: _dec('Your Message')),
        const SizedBox(height: 20),
        Btn(
            t: t,
            filled: true,
            label: 'Send Message',
            icon: Icons.send_outlined,
            onTap: _send),
      ]),
    );
  }
}

class _Footer extends StatelessWidget {
  final AppTheme t;
  const _Footer({required this.t});

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        color: t.bg,
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
        child: Column(children: [
          Text('© ${DateTime.now().year} ${d.name} · ${d.title}',
              textAlign: TextAlign.center,
              style: t.font(13, color: t.textSoft)),
          const SizedBox(height: 14),
          SocialRow(t: t, align: MainAxisAlignment.center),
          const SizedBox(height: 14),
          Text('Built with Flutter Web',
              style: t.font(12, color: t.textSoft.withOpacity(0.7))),
        ]),
      );
}
