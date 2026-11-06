// ───────────────────────────────────────────────────────────────────────────
//  ALL PORTFOLIO CONTENT LIVES HERE.
//  To add a skill / job / project later, edit this file only.
//  Source of truth: cv/Asad_Fareed_CV.pdf
// ───────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

// ── Personal ────────────────────────────────────────────────────────────────
const name = 'Asad Fareed';
const initials = 'AF';
const title = 'Senior Android & Flutter Developer';
const tagline =
    'Building secure, scalable mobile systems for the public sector and transit.';
const email = 'asadfareed047@gmail.com';
const phone = '+92 303 9466175';
const phoneRaw = '+923039466175';
const location = 'Lahore, Punjab, Pakistan';
const githubUrl = 'https://github.com/asadfareed777';
const linkedinUrl = 'https://www.linkedin.com/in/asad-fareed-a9660b193';

/// Shows the green "open to opportunities" pill in the hero.
const openToWork = true;

/// Words typed out under the name in the hero.
const roles = <String>[
  'Senior Android Developer',
  'Flutter Engineer',
  'AFC & NFC Specialist',
  'Facial Recognition & Anti-Spoofing',
];

// ── Stats (all taken from the CV) ───────────────────────────────────────────
class Stat {
  final String value;
  final String label;
  const Stat(this.value, this.label);
}

const stats = <Stat>[
  Stat('6+', 'Years Experience'),
  Stat('3', 'Organisations'),
  Stat('7', 'Play Store Apps'),
  Stat('24h', 'Offline Attendance Mode'),
];

// ── About ───────────────────────────────────────────────────────────────────
const aboutParagraphs = <String>[
  'Senior Mobile Application Developer with 6+ years of experience building '
      'enterprise-grade Android and Flutter applications.',
  'My expertise covers Automatic Fare Collection (AFC), open-loop and '
      'closed-loop payment systems, NFC technologies, EMV contactless payments, '
      'MPGS integration, validator software, facial recognition and '
      'anti-spoofing solutions.',
  'I work with Kotlin, Java and Flutter using Clean Architecture and MVVM, and '
      'I build SDKs, REST integrations and large-scale public sector and '
      'transit applications, focused on reliability, maintainability and user '
      'experience.',
];

class Highlight {
  final IconData icon;
  final String title;
  final String text;
  const Highlight(this.icon, this.title, this.text);
}

const highlights = <Highlight>[
  Highlight(Icons.account_balance_outlined, 'Public Sector Scale',
      'Enterprise apps for Punjab Information Technology Board.'),
  Highlight(Icons.nfc_outlined, 'Transit & Payments',
      'AFC, NFC, EMV contactless, MPGS and validator software.'),
  Highlight(Icons.psychology_outlined, 'ML & Computer Vision',
      'Facial recognition and anti-spoofing with TensorFlow Lite and OpenCV.'),
  Highlight(Icons.cloud_off_outlined, 'Offline-First',
      'Apps that keep working in rural and remote areas.'),
];

// ── Skills ──────────────────────────────────────────────────────────────────
class SkillGroup {
  final IconData icon;
  final String title;
  final List<String> items;
  const SkillGroup(this.icon, this.title, this.items);
}

