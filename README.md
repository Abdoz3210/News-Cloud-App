# News Cloud App

![Version](https://img.shields.io/badge/version-v1.0.0-orange) ![License](https://img.shields.io/badge/license-MIT-green) ![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter) ![Dart](https://img.shields.io/badge/Dart-3.x-blue?logo=dart) ![Platform](https://img.shields.io/badge/platform-Android%20%7C%20iOS%20%7C%20Web-lightgrey)

> A cross-platform Flutter news application that fetches real-time top headlines across multiple categories using the NewsAPI, with a clean category-based browsing experience.

---

## Screenshots

<!-- Add your app screenshots here -->
| Home | Category | News Detail |
|------|----------|-------------|
| ![home](./screenshots/home.png) | ![category](./screenshots/category.png) | ![detail](./screenshots/detail.png) |

---

## Features

- 📰 Browse **real-time top headlines** powered by NewsAPI
- 🗂️ Filter news by **7 categories**: Business, Entertainment, General, Health, Science, Sports, and Technology
- 🖼️ Rich **news cards** with article image, title, and description
- 🔄 **Async data fetching** with loading indicators and error handling
- 🎨 Smooth **horizontal category carousel** with cover images
- 📱 Cross-platform support: **Android, iOS, Web, macOS, Linux, Windows**
- ⚡ Powered by **Dio** for fast and reliable HTTP requests

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | [Flutter](https://flutter.dev/) |
| Language | [Dart](https://dart.dev/) |
| HTTP Client | [Dio](https://pub.dev/packages/dio) |
| News Data | [NewsAPI](https://newsapi.org/) |
| UI Icons | Cupertino Icons |
| State Management | `StatefulWidget` + `FutureBuilder` |

---

## Prerequisites

Before getting started, make sure you have the following installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) `>= 3.x`
- [Dart SDK](https://dart.dev/get-dart) `^3.10.8`
- [Android Studio](https://developer.android.com/studio) (for Android development)
- Xcode `>= 15` (for iOS/macOS development — macOS only)
- A free API key from [NewsAPI](https://newsapi.org/register)

---

## Installation

```bash
# 1. Clone the repository
git clone https://github.com/Abdoz3210/News-Cloud-App.git

# 2. Navigate into the project directory
cd News-Cloud-App

# 3. Install dependencies
flutter pub get
```

---

## Running the App

```bash
# Run on a connected device or emulator
flutter run

# Run specifically on Android
flutter run -d android

# Run specifically on iOS (macOS only)
flutter run -d ios

# Run on Web
flutter run -d chrome
```

---

## Environment & API Key

This app uses the [NewsAPI](https://newsapi.org/) to fetch news. The API key is currently hardcoded in the service layer. For production, it is strongly recommended to move it to an environment variable.

**Current location:** `lib/services/getnews.dart`

```dart
final Response response = await dio.get(
  'https://newsapi.org/v2/top-headlines?apiKey=YOUR_API_KEY&category=$category',
);
```

To use your own key, replace `YOUR_API_KEY` with your key from [newsapi.org](https://newsapi.org/register).

For a more secure setup, create a `.env` file at the root:

```env
NEWS_API_KEY=your_newsapi_key_here
```

> ⚠️ Never commit your API key or `.env` file to version control. Add `.env` to your `.gitignore`.

---

## Project Structure

```
News-Cloud-App/
├── lib/
│   ├── Models/
│   │   ├── articales_model.dart       # Article data model
│   │   ├── category_models.dart       # Category data model
│   │   └── category_type_model.dart   # Category type definitions
│   ├── services/
│   │   └── getnews.dart               # NewsAPI integration via Dio
│   ├── views/
│   │   ├── home_views.dart            # Home screen with category + news list
│   │   └── category_views.dart        # Category-filtered news screen
│   ├── widgets/
│   │   ├── categorylist.dart          # Horizontal scrollable category carousel
│   │   ├── herocategotycard.dart      # Individual category card with image
│   │   ├── news_list.dart             # News list sliver widget
│   │   ├── news_list_builder.dart     # FutureBuilder for async news loading
│   │   └── newscard.dart              # Individual news article card
│   └── main.dart                      # App entry point
├── assets/
│   ├── business.png
│   ├── entertaiment.png
│   ├── general.png
│   ├── health.png
│   ├── science.png
│   ├── sports.png
│   └── technology.png
├── android/                           # Android platform files
├── ios/                               # iOS platform files
├── web/                               # Web platform files
├── macos/                             # macOS platform files
├── linux/                             # Linux platform files
├── windows/                           # Windows platform files
├── pubspec.yaml                       # Project dependencies
└── README.md
```

---

## API Reference

The app uses the [NewsAPI Top Headlines](https://newsapi.org/docs/endpoints/top-headlines) endpoint:

```
GET https://newsapi.org/v2/top-headlines?apiKey={KEY}&category={category}
```

**Supported categories:** `business` · `entertainment` · `general` · `health` · `science` · `sports` · `technology`

---

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create your feature branch: `git checkout -b feat/my-feature`
3. Commit your changes: `git commit -m "feat: add my feature"`
4. Push to the branch: `git push origin feat/my-feature`
5. Open a Pull Request

---

## License

This project is licensed under the **MIT** License. See the [LICENSE](./LICENSE) file for details.

---

## Author

**Abdoz3210**
- GitHub: [@Abdoz3210](https://github.com/Abdoz3210)
