# Asad Fareed — Portfolio (Flutter Web)

Live: https://asadfareed777.github.io

## Folder layout

| Path | What it is |
|---|---|
| `lib/data.dart` | **All content** (skills, jobs, projects, education, contact). Edit this to update the site. |
| `lib/sections/` | One file per page section (hero, about, skills, experience, projects, education, contact). |
| `lib/theme.dart` | Dark/light mode + 8 accent palettes. |
| `cv/Asad_Fareed_CV.pdf` | Current CV (master copy). |
| `web/Asad_Fareed_CV.pdf` | Copy of the CV served by the site's Resume / Download CV buttons. |
| `assets/images/profile.jpg` | Optional profile photo. Drop it in; until then the hero shows "AF" initials. |

## Run locally

```bash
flutter pub get
flutter run -d chrome
```

## Deploy (GitHub Pages, user site)

1. Push this folder to `https://github.com/asadfareed777/asadfareed777.github.io` (branch `main`).
2. Repo → Settings → Pages → Source: **GitHub Actions**.
3. Every push to `main` builds and publishes automatically (`.github/workflows/deploy.yml`).

## Updating the CV later

Replace **both** `cv/Asad_Fareed_CV.pdf` and `web/Asad_Fareed_CV.pdf`, then update the matching content in `lib/data.dart`.
