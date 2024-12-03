# ColorCards App

A simple iOS app that allows users to generate random color codes, store them locally, and sync them with Firebase, ensuring seamless offline and online functionality.

# Features
1. Color Code Generation Screen
* Generate random hex color codes with a single tap.
* Display the generated colors on a card.
* Users can generate multiple hex codes, all displayed in a scrolling list of cards.
2. Local Data Storage (Offline Handling)
* Colors are stored locally when the app is offline.
* Persistent storage ensures that all generated colors reappear when the app is reopened.
3. Firebase Sync (Online Handling)
* Sync all generated color codes to Firebase in real-time when the app is online.
* Uses Firestore or Firebase Realtime Database for cloud data storage.
4. Connectivity Awareness
* Detects whether the device is online or offline.
* Displays a connectivity indicator to inform the user of the current network status.
5. Error Handling
* Retries syncing data with Firebase automatically when internet connectivity is restored.
* Basic error messages and fallback options for network issues.
  

# Requirements
* Xcode: Version 14.0 or higher
* iOS: iOS 15.0 or higher
* Swift: Version 5.0 or higher
* CocoaPods: For managing dependencies

# Setup Instructions
1. Clone the Repository : git clone https://github.com/Taras-gi/ColorCards.git
2. Install Dependencies
   * cd ColorCards
   * Install CocoaPods dependencies: pod install
3. Firebase Setup
   * Create a Firebase project at Firebase Console.
   * Download the GoogleService-Info.plist file and add it to your Xcode project.
   * Enable Firestore or Realtime Database in your Firebase project.
4. Open the Project
   * Open the .xcworkspace file in Xcode: open ColorCards.xcworkspace


# Usage
* Generate Colors:
    * Tap the "Generate Color" button to create random color cards.
* Offline Handling:
    * Generated colors are stored locally and persist even if the app is closed.
* Online Handling:
    * When online, all locally stored colors are synced to Firebase automatically.
* Connectivity Awareness:
    * Observe the online/offline indicator in the app for real-time network status updates.
* Error Handling:
    * Automatic retry mechanisms ensure data is synced when the network is restored.


# Code Highlights
* Core Features Implementation
* Color Generation: generateRandomHexColor() method generates hex codes.
* Local Storage: Uses Core Data to store color codes persistently.
* Firebase Sync: syncColorToFireBase(data:) handles real-time syncing with Firebase.
* Network Monitoring: NetworkManager handles connectivity awareness using the Reachability library.
* Error Handling: Automatic retries when syncing fails due to network issues.


# Screenshots
1. Color Generation Screen

![Simulator Screenshot - iPhone 16 Pro - 2024-12-04 at 00 44 16](https://github.com/user-attachments/assets/e3eb2ae1-e1c9-454a-916e-f9c4e5bb33fc)

![Simulator Screenshot - iPhone 16 Pro - 2024-12-04 at 00 43 39](https://github.com/user-attachments/assets/8f6c5741-f850-405f-a429-57f31f170024)

# Technologies Used
* Swift: For app development.
* Core Data: For local persistent storage.
* Firebase: For real-time data synchronization.
* Reachability: For network monitoring.

# Future Enhancements
* Add the ability to delete or edit color cards.
* Implement advanced filtering for color cards.

# Contributing
Contributions are welcome! Please follow these steps:
1. Fork the repository.
2. Create a new branch for your feature/bug fix.
3. Commit your changes and push the branch.
4. Submit a pull request.

# Contact
For any questions or suggestions, feel free to contact:
* Suraj Bhatt: srjsrk200@gmail.com
