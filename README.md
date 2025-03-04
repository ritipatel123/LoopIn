# LoopIn

A Flutter application with Firebase Authentication.

## Features

- User authentication (Sign In, Sign Up, Sign Out)
- Email and password validation
- Persistent login state

## Firebase Setup

To use Firebase Authentication in this app, follow these steps:

1. **Create a Firebase project:**
   - Go to the [Firebase Console](https://console.firebase.google.com/)
   - Click "Add project" and follow the setup wizard

2. **Register your Flutter app with Firebase:**
   - In your project overview, click the Flutter icon to add a Flutter app
   - Register the app with your package name (found in `android/app/build.gradle` as `applicationId`)
   - Download the `google-services.json` file and place it in the `android/app/` directory
   - For iOS, download the `GoogleService-Info.plist` file and add it to your Xcode project

3. **Enable Email/Password authentication:**
   - In the Firebase Console, go to "Authentication" > "Sign-in method"
   - Enable the Email/Password sign-in provider

4. **Update Firebase dependencies:**
   - This project already includes the required Firebase dependencies in the `pubspec.yaml` file

## Running the App

1. Make sure you have Flutter installed and set up on your machine
2. Run `flutter pub get` to install dependencies
3. Connect a device or start an emulator
4. Run `flutter run` to start the app

## Additional Configuration

For web deployment, you'll need to add your Firebase configuration in `web/index.html`. Refer to the [Firebase documentation](https://firebase.google.com/docs/flutter/setup) for detailed instructions.