const skillGroups = <SkillGroup>[
  SkillGroup(Icons.code, 'Languages', ['Kotlin', 'Java', 'Dart']),
  SkillGroup(Icons.phone_android, 'Mobile', [
    'Android',
    'Flutter',
    'Jetpack Compose',
    'Android Jetpack',
    'Android Studio',
  ]),
  SkillGroup(Icons.account_tree_outlined, 'Architecture', [
    'Clean Architecture',
    'MVVM',
    'Hilt / Dagger (DI)',
    'Offline-First Architecture',
    'SDK Development',
  ]),
  SkillGroup(Icons.cloud_outlined, 'Networking & Services', [
    'REST APIs',
    'Retrofit',
    'WebSocket & Real-Time Comms',
    'Socket.io',
    'Firebase',
    'Google Maps',
  ]),
  SkillGroup(Icons.bolt, 'Async & Data', [
    'Kotlin Coroutines',
    'RxJava',
    'Room',
  ]),
  SkillGroup(Icons.psychology_outlined, 'ML & Computer Vision', [
    'TensorFlow Lite',
    'OpenCV',
    'Computer Vision',
    'Facial Recognition',
    'Anti-Spoofing Systems',
    'Machine Learning Integration',
  ]),
  SkillGroup(Icons.payments_outlined, 'Payments & Transit', [
    'Automatic Fare Collection (AFC)',
    'NFC & Smart Card',
    'Payment Gateway Integration',
    'EMV Contactless',
    'MPGS Integration',
    'Open / Closed-Loop Payments',
    'Validator Software',
  ]),
  SkillGroup(Icons.rocket_launch_outlined, 'DevOps', [
    'Git',
    'CI/CD Pipelines',
  ]),
];

// ── Experience ──────────────────────────────────────────────────────────────
class Job {
  final String role;
  final String company;
  final String period;
  final bool current;
  final List<String> points;
  const Job(this.role, this.company, this.period, this.points,
      {this.current = false});
}

const jobs = <Job>[
  Job(
    'Mobile Application Developer / Android Developer',
    'Punjab Information Technology Board, Lahore',
    'Dec 2021 – Present',
    [
      'Lead developer on enterprise-grade public sector applications: AFC systems, facial recognition attendance, waste management monitoring and real-time transit platforms.',
      'Architected offline-first solutions for areas with limited or no connectivity.',
      'Integrated ML models (TensorFlow Lite, OpenCV) for facial recognition and anti-spoofing.',
      'Built NFC and smart card features.',
      'Maintained CI/CD pipelines with Git and Firebase.',
    ],
    current: true,
  ),
  Job(
    'Android Developer',
    'Horizam Tech, Lahore',
    'Oct 2020 – Dec 2021',
    [
      'Developed and published multiple Android apps on the Play Store, including NFC-based contact sharing (MetroTap), social networking (Find New Friends) and service marketplace apps (Nails for u, Get Teacher).',
      'Worked with Firebase, Fragments, RecyclerViews and Material Design.',
    ],
  ),
  Job(
    'Android Developer',
    'TalkAgent, Lahore',
    'Feb 2020 – Oct 2020',
    [
      'Built a food delivery rider app (Twidlee Rider), a healthcare lab report app (Camden Care) and a Google Sheets API-driven utility.',
      'Gained experience with RESTful APIs, real-time order tracking and Play Store deployment.',
    ],
  ),
  Job(
    'Android Developer Intern',
    'Punjab Information Technology Board, Lahore',
    'Nov 2019 – Feb 2020',
    [
      'Independently developed a QR code generation/scanning app, a children\'s coloring app and a celebrity image-guessing game.',
      'Gained foundational experience with Android Studio, Git and app deployment.',
    ],
  ),
];

// ── Projects ────────────────────────────────────────────────────────────────
class Project {
  final String title;
  final String org;
  final String period;
  final bool featured;
  final String overview;
  final List<String> features;
  final List<String> tags;
  final String? playStore;
  const Project({
    required this.title,
    required this.org,
    required this.period,
    required this.overview,
    required this.features,
    required this.tags,
    this.featured = false,
    this.playStore,
  });
}

