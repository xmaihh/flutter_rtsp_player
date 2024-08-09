# flutter_rtsp_player

[![Release](https://img.shields.io/github/v/release/xmaihh/flutter_rtsp_player)](https://github.com/xmaihh/flutter_rtsp_player/releases)
[![CI](https://github.com/xmaihh/flutter_rtsp_player/actions/workflows/ci.yml/badge.svg)](https://github.com/xmaihh/flutter_rtsp_player/actions/)

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


```
my_rtsp_player/
├── android/
├── ios/
├── lib/
│   ├── main.dart
│   ├── screens/
│   │   ├── home_screen.dart
│   │   ├── player_screen.dart
│   │   └── add_rtsp_screen.dart
│   ├── models/
│   │   └── rtsp_stream.dart
│   ├── services/
│   │   ├── rtsp_service.dart
│   │   └── media_service.dart
│   ├── widgets/
│   │   ├── stream_list.dart
│   │   ├── stream_item.dart
│   │   └── player_controls.dart
│   └── utils/
│       ├── config_manager.dart
│       └── media_utils.dart
├── pubspec.yaml
└── README.md
```

Summary
- Android/iOS: Uses [flutter_vlc_player](https://pub.dev/packages/flutter_vlc_player).
- Web: Uses [video_player](https://pub.dev/packages/video_player).
- Windows: ~~Uses [dart_vlc](https://pub.dev/packages/dart_vlc).~~ Uses [medit-kit](https://pub.dev/packages/media_kit).

<div style="display: flex; align-items: center;">
    <div style="position: relative; display: inline-block; margin: 0 10px;">
        <img src="docs/screenshot/add_rtsp_screen.png" alt="pic1" style="display: block; max-width: 100%; height: auto;">
    </div>
    <div style="position: relative; display: inline-block; margin: 0 10px;">
        <img src="docs/screenshot/home_scren.png" alt="pic2" style="display: block; max-width: 100%; height: auto;">
    </div>
    <div style="position: relative; display: inline-block; margin: 0 10px;">
        <img src="docs/screenshot/player_screen.png" alt="pic3" style="display: block; max-width: 100%; height: auto;">
    </div>
</div>
