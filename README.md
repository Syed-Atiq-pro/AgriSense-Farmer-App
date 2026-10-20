# agrisense_own

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Added in this update

- Farmer / Dealer role selection on the login screen.
- Login and create-account form UI with input checks.
- Farmer navigation includes crop management and Crop Photo.
- Crop Photo supports taking a picture with the device camera or selecting an image from the gallery, with an in-app preview.
- A logout button returns to role selection.

## Important limitations

This ZIP is a UI update. Authentication is currently demo-only: the form does not verify accounts and does not create secure sessions. Crop photos are selected and previewed locally; they are **not uploaded to cloud storage**, and AI disease analysis is not connected. Before production, connect authentication (for example Supabase Auth), storage (for example Supabase Storage), and a real crop-disease model/API. Do not use demo login for real user data.

## Run

1. Install Flutter SDK.
2. From this folder run `flutter pub get`.
3. Run `flutter run` for a connected device, or `flutter run -d chrome` for web.