const projects = <Project>[
  Project(
    title: 'Punjab Masstransit Authority',
    org: 'Punjab Information Technology Board',
    period: 'Apr 2022 – Present',
    featured: true,
    overview:
        'Real-time public transport information app for Punjab (Transit Punjab).',
    features: [
      'Live arrival and departure updates',
      'AFC integration',
      'Network maps and journey planning',
      'Disruption alerts and schedule changes',
      'Offline-first support',
    ],
    tags: ['AFC', 'MVVM', 'Clean Architecture', 'Offline-First'],
    playStore:
        'https://play.google.com/store/apps/details?id=pk.pitb.punjab.masstransit.punjab_masstransit_authority',
  ),
  Project(
    title: 'Saaf Punjab — Facial Attendance',
    org: 'Punjab Information Technology Board',
    period: 'Jan 2023 – Mar 2023',
    featured: true,
    overview:
        'Enterprise facial recognition attendance system for field workers.',
    features: [
      'Five-pose worker registration',
      'Anti-spoofing using TensorFlow Lite and OpenCV',
      'Geo-fenced check-in within the assigned location',
      'Attendance only within the assigned shift time',
      '24-hour offline attendance for rural and remote areas',
    ],
    tags: ['TensorFlow Lite', 'OpenCV', 'Facial Recognition', 'Anti-Spoofing'],
    playStore:
        'https://play.google.com/store/apps/details?id=pk.pitb.gov.saafpunjabfacial',
  ),
  Project(
    title: 'GRMS',
    org: 'Punjab Information Technology Board',
    period: 'Jun 2023 – Jul 2023',
    featured: true,
    overview:
        'Government Residences Management System for government officers and officials.',
    features: [
      'Registration for allotment',
      'House reservation',
      'Resident profiling',
      'Complaint resolution',
      'Single-click access to essential services',
    ],
    tags: ['Public Sector', 'Android'],
    playStore: 'https://play.google.com/store/apps/details?id=pk.pitb.gov.grms',
  ),
  Project(
    title: 'Saaf Punjab IRIS',
    org: 'Punjab Information Technology Board',
    period: 'Mar 2023 – May 2023',
    overview:
        'Biometric monitoring platform for Waste Management Companies.',
    features: [
      'IRIS-based identification',
      'Daily attendance evaluation of supervisors and field workers',
    ],
    tags: ['Biometrics', 'IRIS', 'Public Sector'],
    playStore:
        'https://play.google.com/store/apps/details?id=pk.gov.pitb.saafpunjab.iris',
  ),
  Project(
    title: 'MetroTap',
    org: 'Horizam Tech',
    period: 'May 2021 – Dec 2021',
    overview:
        'Instant, NFC-based way to share contact information with a tap.',
    features: [
      'Tap an NFC card to share social profiles, websites and payment links',
      'Published on the Google Play Store',
    ],
    tags: ['NFC', 'Smart Card', 'Android Studio'],
    playStore:
        'https://play.google.com/store/apps/details?id=com.horizam.MetroTap',
  ),
  Project(
    title: 'Camden Care',
    org: 'TalkAgent',
    period: 'Feb 2020 – Mar 2020',
    overview:
        'Mobile app for Camden Health System to access lab reports securely.',
    features: [
      'Secure access to lab reports',
      'Published on the Google Play Store',
    ],
    tags: ['Healthcare', 'Android'],
    playStore:
        'https://play.google.com/store/apps/details?id=com.camdencare.app',
  ),
  Project(
    title: 'Auto Silent Application',
    org: 'Final Year Project',
    period: 'Jul 2018 – Jul 2019',
    overview:
        'Switches the device ringer to silent mode automatically.',
    features: [
      'Based on user-defined locations',
      'Based on user-defined time schedules',
    ],
    tags: ['Android', 'Location Services'],
    playStore: 'https://play.google.com/store/apps/details?id=com.asad.fareed',
  ),
];

// ── Education ───────────────────────────────────────────────────────────────
class Edu {
  final String degree;
  final String school;
  final String year;
  final String? note;
  const Edu(this.degree, this.school, this.year, {this.note});
}

const education = <Edu>[
  Edu('Bachelor of Sciences in Computer Science',
      'COMSATS Institute of Information Technology, Vehari', '2019',
      note: 'GPA 3.6'),
  Edu('FSC', 'Government Post Graduate College, Burewala', '2015'),
  Edu('Matriculation', 'Quaid Public School, Burewala', '2013'),
];

const certifications = <String>['Computer System Engineering (2013)'];
const awards = <String>['Best Cultural Representative (2016)'];
