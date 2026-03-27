# BeatFlow - Flutter Music Streaming App

## Project Overview
A modern music streaming Flutter application with multiple screens including:
- Home/Dashboard
- Music Player
- Playlists
- Search
- User Profile
- Favorites/Liked Songs
- Recently Played
- Discover/Browse

## Development Guidelines
- Follow Flutter best practices and conventions
- Use Provider for state management
- Implement responsive UI design
- Keep components modular and reusable
- Test on both Android and iOS

## Architecture
- **State Management**: Provider (MusicProvider, PlayerProvider)
- **Routing**: Built-in Navigator with named routes
- **Data Models**: Song, Playlist, Artist
- **UI Layer**: Multiple screens with Material Design 3
- **Color Scheme**: Dark theme with Spotify-inspired green (#1DB954)

## Setup Checklist
- [x] Verify copilot-instructions.md file created
- [x] Get project setup information
- [x] Scaffold project structure (lib, test, assets directories)
- [x] Customize with Figma designs (9 screens implemented)
- [x] Build project to verify basic syntax
- [x] Update README with proper documentation
- [x] Ready for development and testing

## Implemented Screens (from Figma)
1. Home/Dashboard - Recently played songs and playlists
2. Music Player - Full player with controls and progress
3. Playlists - Playlist management and browsing
4. Search - Global search across songs, artists, playlists
5. Favorites - Liked songs collection
6. Profile - User profile and statistics
7. Discover - Featured artists and new releases
8. Recently Played - Listening history
9. My Playlists - Playlist management

## Key Files
- `pubspec.yaml` - Dependencies and assets configuration
- `lib/main.dart` - App entry point and routing
- `lib/theme/app_theme.dart` - Dark theme configuration
- `lib/models/` - Data models (Song, Playlist, Artist)
- `lib/providers/` - State management (Music, Player)
- `lib/screens/` - All screen implementations
- `lib/widgets/` - Reusable components
- `README.md` - Comprehensive documentation
