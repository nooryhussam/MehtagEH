# Mehtag-EH

A humanitarian aid and donation-matching mobile application that connects donors with people in need, built as a graduation project for EELU.

## Overview

Mehtag-EH bridges the gap between those willing to donate (food, clothing, medicine) and individuals or families requesting assistance. The platform uses a recommendation system to match donors with relevant requests based on type, location, and need, then guides both parties through a transparent tracking process from initial match to delivery confirmation.

## Features

### For Donors
- Register a donation (type, quantity, availability, location)
- Receive matched recommendations based on donation details
- View detailed request information before committing
- Confirm assistance and track the donation through each stage
- View history of confirmed donations

### For Requesters (Needy)
- Submit a request for assistance with category, description, and personal details
- Optional prescription image upload with text extraction for medical requests
- Track request status through admin review, matching, and delivery stages
- View past and current requests

### Shared
- Arabic-first UI with full RTL layout support
- Real-time status tracking with visual timelines
- Priority-based request classification (عاجل / متوسط / منخفض)

## Tech Stack

- **Framework:** Flutter
- **State Management:** flutter_bloc (Cubit pattern)
- **Networking:** Dio with a repository pattern (`Either<String, Model>` error handling via dartz)
- **UI:**
  - `flutter_screenutil` for responsive sizing
  - `google_fonts` (Tajawal) for Arabic typography
  - `flutter_lucide` / `iconamoon` for icons
  - `smooth_page_indicator` for banner carousels
- **Backend:** REST API hosted on Railway

## Architecture

The project follows a feature-based structure separating Donor and Requester flows:

```
lib/
├── core/
│   ├── networking/        # Dio client, API constants
│   ├── presentation/       # Shared screens (splash, onboarding, login)
│   └── routing/             # Centralized route generation
├── features/
│   ├── Donor/
│   │   ├── data/
│   │   │   ├── model/        # DonationModel, RecommendedRequest, DonorModel
│   │   │   └── repo/          # DonorApi
│   │   └── representation/
│   │       ├── cubit/          # DonorCubit, DonorState
│   │       └── screens/        # Matching, request info, tracking, services
│   └── Requester/
│       ├── data/model/        # OrderModel
│       └── representation/
│           ├── cubit/
│           └── screens/
└── widgets/                    # Shared reusable widgets (cards, buttons, dialogs)
```

## Core Donor Flow

```
DonorOrder (submit donation)
   → API returns recommended_requests
   → MatchingScreen (list of matches)
   → ReqInfo (request detail)
   → OrderConfirmation (dialog)
   → OrderTrackingDonorScreen (live status)
```

Confirmed donations are tracked locally in `DonorCubit.confirmedDonations` and surfaced in the Help/Donations tab, separate from the full list of recommendations shown during matching.

## API Integration Notes

- `POST /api/donations/add` — submits a donation and returns matched requests in the same response (`recommended_requests`)
- `GET /api/requests/needy/:needyId` — fetches a requester's submitted requests
- Models map directly to backend field names (`request_type`, `predicted_score`, `matching_with_donor`, etc.) via `fromMap`/`fromJson` factories
- Status timelines on tracking screens are derived from boolean/string flags returned by the API (`donor_contacted_needy`, `donor_sent_donation`, `needy_confirmed_receipt`) rather than hardcoded UI state

## Installation

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.x or later)
- [Dart SDK](https://dart.dev/get-dart) (bundled with Flutter)
- Android Studio or Xcode (for emulator/simulator), or a physical device
- Git

Verify your setup:

```bash
flutter doctor
```

Resolve any issues flagged before continuing.

### 1. Clone the repository

```bash
git clone https://github.com/<your-username>/Mehtag-EH.git
cd Mehtag-EH
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Configure the backend endpoint

The app talks to a hosted API. Confirm the base URL in `lib/core/networking/api_constants.dart` matches your backend deployment:

```dart
static const String baseUrl = 'https://mehtag-eh-production.up.railway.app';
```

Update this if you're running against a local or staging backend instead.

### 4. Run the app

Connect a device or start an emulator/simulator, then:

```bash
flutter run
```

To target a specific device when multiple are connected:

```bash
flutter devices
flutter run -d <device_id>
```

### 5. Build a release APK (Android)

```bash
flutter build apk --release
```

The output APK will be at `build/app/outputs/flutter-apk/app-release.apk`.

> **Known issue:** if the build fails with `resource drawable/splash not found`, make sure a `splash.png` asset exists under both `android/app/src/main/res/drawable/` and `android/app/src/main/res/drawable-v21/`, or simplify `launch_background.xml` to reference a solid color instead of a missing drawable.

### 6. Build for iOS

```bash
flutter build ios --release
```

Requires a Mac with Xcode installed and a valid signing configuration in `ios/Runner.xcworkspace`.

### Troubleshooting

- **Gradle/Kotlin daemon errors on Windows:** stop any running Gradle daemons (`./gradlew --stop` from `android/`) and retry the build.
- **Pub get fails:** confirm your Flutter/Dart SDK versions match what's declared in `pubspec.yaml`.
- **Fonts/icons missing after release build:** this is expected — Flutter tree-shakes unused icon glyphs in release mode; functionality is unaffected.


## Status

Active development as part of an academic graduation project. Core donor matching and tracking flows are functional; requester-side tracking and admin features follow the same patterns.

## License

This project is developed for academic purposes as part of an EELU graduation requirement.
