import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import '../utils/constants.dart';
import '../widgets/section_wrapper.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return SectionWrapper(
      sectionKey: 'about',
      title: 'About Me',
      subtitle: 'Passionate about building mobile solutions that matter',
      child: isMobile
          ? _buildContent(context, isMobile)
          : _buildContent(context, isMobile),
    );
  }

  Widget _buildContent(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isMobile) ...[
          _buildTextBlock(),
          const SizedBox(height: 32),
          _buildInfoCards(),
        ] else ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: _buildTextBlock()),
              const SizedBox(width: 48),
              Expanded(flex: 2, child: _buildInfoCards()),
            ],
          ),
        ],
        const SizedBox(height: 40),
        _buildHighlights(),
      ],
    );
  }

  Widget _buildTextBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppConstants.about,
          style: GoogleFonts.inter(
            fontSize: 15, color: AppColors.textSecondary,
            height: 1.8, fontWeight: FontWeight.w400,
          )),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Education', style: GoogleFonts.inter(
                fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.white)),
              const SizedBox(height: 12),
              _eduRow('COMSATS University, Vehari',
                  'BS Computer Science (2019) · GPA 3.6'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _eduRow(String inst, String detail) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(inst, style: GoogleFonts.inter(
        fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
      Text(detail, style: GoogleFonts.inter(
        fontSize: 12, color: AppColors.textSecondary)),
    ]),
  );

  Widget _buildInfoCards() {
    final items = [
      ['📧', 'Email', AppConstants.email],
      ['📞', 'Phone', AppConstants.phone],
      ['📍', 'Location', AppConstants.location],
      ['🌐', 'Languages', 'Urdu · English · Punjabi'],
    ];
    return Column(
      children: items.map((item) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(children: [
          Text(item[0], style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item[1], style: GoogleFonts.inter(
                fontSize: 11, color: AppColors.textSecondary,
                fontWeight: FontWeight.w500)),
              Text(item[2], style: GoogleFonts.inter(
                fontSize: 13, color: AppColors.textPrimary,
                fontWeight: FontWeight.w600)),
            ],
          )),
        ]),
      )).toList(),
    );
  }

  Widget _buildHighlights() {
    final items = [
      ['🏛️', 'Public Sector', 'Enterprise apps for Punjab Government serving millions'],
      ['🤖', 'ML & AI', 'TensorFlow Lite · OpenCV · Facial Recognition · Anti-Spoofing'],
      ['📡', 'Offline-First', '24h offline operation for rural & remote areas'],
      ['🔒', 'Security-Focused', 'Geo-fencing, biometrics, smart card, anti-spoofing'],
    ];
    return Wrap(
      spacing: 16, runSpacing: 16,
      children: items.map((item) => Container(
        width: 220,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
          gradient: const LinearGradient(
            begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [AppColors.cardBg, Color(0xFF0F2040)],
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(item[0], style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 10),
          Text(item[1], style: GoogleFonts.inter(
            fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.white)),
          const SizedBox(height: 6),
          Text(item[2], style: GoogleFonts.inter(
            fontSize: 12, color: AppColors.textSecondary, height: 1.5)),
        ]),
      )).toList(),
    );
  }
}
