# swap_shop

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

Downloads/Installations needed:
[Visual Studio Code](https://code.visualstudio.com/)

[Flutter](https://docs.flutter.dev/get-started/install?gclid=EAIaIQobChMI07Sx2tTw9gIVytPtCh2qEggXEAAYASAAEgIe9PD_BwE&gclsrc=aw.ds)

[Android Studio](https://developer.android.com/studio)

[Firebase](https://firebase.google.com/)

[How to install and set up Flutter on VS Code and set up with Android Studio](https://www.youtube.com/watch?v=tun0HUHaDuE)

[How to set up Firebase](https://www.youtube.com/watch?v=QZ_53nSPgPg)

=======
[How to install and set up Flutter on VS Code and set up with Android Studio](https://www.youtube.com/watch?v=tun0HUHaDuE)


A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Architecture Description

Swap Shop's architecture consists of both front-end and back-end applications, which can all be installed on a PC (see "Getting Started").

### Firebase
Firebase is a platform developed by Google for creating mobile and web applications. Swap Shop makes use of the back-end platform as it is:
 -cloud-based
 -allows for viewing, adding, editing, and deletion of data.
 -allows for us to manage indexes and monitor usage.
 -uses Firebase Authentication and Cloud Firestore Security Rules to handle serverless authentication, authorization, and data validation
 -keeps your data private and secure
 -very low maintenance


### Android Studio
Android Studio is the official integrated development environment for Google's Android operating system, built on JetBrains' IntelliJ IDEA software and designed specifically for Android development. Flutter makes use of the Android SDK, and sets the environment variable to the SDK path for the flutter installation to recognise it, allowing for the front-end developemnt of the Swap Shop application.

### VS Code
Visual Studio Code, also commonly referred to as VS Code, is a source-code editor made by Microsoft for Windows, Linux and macOS. Swap Shop uses VS Code as an editor to run,edit and make the application with the Flutter development kit.

### Flutter
Flutter is an open-source UI software development kit created by Google. It is used to develop cross platform applications for Android, iOS, Linux, macOS, Windows, Google Fuchsia, and the web from a single codebase. Swap Shop makes use of the development kit alongside Android Studio and VS Code for the front-end development of the application. We make use of the Dart as the programming language as it is stable and creates high-performance applications as it is an object-oriented language.  


## Project Description

### Project scope

We aim to design and implement an app for users to swap different categories of items (food, clothes, furniture, etc.)
The user data collected for the system will include the email address and the area in which the user resides in.
Once data is saved in the system, the email address and password will be used to log into the system,  a verified email address will be used to retrieve a password in case a user forgets their password.

### Purpose

The purpose of this app is to help facilitate the process of swapping items for communities which have started operating swap shops(where people swap food, clothes, furniture, etc.) in efforts to avoid waste and grow communities.
The application will help users to easily find other users who also have items to swap.


## How to Install and Run Project

Go to "Code", select "Download ZIP file"

Extract files, open Visual Studio Code (if you have not downloaded and set it up check out "Getting Started") and Open Folders

Open "SubZero-Inc-main" and select emulator and click "Run and Debug"

## CircleCI Badge
[![codecov](https://codecov.io/gh/Naturekhosa/SubZero-Inc/branch/BrowseListings/graph/badge.svg?token=Z46Q8CV70P)](https://codecov.io/gh/Naturekhosa/SubZero-Inc)
=======
Extract files, open Visual Studio Code (if you have not downloaded and set it up check out "Get Started") and Open Folders
Open "SubZero-Inc-main" and select emulator and click "Run and Debug"

## Badge

[![CircleCI](https://circleci.com/gh/Naturekhosa/SubZero-Inc/tree/BrowseListings.svg?style=svg)](https://circleci.com/gh/Naturekhosa/SubZero-Inc/tree/BrowseListings)

