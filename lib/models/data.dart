class Experience {
  final String title;
  final String company;
  final String period;
  final String location;
  final List<String> bullets;
  final bool isCurrent;

  const Experience({
    required this.title,
    required this.company,
    required this.period,
    required this.location,
    required this.bullets,
    this.isCurrent = false,
  });
}

class Project {
  final String name;
  final String company;
  final String period;
  final String description;
  final String? playStoreUrl;
  final List<String> tags;
  final bool isFeatured;

  const Project({
    required this.name,
    required this.company,
    required this.period,
    required this.description,
    this.playStoreUrl,
    required this.tags,
    this.isFeatured = false,
  });
}

class SkillCategory {
  final String category;
  final List<String> skills;
  final String icon;

  const SkillCategory({
    required this.category,
    required this.skills,
    required this.icon,
  });
}

// ── DATA ────────────────────────────────────────────────────────────────────

final List<Experience> experiences = [
  Experience(
    title: 'Mobile Application Developer / Android Developer',
    company: 'Punjab Information Technology Board (PITB)',
    period: 'Dec 2021 – Present',
    location: 'Lahore, Pakistan',
    isCurrent: true,
    bullets: [
      'Lead developer on AFC (Automatic Fare Collection) systems for Punjab Mass Transit',
      'Built Saaf Punjab facial recognition attendance with TensorFlow Lite, anti-spoofing & geo-fencing',
      'Developed GRMS — government residences management system used by thousands of officers',
      'Architected offline-first solutions for remote areas with 24-hour local data sync',
      'Integrated NFC, smart card, biometric (IRIS), and payment gateway systems',
      'Maintained CI/CD pipelines using Git, GitHub Actions, and Firebase App Distribution',
    ],
  ),
  Experience(
    title: 'Android Developer',
    company: 'Horizam Tech',
    period: 'Oct 2020 – Dec 2021',
    location: 'Lahore, Pakistan',
    bullets: [
      'Built MetroTap — NFC-based instant contact & social media sharing app (Play Store)',
      'Developed Find New Friends — group-based social matching app with real-time chat',
      'Created service marketplace apps with Firebase, RecyclerViews, and Material Design',
      'Worked across full development lifecycle from architecture to Play Store submission',
    ],
  ),
  Experience(
    title: 'Android Developer',
    company: 'TalkAgent',
    period: 'Feb 2020 – Oct 2020',
    location: 'Lahore, Pakistan',
    bullets: [
      'Built Twidlee Rider — real-time food delivery rider app with live order tracking',
      'Developed Camden Care — healthcare app for lab report access (Play Store)',
      'Explored Google Sheets API integration for dynamic data-driven utility apps',
    ],
  ),
  Experience(
    title: 'Android Developer Intern',
    company: 'Punjab Information Technology Board (PITB)',
    period: 'Nov 2019 – Feb 2020',
    location: 'Lahore, Pakistan',
    bullets: [
      'Independently built QR code generator/scanner app from scratch',
      "Maintained and added features to kids' coloring application",
      'Created Profile Guess — celebrity image-guessing game (Play Store)',
    ],
  ),
];

