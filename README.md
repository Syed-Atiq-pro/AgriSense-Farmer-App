# Agrisense

A Flutter-based smart farming companion for farmers and dealers.

## Features

- Farmer / Dealer role selection on the login screen.
- Login and create-account form UI with input checks.
- Farmer navigation includes crop management and Crop Photo.
- Crop Photo supports taking a picture with the device camera or selecting an image from the gallery, with an in-app preview.
- A logout button returns to role selection.

## Current limitations

Authentication is currently demo-only: the form does not verify accounts or create secure sessions. Crop photos are selected and previewed locally; they are not uploaded to cloud storage, and AI disease analysis is not connected. Before production use, connect authentication (for example Supabase Auth), storage (for example Supabase Storage), and a real crop-disease model/API. Do not use demo login for real user data.

## Run

1. Install the Flutter SDK.
2. Run `flutter pub get` from the project folder.
3. Run `flutter run` for a connected device, or `flutter run -d chrome` for web.
4. Build the Android APK with `flutter build apk --release`. The output is `build/app/outputs/flutter-apk/app-release.apk`.
