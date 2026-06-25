class SkillCategory {
  final String title;
  final List<String> skills;
  final String icon;
  SkillCategory({required this.title, required this.skills, required this.icon});
}

final List<SkillCategory> skillCategories = [
  SkillCategory(
    title: 'Mobile Development',
    icon: '📱',
    skills: ['Android (Java/Kotlin)', 'Flutter & Dart', 'Jetpack Compose', 'Android Jetpack'],
  ),
  SkillCategory(
    title: 'Architecture & Patterns',
    icon: '🏛️',
    skills: ['Clean Architecture', 'MVVM', 'Hilt / Dagger (DI)', 'Repository Pattern'],
  ),
  SkillCategory(
    title: 'ML & Computer Vision',
    icon: '🤖',
    skills: ['TensorFlow Lite', 'OpenCV', 'Facial Recognition', 'Anti-Spoofing Systems'],
  ),
  SkillCategory(
    title: 'Networking & Backend',
    icon: '🌐',
    skills: ['REST APIs', 'Retrofit', 'WebSocket', 'Socket.io', 'Firebase'],
  ),
  SkillCategory(
    title: 'Specialized Tech',
    icon: '⚙️',
    skills: ['NFC & Smart Card', 'Auto. Fare Collection', 'Payment Gateway', 'SDK Development'],
  ),
  SkillCategory(
    title: 'DevOps & Tools',
    icon: '🔧',
    skills: ['Git', 'CI/CD Pipelines', 'Android Studio', 'Firebase Crashlytics'],
  ),
  SkillCategory(
    title: 'Data & Storage',
    icon: '🗄️',
    skills: ['Room Database', 'Offline-First Architecture', 'SQLite', 'Shared Preferences'],
  ),
  SkillCategory(
    title: 'Async & Performance',
    icon: '⚡',
    skills: ['Kotlin Coroutines', 'RxJava', 'WorkManager', 'Performance Optimization'],
  ),
];
