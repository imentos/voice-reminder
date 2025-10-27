# Voice Reminder MVP

A voice-based reminder and AI companion app for elderly users, featuring natural conversation, daily task management, and health tracking.

## Features

- Voice Recognition (STT) using Apple Speech Framework
- Natural voice output with elderly-friendly pacing
- Basic reminder creation and management
- Morning/evening check-ins
- Activity logging for family sharing

## Technical Stack

- SwiftUI for UI
- Apple Speech Framework for voice recognition
- AVFoundation for voice synthesis
- Core Data for local storage (coming soon)
- HealthKit integration (planned)

## Getting Started

1. Clone the repository
2. Open in Xcode
3. Build and run on an iOS device or simulator

## Requirements

- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+

## Structure

```
VoiceReminder/
├── Models/
│   └── Reminder.swift
├── Views/
│   └── ContentView.swift
├── Managers/
│   ├── VoiceManager.swift
│   └── ConversationManager.swift
└── VoiceReminderApp.swift
```

## License

MIT License