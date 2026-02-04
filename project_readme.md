# XYZ Inc. Employee Management System

A comprehensive Flutter mobile application for managing employee performance reviews and employment actions based on productivity scores.

## Features

 **Core Requirements**
- Load and display employee list from local API
- Save employees to local SQLite database
- Filter employees by name, designation, and level
- View detailed employee information
- Calculate employment actions based on productivity scores
- Simulate error responses

 **Bonus Features**
-  Provider state management
-  Adaptive and responsive UI
-  Beautiful Material Design 3 interface
- Pull-to-refresh functionality
-  Widget test setup
- Reusable component architecture
-  Clean architecture (Data/Domain/Presentation)

## Screenshots

[Add screenshots here after running the app]

## Business Logic

### Productivity Score Ranges
- **100 - 80**: Promotion + Pay Increase
- **79 - 50**: No Change
- **49 - 40**: Demotion
- **39 - 0**: Termination

**Special Rule**: Level 0 employees cannot be demoted and will be terminated if score is below 40.

### Salary Levels
- Level 0: $70,000 (Entry Level)
- Level 1: $100,000 (Junior)
- Level 2: $120,000 (Mid-Level)
- Level 3: $180,000 (Senior)
- Level 4: $200,000 (Lead)
- Level 5: $250,000 (Executive)

## Project Structure

```
lib/
├── common/
│   ├── constants/          # App-wide constants
│   │   ├── app_colors.dart
│   │   ├── app_strings.dart
│   │   └── salary_levels.dart
│   ├── theme/             # Theme configuration
│   │   └── app_theme.dart
│   └── widgets/           # Reusable widgets
│       ├── employee_card.dart
│       ├── error_widget.dart
│       ├── loading_widget.dart
│       └── empty_state_widget.dart
├── core/
│   ├── database/          # SQLite database
│   │   └── database_helper.dart
│   ├── models/            # Data models
│   │   ├── employee.dart
│   │   ├── api_response.dart
│   │   └── employment_action_result.dart
│   └── network/           # API layer
│       └── api.dart
├── features/
│   ├── home/
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── employee_provider.dart
│   │       ├── screens/
│   │       │   └── home_screen.dart
│   │       └── widgets/
│   │           └── filter_bottom_sheet.dart
│   └── details/
│       └── presentation/
│           ├── screens/
│           │   └── details_screen.dart
│           └── widgets/
│               ├── status_badge.dart
│               ├── productivity_meter.dart
│               └── info_card.dart
├── main.dart
└── root_widget.dart
```

## Setup Instructions

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Android Emulator / iOS Simulator / Physical Device

### Installation

1. **Clone the repository**
```bash
git clone <your-repository-url>
cd mobile_assessment
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Generate code (for JSON serialization)**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. **Run the app**
```bash
flutter run
```

### Running Tests
```bash
flutter test
```

### Building for Production

**Android APK**
```bash
flutter build apk --release
```

**iOS**
```bash
flutter build ios --release
```

## Key Technologies

- **Flutter**: Cross-platform UI framework
- **Provider**: State management solution
- **SQLite**: Local database for data persistence
- **JSON Serialization**: Type-safe JSON parsing
- **Material Design 3**: Modern UI components

## Architecture

The app follows **Clean Architecture** principles with clear separation of concerns:

### Layers
1. **Presentation Layer**: UI components, providers, screens
2. **Domain Layer**: Business logic, use cases (implicit in providers)
3. **Data Layer**: Models, database, API

### Design Patterns
- **Provider Pattern**: For state management
- **Repository Pattern**: Database abstraction
- **Factory Pattern**: Model creation from JSON/Database

## Color Scheme

The app uses a professional blue-based color palette:
- **Primary**: #1976D2 (Blue)
- **Secondary**: #424242 (Dark Grey)
- **Success**: #4CAF50 (Green - Promotions)
- **Warning**: #FF9800 (Orange - Demotions)
- **Error**: #F44336 (Red - Terminations)

## Features Walkthrough

### Home Screen
- Displays list of all employees
- Search functionality by employee name
- Filter by designation and level
- Pull-to-refresh to reload data
- Simulate error response from menu
- Visual indicators for active filters

### Employee Details Screen
- Complete employee information
- Visual productivity score meter
- Employment action calculation
- Before and after comparison
- Color-coded status badges
- Special notes for Level 0 employees

### Filtering
- Filter by designation (Customer Relations, Tech, Legal, HR)
- Filter by level (0-5)
- Combine multiple filters
- Clear filters functionality

## Testing

### Unit Tests
Located in `test/` directory. Tests cover:
- Model creation and serialization
- Business logic (employment actions)
- Salary calculations
- Provider state management

### Widget Tests
Test UI components in isolation:
- Employee card rendering
- Filter bottom sheet
- Error states
- Empty states

### Integration Tests
Test complete user flows:
- Load employees
- Apply filters
- Navigate to details
- Calculate employment actions

## Future Enhancements

- [ ] Backend API integration
- [ ] Employee photo uploads
- [ ] Performance history charts
- [ ] Export reports to PDF
- [ ] Dark mode support
- [ ] Animations and transitions
- [ ] Offline-first architecture
- [ ] Push notifications
- [ ] Multi-language support

## Troubleshooting

### Common Issues

**Issue**: Build fails with "Unsupported class file major version"
**Solution**: Update your Java JDK to version 17 or higher

**Issue**: Database not persisting data
**Solution**: Check path_provider initialization in main.dart

**Issue**: JSON serialization errors
**Solution**: Run `flutter pub run build_runner build --delete-conflicting-outputs`

## Contributing

This is an assessment project. For any questions or suggestions, please contact the development team.

## License

This project is created for assessment purposes.

## Contact

Developer: [Your Name]
Email: [Your Email]
GitHub: [Your GitHub Profile]

---

