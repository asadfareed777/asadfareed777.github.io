class Project {
  final String title;
  final String organization;
  final String period;
  final String description;
  final List<String> tags;
  final String? playStoreUrl;
  final bool featured;
  Project({
    required this.title, required this.organization, required this.period,
    required this.description, required this.tags,
    this.playStoreUrl, this.featured = false,
  });
}

final List<Project> projects = [
  Project(
    title: 'Punjab Masstransit Authority',
    organization: 'Punjab Information Technology Board',
    period: 'Apr 2022 – Present',
    description: 'Real-time public transport app for Punjab with AFC integration, live arrival/departure tracking, offline-first architecture, and journey planning for bus & metro networks.',
    tags: ['AFC', 'Kotlin', 'MVVM', 'Clean Architecture', 'Offline-First', 'Real-Time'],
    playStoreUrl: 'https://play.google.com/store/apps/details?id=pk.pitb.punjab.masstransit.punjab_masstransit_authority',
    featured: true,
  ),
  Project(
    title: 'Saaf Punjab — Facial Attendance',
    organization: 'Punjab Information Technology Board',
    period: 'Jan 2023 – Mar 2023',
    description: 'Enterprise facial recognition attendance system with five-pose worker registration, anti-spoofing (TensorFlow Lite + OpenCV), geo-fenced check-in, shift management, and 24-hour offline mode.',
    tags: ['TensorFlow Lite', 'OpenCV', 'Facial Recognition', 'Anti-Spoofing', 'Geo-Fencing'],
    playStoreUrl: 'https://play.google.com/store/apps/details?id=pk.pitb.gov.saafpunjabfacial',
    featured: true,
  ),
  Project(
    title: 'GRMS',
    organization: 'Punjab Information Technology Board',
    period: 'Jun 2023 – Jul 2023',
    description: 'Government Residences Management System streamlining allotment, house reservation, resident profiling, and complaint resolution for government officers.',
    tags: ['Kotlin', 'REST APIs', 'Firebase', 'MVVM'],
    playStoreUrl: 'https://play.google.com/store/apps/details?id=pk.pitb.gov.grms',
    featured: true,
  ),
  Project(
    title: 'Saaf Punjab IRIS',
    organization: 'Punjab Information Technology Board',
    period: 'Mar 2023 – May 2023',
    description: 'Biometric IRIS-based monitoring platform for Waste Management Companies to evaluate daily attendance of supervisors and field workers.',
    tags: ['Biometrics', 'IRIS', 'Kotlin', 'REST APIs'],
    playStoreUrl: 'https://play.google.com/store/apps/details?id=pk.gov.pitb.saafpunjab.iris',
  ),
  Project(
    title: 'MetroTap',
    organization: 'Horizam Tech',
    period: 'May 2021 – Dec 2021',
    description: 'NFC-based instant contact & social media sharing app. Tap a smart card to instantly share profiles, payment links, and social handles.',
    tags: ['NFC', 'Smart Card', 'Android', 'Material Design'],
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.horizam.MetroTap',
  ),
  Project(
    title: 'Camden Care',
    organization: 'TalkAgent',
    period: 'Feb 2020 – Mar 2020',
    description: 'Mobile app for Camden Health System allowing patients to securely access their lab reports and health records.',
    tags: ['Healthcare', 'Android', 'REST APIs', 'Security'],
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.camdencare.app',
  ),
  Project(
    title: 'Auto Silent Application',
    organization: 'Personal / Final Year Project',
    period: 'Jul 2018 – Jul 2019',
    description: 'Auto-switches device ringer to silent mode based on user-defined locations and time schedules using geofencing and alarm management.',
    tags: ['Geofencing', 'Android', 'Location Services', 'Background Services'],
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.asad.fareed',
  ),
];
