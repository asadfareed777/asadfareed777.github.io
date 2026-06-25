class Experience {
  final String role;
  final String company;
  final String location;
  final String period;
  final bool isCurrent;
  final List<String> highlights;
  Experience({
    required this.role, required this.company, required this.location,
    required this.period, required this.highlights, this.isCurrent = false,
  });
}

final List<Experience> experiences = [
  Experience(
    role: 'Mobile Application Developer / Android Developer',
    company: 'Punjab Information Technology Board',
    location: 'Lahore, Pakistan',
    period: 'Dec 2021 – Present',
    isCurrent: true,
    highlights: [
      'Lead developer on enterprise-grade public sector apps serving hundreds of thousands of users across Punjab',
      'Built AFC (Automatic Fare Collection) systems for Punjab Mass Transit Authority',
      'Architected facial recognition attendance system using TensorFlow Lite & OpenCV with anti-spoofing',
      'Designed offline-first architecture supporting 24h operation in rural/remote areas',
      'Implemented NFC & smart card integrations for biometric access control',
      'Maintained CI/CD pipelines using Git and Firebase for continuous delivery',
    ],
  ),
  Experience(
    role: 'Android Developer',
    company: 'Horizam Tech',
    location: 'Lahore, Pakistan',
    period: 'Oct 2020 – Dec 2021',
    highlights: [
      'Developed MetroTap — an NFC-based instant contact & social media sharing app (Play Store)',
      'Built Find New Friends social networking app with real-time group chat using Firebase',
      'Developed service marketplace apps (Nails for U, Get Teacher) published on Play Store',
      'Worked with Fragments, RecyclerViews, Material Design, and external SDK integrations',
    ],
  ),
  Experience(
    role: 'Android Developer',
    company: 'TalkAgent',
    location: 'Lahore, Pakistan',
    period: 'Feb 2020 – Oct 2020',
    highlights: [
      'Built Twidlee Rider — a real-time food delivery tracking app for riders',
      'Developed Camden Care — healthcare app for Camden Health System (Play Store)',
      'Integrated Google Sheets API for dynamic content delivery in Words App',
      'Gained expertise in RESTful APIs, real-time tracking, and Play Store deployment',
    ],
  ),
  Experience(
    role: 'Android Developer Intern',
    company: 'Punjab Information Technology Board',
    location: 'Lahore, Pakistan',
    period: 'Nov 2019 – Feb 2020',
    highlights: [
      'Independently developed QR code generation/scanning application',
      'Built and maintained a children\'s coloring app with custom drawing tools',
      'Created Profile Guess — a celebrity image-guessing game (Play Store)',
      'Gained foundational experience with Android Studio, Git, and app deployment',
    ],
  ),
];
