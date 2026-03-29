# BeatFlow - Music Streaming App

A modern, high-fidelity music streaming Flutter application designed with **Material Design 3** principles and a stunning **Glassmorphic UI**.

## Features

- **Glassmorphic UI** - Beautiful, translucent design elements with ambient background effects.
- **Home Dashboard** - Browse recently played songs and featured content.
- **Modern Onboarding** - Elegant introduction flow with vibrant visuals.
- **Music Player** - Full-featured player with advanced controls and favorites.
- **Library Management** - Manage playlists, liked songs, and listening history.
- **Discover & Search** - Explore new releases and search for your favorite artists.
- **User Profiles** - Customizable profiles and settings.
- **Performance Optimized** - Smooth transitions and efficient caching.

## Project Structure

The project is organized following a feature-based architecture within the `frontend` directory:

```
frontend/lib/
├── core/                     # Core utilities, theme, and constants
│   ├── theme/                # AppTheme definition (Outfit font + 3-color palette)
│   └── utils/                # General purpose helpers
├── main.dart                 # App entry point
├── models/                   # Data models (Song, Artist, Playlist)
├── providers/                # State management (MusicProvider, PlayerProvider)
├── screens/                  # Feature-based screen organization
│   ├── album/                # Album details
│   ├── artist/               # Artist bios and top tracks
│   ├── auth/                 # Onboarding and Splash screens
│   ├── discover/             # Discover and Categories
│   ├── home/                 # Main dashboard
│   ├── library/              # Favorites, My Playlists, Recently Played
│   ├── player/               # Full-screen music player
│   ├── profile/              # Profile, Settings, Notifications
│   └── search/               # Global search
├── widgets/                  # Reusable UI components
└── services/                 # External API and local storage services
```

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / Xcode (for emulator)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/vinitgajjar13/music_app.git
cd music_app
```

2. Navigate to the frontend directory:
```bash
cd frontend
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## UI & Design System

BeatFlow uses a premium design language characterized by vibrant colors and glassmorphic elements.

### Color Scheme

- **Primary Green**: `#1DB954` (Core brand color)
- **Secondary Orange**: `#FF7A00` (Modern vibrancy)
- **Accent Cyan**: `#00C2FF` (Interactive elements)
- **Glassy Effect**: 20% white/black opacity with subtle borders (`0x33FFFFFF`)

### Typography

- **Font Family**: [Outfit](https://fonts.google.com/specimen/Outfit)
- **Display**: ExtraBold/Black for striking headings
- **Body**: Regular/Medium for readability
- **Character**: Material 3 letter spacing and line heights

## Dependencies

- **flutter_animate** - For high-performance micro-animations
- **just_audio & audio_service** - Pro-level audio playback
- **get** & **go_router** - Navigation and state management
- **cached_network_image** - Efficient asset loading
- **hive** - Lightweight local storage

## Architecture

BeatFlow follows a modern, scalable architecture:

1.  **UI Layer**: Material 3 components with custom glassmorphic styling.
2.  **State Management**: Logic-separated providers for player and content states.
3.  **Data Layer**: Services for local caching and future API integration.

## Development Guidelines

- Use `AppTheme` constants for all styling.
- Keep components reusable and localized.
- Test on physical devices for performance validation (especially glass effects).

## Building for Release

### Android
```bash
cd frontend
flutter build apk --release
```


Built with Flutter and ❤️ by the BeatFlow Team