final List<Project> projects = [
  Project(
    name: 'Punjab Masstransit Authority',
    company: 'Punjab Information Technology Board',
    period: 'Apr 2022 – Present',
    description:
        'Real-time public transport app for Punjab with AFC integration, live arrival/departure tracking, route planning, disruption alerts, and offline-first support. Used daily by hundreds of thousands of commuters.',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=pk.pitb.punjab.masstransit.punjab_masstransit_authority',
    tags: ['AFC', 'MVVM', 'Clean Architecture', 'Offline-First', 'Maps API'],
    isFeatured: true,
  ),
  Project(
    name: 'Saaf Punjab — Facial Attendance',
    company: 'Punjab Information Technology Board',
    period: 'Jan 2023 – Mar 2023',
    description:
        'Enterprise-grade facial recognition attendance system for waste management workers. Features 5-pose registration, TensorFlow Lite anti-spoofing, geo-fenced check-in, shift management, and 24-hour offline mode.',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=pk.pitb.gov.saafpunjabfacial',
    tags: ['TensorFlow Lite', 'OpenCV', 'Facial Recognition', 'Anti-Spoofing', 'Geo-fencing'],
    isFeatured: true,
  ),
  Project(
    name: 'GRMS — Government Residences Management',
    company: 'Punjab Information Technology Board',
    period: 'Jun 2023 – Jul 2023',
    description:
        'Advanced platform for government officers covering allotment, house reservation, resident profiling, and complaint resolution with full transparency and streamlined workflow.',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=pk.pitb.gov.grms',
    tags: ['REST APIs', 'MVVM', 'Firebase', 'Material Design'],
    isFeatured: true,
  ),
  Project(
    name: 'Saaf Punjab IRIS',
    company: 'Punjab Information Technology Board',
    period: 'Mar 2023 – May 2023',
    description:
        'Biometric IRIS-based monitoring platform for Waste Management Companies to evaluate daily attendance of supervisors and field workers.',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=pk.gov.pitb.saafpunjab.iris',
    tags: ['Biometrics', 'IRIS', 'Attendance', 'Government'],
    isFeatured: false,
  ),
  Project(
    name: 'MetroTap',
    company: 'Horizam Tech',
    period: 'May 2021 – Dec 2021',
    description:
        'Innovative NFC-based contact sharing app. Tap your card to instantly share social media profiles, payment links, and websites. Published on Play Store.',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.horizam.MetroTap',
    tags: ['NFC', 'Smart Card', 'Social', 'Firebase'],
    isFeatured: true,
  ),
  Project(
    name: 'Camden Care',
    company: 'TalkAgent',
    period: 'Feb 2020 – Mar 2020',
    description:
        'Healthcare app for Camden Health System (CHS) enabling users to securely access their lab reports on mobile.',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.camdencare.app',
    tags: ['Healthcare', 'REST APIs', 'Secure Storage'],
    isFeatured: false,
  ),
  Project(
    name: 'Auto Silent Application',
    company: 'Personal / Final Year Project',
    period: 'Jul 2018 – Jul 2019',
    description:
        'Automatically switches device ringer to silent mode based on user-defined locations and time schedules. Published on Play Store.',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.asad.fareed',
    tags: ['Geofencing', 'Location', 'Background Services'],
    isFeatured: false,
  ),
];

final List<SkillCategory> skillCategories = [
  SkillCategory(
    category: 'Mobile Development',
    icon: '📱',
    skills: ['Android (Java/Kotlin)', 'Flutter & Dart', 'Jetpack Compose', 'Android Jetpack', 'Android Studio'],
  ),
  SkillCategory(
    category: 'Architecture & Patterns',
    icon: '🏗️',
    skills: ['Clean Architecture', 'MVVM', 'Hilt / Dagger (DI)', 'Repository Pattern', 'SDK Development'],
  ),
  SkillCategory(
    category: 'AI / ML & Computer Vision',
    icon: '🤖',
    skills: ['TensorFlow Lite', 'OpenCV', 'Facial Recognition', 'Anti-Spoofing Systems', 'ML Integration'],
  ),
  SkillCategory(
    category: 'Hardware & Connectivity',
    icon: '📡',
    skills: ['NFC & Smart Card', 'AFC Systems', 'Payment Gateway', 'Biometrics / IRIS', 'WebSocket / Socket.io'],
  ),
  SkillCategory(
    category: 'Backend & Data',
    icon: '🗄️',
    skills: ['REST APIs', 'Retrofit', 'Room Database', 'Offline-First Architecture', 'Firebase Suite'],
  ),
  SkillCategory(
    category: 'DevOps & Tools',
    icon: '⚙️',
    skills: ['Git & GitHub', 'CI/CD Pipelines', 'GitHub Actions', 'Firebase App Distribution', 'Kotlin Coroutines / RxJava'],
  ),
];
