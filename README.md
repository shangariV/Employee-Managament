# Employee_Management

This is a Flutter project that demonstrates a basic CRUD (Create, Read, Update, Delete) application. The app interacts with a cosmocloud API to perform CRUD operations on a database.

## Prerequisites

Before you can run this project, ensure you have the following installed:

Flutter SDK: Install Flutter
Dart SDK: Included with Flutter.
Android Studio or Visual Studio Code: For code editing and debugging.
Xcode: Required for iOS development (macOS only).

## Getting Started

Follow these steps to set up and run the project locally:

1. Clone the Repository

    ```bash
     git clone https://github.com/shangariV/Employee-Managament.git
 
     cd Employee-Managament
   
2. Install Dependencies
   
      Run the following command to get the necessary packages:

      ```bash
      flutter pub get
3. Create a CRUD Database in cosmocloud by using below links and replace your projectId and environmentId in employee_remote_data_source class under datasource folder.

     'projectId': '****', //  Replace with your projectId
   
     'environmentId': '****', //  Replace with your environmentId
   
5. Set Up the Environment
   
     Ensure you have an Android or iOS device/emulator connected and set up.
      Android: Use Android Studio's AVD Manager or a physical device.
   
      iOS: Use Xcode's Simulator or a physical device.
   
6. Running the App

    To run the app on a connected device or emulator:
  
    ```bash
    flutter run

## Features

Create: Users can add new employee to the database.

Read: Displays the existing data from the database.

Delete: Users can delete specific employee data.

## Technologies Used

Flutter: A popular cross-platform framework for building mobile applications.
cosmocloud : Used to create a simple CRUD APIs on Cosmocloud,This can be done using the CRUD template on Cosmocloud in just minutes.

## Resources for API 

[Signup on Cosmocloud (it’s Free)](https://cosmocloud.io/redirect?event_id=frontend_hiring_task&redirect_url=https://cosmocloud.io)

[Getting Started on Cosmocloud](https://cosmocloud.io/redirect?event_id=frontend_hiring_task&redirect_url=https://docs.cosmocloud.io/getting-started)

[Sample Tutorials for CRUD](https://cosmocloud.io/redirect?event_id=frontend_hiring_task&redirect_url=https://tutorials.cosmocloud.io/)

[Cosmocloud Documentation](https://cosmocloud.io/redirect?event_id=frontend_hiring_task&redirect_url=https://docs.cosmocloud.io)

