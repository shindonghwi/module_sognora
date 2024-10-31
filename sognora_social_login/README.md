
# sognora_social_login

A Flutter package that provides a quick way to integrate social logins.

## Description

This library is designed to help developers integrate social login functionality into their Flutter applications swiftly.

### Supported Social Logins

- **Google**: Currently supported.
- **Kakao**: Planned for future support.
- **Apple**: Planned for future support.
- **Naver**: Planned for future support.

## Getting Started

To use this package, follow the instructions below.

### Installation

Add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  sognora_social_login: ^0.0.1
```

### Firebase Setup

1. Register your project on the [Firebase Console](https://console.firebase.google.com/).
2. Download the `google-services.json` file from the Firebase Console.
3. Place the `google-services.json` file in the `android/app` directory of your Flutter project.

### Android Gradle Setup

In your Android project, make sure to configure the following settings in your `build.gradle` files:

1. **In `android/app/build.gradle`:**
   ```groovy
   android {
       ...
       defaultConfig {
           ...
           minSdkVersion 21  // Minimum SDK version must be 21 or higher
       }
   }
   ```

2. **In your project-level `build.gradle`:**
   ```groovy
   buildscript {
       ext.kotlin_version = '1.9.0' // Kotlin version must be 1.9.0 or higher
       repositories {
           ...
       }
       dependencies {
           ...
           classpath 'com.google.gms:google-services:4.3.15' // Add Google services classpath
       }
   }
   ```

3. **In your `android/app/build.gradle`:**
   ```groovy
   dependencies {
       ...
       implementation platform("com.google.firebase:firebase-bom:32.7.0") // Firebase BoM
       implementation 'com.google.firebase:firebase-analytics' // Firebase Analytics
   }
   ```

### Google Login Usage Example

To use Google login with the `sognora_social_login` package, follow the example below:

1. **Create a Google login object:**
   ```dart
   final google = Sognora.socialLogin.google(); // Create Google login object
   ```

2. **Sign in using Google:**
   ```dart
   void signIn() async {
     final response = await google.signIn(); // Sign in using Google
     if (response.status == 200) {
       print('Login successful: ${response.data.email}');
     } else {
       print('Login failed: ${response.msg}');
     }
   }
   ```

3. **Sign out using Google:**
   ```dart
   void signOut() async {
     await google.signOut(); // Sign out using Google
   }
   ```

## Resources

For help getting started with Flutter development, view the [online documentation](https://docs.flutter.dev/), which offers tutorials, samples, guidance on mobile development, and a full API reference.
