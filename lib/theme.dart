import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Palette {
  final String name;
  final Color color;
  final Color light;
  const Palette(this.name, this.color, this.light);
}

const palettes = <Palette>[
  Palette('Electric Blue', Color(0xFF00B4FF), Color(0xFF66D4FF)),
  Palette('Neon Purple', Color(0xFFB347FF), Color(0xFFCE85FF)),
  Palette('Emerald Green', Color(0xFF00E58A), Color(0xFF66FFBC)),
  Palette('Sunset Orange', Color(0xFFFF6B35), Color(0xFFFF9B71)),
  Palette('Hot Pink', Color(0xFFFF1493), Color(0xFFFF6BB8)),
  Palette('Cyber Teal', Color(0xFF00D9C5), Color(0xFF66FFEF)),
  Palette('Crimson Red', Color(0xFFFF2D55), Color(0xFFFF6B85)),
  Palette('Golden Amber', Color(0xFFFFB300), Color(0xFFFFCC55)),
];

class AppTheme {
  final bool dark;
  final Palette palette;
  const AppTheme(this.dark, this.palette);

  Color get bg => dark ? const Color(0xFF0B1220) : const Color(0xFFF5F5FA);
  Color get surface => dark ? const Color(0xFF0F182B) : const Color(0xFFEDEDF5);
  Color get card => dark ? const Color(0xFF142039) : Colors.white;
  Color get cardHover =>
      dark ? const Color(0xFF1B2A4A) : const Color(0xFFF0F0FA);
  Color get border => dark ? const Color(0xFF263653) : const Color(0xFFDADAEA);
  Color get text => dark ? const Color(0xFFEAF0FF) : const Color(0xFF111122);
  Color get textSoft =>
      dark ? const Color(0xFF9CAAC8) : const Color(0xFF55556E);

  Color get accent => palette.color;
  Color get accentLight => palette.light;
  // Accent colour that stays readable as text on the current background.
  Color get accentText =>
      dark ? palette.light : Color.lerp(palette.color, Colors.black, 0.4)!;
  Color get accentSoft => palette.color.withOpacity(dark ? 0.14 : 0.12);
  Color get onAccent => Colors.black87;

  TextStyle font(
    double size, {
    FontWeight weight = FontWeight.w400,
    Color? color,
    double? height,
    double? spacing,
  }) =>
      GoogleFonts.spaceGrotesk(
        fontSize: size,
        fontWeight: weight,
        color: color ?? text,
        height: height,
        letterSpacing: spacing,
      );

  ThemeData get material => ThemeData(
        useMaterial3: true,
        brightness: dark ? Brightness.dark : Brightness.light,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: accent,
          brightness: dark ? Brightness.dark : Brightness.light,
        ),
      );
}
