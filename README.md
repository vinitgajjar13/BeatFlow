# BeatFlow - Music Streaming App

A modern, beautiful music streaming Flutter application designed with the latest Material Design 3 principles.

## Features

- **Home Dashboard** - Browse recently played songs and your playlists
- **Music Player** - Full-featured player with play controls, progress tracking, and favorite toggling
- **Playlists** - Create, manage, and play custom playlists
- **Search** - Search songs, artists, and playlists
- **Discover** - Explore featured artists and new releases
- **Recently Played** - View your listening history
- **Liked Songs** - Collections of your favorite tracks
- **User Profile** - Manage your profile and preferences

## Project Structure

```
lib/
├── main.dart                 # App entry point and routing
├── screens/                  # All screen implementations
│   ├── home_screen.dart
│   ├── player_screen.dart
│   ├── playlist_screen.dart
│   ├── search_screen.dart
│   ├── favorites_screen.dart
│   ├── profile_screen.dart
│   ├── discover_screen.dart
│   ├── recently_played_screen.dart
│   └── my_playlists_screen.dart
├── widgets/                  # Reusable widgets
│   ├── music_card.dart
│   ├── album_grid.dart
│   └── play_button.dart
├── models/                   # Data models
│   ├── song_model.dart
│   ├── playlist_model.dart
│   └── artist_model.dart
├── providers/                # State management
│   ├── music_provider.dart
│   └── player_provider.dart
├── services/                 # API and services
├── theme/                    # Theme and styling
│   └── app_theme.dart
└── utils/                    # Utility functions
```

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / Xcode (for emulator)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/beatflow.git
cd beatflow
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Dependencies

- **Provider** - State management
- **GetX** - Alternative state management and navigation
- **GoRouter** - Advanced routing
- **Just Audio** - Audio playback
- **Audio Service** - Background audio
- **Hive** - Local storage
- **Cached Network Image** - Image caching

## Color Scheme

- **Primary Green**: #1DB954 (Spotify inspired)
- **Dark Background**: #121212
- **Card Background**: #1E1E1E & #282828
- **Text Primary**: #FFFFFF
- **Text Secondary**: #B3B3B3
- **Accent Yellow**: #FFC857

## Typography

- **Font Family**: Poppins
- **Display Large**: 32px Bold
- **Heading Large**: 24px SemiBold
- **Body Large**: 16px Regular
- **Caption**: 12px Regular

## Architecture

The app follows a multi-layer architecture:

1. **UI Layer** (Screens & Widgets)
   - Material Design 3 components
   - Responsive layouts
   - Beautiful animations

2. **State Management Layer** (Providers)
   - Music Provider - Manages songs, playlists, and playback
   - Player Provider - Manages player state

3. **Business Logic Layer** (Models & Services)
   - Song, Playlist, Artist models
   - Future: API services for backend integration

4. **Data Layer**
   - Local storage with Hive
   - Future: Remote API integration

## Development Guidelines

- Follow Flutter best practices
- Use meaningful variable and function names
- Keep widgets pure and reusable
- Implement proper error handling
- Test on both Android and iOS
- Follow Material Design 3 guidelines

## Building for Release

### Android
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## Testing

```bash
flutter test
```

## Contributing

1. Create a feature branch
2. Make your changes
3. Commit with clear messages
4. Push to your branch
5. Create a Pull Request

## Future Enhancements

- [ ] Backend API integration
- [ ] User authentication
- [ ] Social features (sharing, collaborative playlists)
- [ ] Advanced search filters
- [ ] Recommendations engine
- [ ] Offline mode
- [ ] Multiple language support
- [ ] Dark/Light theme toggle

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

For support or questions, please open an issue or contact the development team.

---

Built with Flutter and ❤️
