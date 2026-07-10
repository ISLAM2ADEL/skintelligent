# Skintelligent

Skintelligent is a Flutter mobile application for patients to find dermatology doctors, manage appointments, message clinicians, submit reviews, and maintain a patient profile.

> **Project status:** This repository is an application client. It requires the Skintelligent backend API to be running and reachable for authentication, doctor data, bookings, chat, and profile features.

## Features

- Account registration, email confirmation, sign-in, and password reset
- Onboarding and persisted session handling
- Doctor discovery, profiles, availability, and reviews
- Appointment booking, viewing, and cancellation
- Appointment chat and image upload
- Patient profile viewing and updates, including profile photos
- Camera, gallery, and scanner UI integrations

## Tech stack

| Area | Implementation |
| --- | --- |
| Framework | Flutter and Dart |
| State management | `flutter_bloc` Cubits |
| Navigation | GetX named routes |
| Networking | Dio with a bearer-token interceptor |
| Local persistence | `shared_preferences` via `CacheHelper` |
| Dependency injection | `get_it` |
| Media | `image_picker`, `camera`, and `mobile_scanner` |

## Prerequisites

- A Flutter SDK compatible with Dart `^3.5.3` (see `environment.sdk` in [pubspec.yaml](pubspec.yaml))
- Android Studio and/or Xcode, depending on the target device
- A running Skintelligent API instance, or access to the configured development API
- A physical device is recommended for camera, gallery, and permission-related flows

Verify your local setup:

```bash
flutter doctor
flutter --version
```

## Getting started

1. Clone the repository and open its root directory.
2. Install packages:

   ```bash
   flutter pub get
   ```

3. Configure the backend URL as described in [Backend configuration](#backend-configuration).
4. Run static analysis:

   ```bash
   flutter analyze
   ```

5. List available devices and launch the app:

   ```bash
   flutter devices
   flutter run
   ```

To build a release artifact after validating the app:

```bash
flutter build appbundle
# or
flutter build ipa
```

## Backend configuration

The API base URL is currently defined directly in [`lib/controllers/api/endpoint.dart`](lib/controllers/api/endpoint.dart):

```dart
static String baseUrl = "http://skintelligent.runasp.net";
```

Update this value for your environment before running the app. Some multipart-upload requests also contain direct URLs in [`lib/controllers/repositories/user_repository.dart`](lib/controllers/repositories/user_repository.dart) and [`lib/screens/appointment/uploading_screen.dart`](lib/screens/appointment/uploading_screen.dart); keep them aligned with the selected API host.

For production, use HTTPS and move environment-specific URLs out of source code (for example, through `--dart-define` and a configuration class). Do not commit API keys, credentials, or production secrets to the repository.

## Platform permissions and release notes

- Android currently enables cleartext HTTP traffic in [`android/app/src/main/AndroidManifest.xml`](android/app/src/main/AndroidManifest.xml) to support the configured HTTP API. Remove this exception and use HTTPS before release.
- The app uses camera and photo-selection packages. Confirm that the Android manifest and iOS `Info.plist` contain the required camera/photo-library permission declarations for every feature you ship, with clear user-facing rationale text on iOS.
- Test authentication, uploads, bookings, and chat against the target backend environment before distributing builds.

## Project structure

```text
lib/
|-- main.dart                    # App bootstrap, route registration, providers
|-- controllers/                 # API client, cache, errors, repositories
|-- cubit/                       # Feature state and business logic
|-- models/                      # API response/request models
|-- screens/                     # Feature screens and user flows
|-- widgets/                     # Reusable UI components
|-- services/                    # Service locator setup
|-- styles/                      # Colors, constants, and styling helpers
`-- utiles/                      # Shared helper functions
assets/images/                   # Image assets registered in pubspec.yaml
```

## Development workflow

Before opening a pull request, run:

```bash
dart format lib
flutter analyze
```

At the time of writing, the repository does not include a `test/` directory. Add focused unit tests for Cubits, repositories, and API parsing as features are changed. Use widget tests for important user journeys such as authentication and booking, then run `flutter test`.

## Useful commands

```bash
# Fetch/update packages
flutter pub get

# Run on a selected device
flutter run -d <device-id>

# Analyze and test
flutter analyze
flutter test

# Create Android release artifacts
flutter build apk --release
flutter build appbundle
```

## Contributing

1. Create a focused branch for your change.
2. Keep UI, state, and API changes scoped to the relevant feature.
3. Format and analyze the code before committing.
4. Add or update tests when behavior changes.
5. Describe backend contract changes and test coverage in the pull request.

## License

No license is currently specified. Add a license file before distributing or accepting external contributions.
