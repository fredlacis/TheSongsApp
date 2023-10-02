# TheSongsApp
🎵 A simple but elegant app for searching and listening to Music provided by the iTunes API  |  Built in UIKit using the MVVM-C architecture with the Combine framework

---
## Design Patterns
- **MVVM** architecture
- **Coordinator** pattern for handling navigation and factory
- **Repository** pattern for organizing different sources of data
- **Dependency Injection** for ensuring testability

## Frameworks
This app was developed using only native frameworks, such as:
- **UIKit** for building user interfaces programatically
- **Combine** for making the user interfaces reactive for the changes made by the ViewModels
- **AVFoundation** for playing music provided by the iTunes API

## Features
- Light and Dark mode based on the device`s settings
- Search for songs in the home page
- Infinite scrolling on search results
- Select the music from the search results lists to access the Player screen
- Seek through the music`s timeline using the slider
- Use the Forward and Backward buttons to move 5 seconds frontwards or backwards
- Once the music starts playing, listen to it across the other screens of the app
- Access the song's album and select other songs in real time

---
*In order to run the app, simply open the `xcodeproj` file on Xcode and build it!*
