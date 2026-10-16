# Islami 🕌

An Islamic mobile app built with Flutter. It brings the Quran, Hadith, Sebha,
live Quran radio, prayer times, and daily Azkar into one app.

## Screenshots

| Quran | Radio | Time |
|-------|-------|------|
| ![Quran](screenshots/quran.png) | ![Radio](screenshots/radio.png) | ![Time](screenshots/time.png) |

## Features

- **Quran:** list of suras with verse counts, sura search, recently read, and sura content
- **Hadith:** list of hadith scriptd
- **Sebha:** digital tasbeeh counter
- **Radio:** stream Quran radios and reciters, with play/pause, volume control, and favourites
- **Prayer times:** daily times for Cairo from a live API, with Gregorian and Hijri dates
  and a live countdown to the next prayer
- **Azkar:** morning, evening, after-prayer, sleep, wake-up, and Quranic duas,
  each with a tap-to-count counter
- Onboarding screens and Arabic locale

## Tech Stack

- Flutter & Dart
- State management: Provider
- Networking: http
- Audio: audioplayers
- Local storage: shared_preferences
- UI: google_fonts, carousel_slider, introduction_screen

## Architecture

```
lib/
├── api_manager/   # API calls (radio, reciters, prayer times)
├── app_styles/    # colors, text styles, theme
├── provider/      # state management (radio, prayer times)
├── quran/ hadeth/ radio/ sebha/ time/ azkar/   # features
```

Each feature keeps its own screens and models. API calls go through `api_manager`,
and `Provider` holds the state the screens listen to.

## APIs & Data

- [MP3Quran API](https://mp3quran.net): radios and reciters
- Azkar: local JSON file in `assets/files/azkar/`

## Getting Started

```bash
git clone https://github.com/mo-omar-dev/islami.git
cd islami
flutter pub get
flutter run
```


## Known Limitations / Future Work

- Adhan sound notifications are not implemented yet
- Prayer times use a fixed city (Cairo); location-based times are planned

## Author

Mohamed Omar
