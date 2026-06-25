# Asad Fareed — Portfolio Website

Built with Flutter Web. Deployed at: https://asadfareed777.github.io

## 🚀 Local Development

```bash
# Install Flutter (if not already)
# https://docs.flutter.dev/get-started/install

# Get dependencies
flutter pub get

# Run locally
flutter run -d chrome

# Build for production
flutter build web --release
```

## 📦 Deploy to GitHub Pages (One-time setup)

1. Push this project to: `https://github.com/asadfareed777/asadfareed777.github.io`

2. Go to **Settings → Pages** in your repo

3. Under **Source**, select **GitHub Actions**

4. Push to `main` branch — the workflow auto-deploys!

Your site will be live at: `https://asadfareed777.github.io`

## 📁 Project Structure

```
lib/
├── main.dart              # App entry + scroll navigation
├── utils/
│   ├── app_colors.dart    # Color palette
│   ├── app_theme.dart     # Theme config
│   └── constants.dart     # Your personal info (edit this!)
├── models/
│   ├── skill_model.dart   # Skills data
│   ├── experience_model.dart
│   └── project_model.dart
├── widgets/
│   ├── nav_bar.dart       # Sticky navigation
│   └── section_wrapper.dart # Animated section container
└── sections/
    ├── hero_section.dart
    ├── about_section.dart
    ├── skills_section.dart
    ├── experience_section.dart
    ├── projects_section.dart
    └── contact_section.dart
```

## ✏️ Customization

- **Personal info**: Edit `lib/utils/constants.dart`
- **Skills**: Edit `lib/models/skill_model.dart`
- **Experience**: Edit `lib/models/experience_model.dart`
- **Projects**: Edit `lib/models/project_model.dart`
- **Colors**: Edit `lib/utils/app_colors.dart`
