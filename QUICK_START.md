# Quick Start Guide - XYZ Inc. Employee Management System

##  Getting Started in 5 Minutes

### Step 1: Install Dependencies
```bash
flutter pub get
```

### Step 2: Generate Code
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Step 3: Run the App
```bash
flutter run
```

That's it! The app should now be running on your device/emulator.

## App Usage Guide

### Home Screen Features

1. **View All Employees**
    - Employees load automatically when the app starts
    - Pull down to refresh the list

2. **Search Employees**
    - Tap the search bar at the top
    - Type employee name to filter results
    - Tap X to clear search

3. **Filter Employees**
    - Tap the filter icon (top right)
    - Select designation and/or level
    - Tap "Apply Filters"
    - Active filters shown as chips below search
    - Tap "Clear All" to remove filters

4. **View Employee Details**
    - Tap any employee card
    - See complete information and employment action

5. **Simulate Error**
    - Tap the three dots menu (top right)
    - Select "Simulate Error"
    - See how errors are displayed
    - Tap X on error card to dismiss

### Details Screen Features

1. **Productivity Meter**
    - Visual circular progress indicator
    - Color-coded by performance level
    - Shows score ranges and actions

2. **Employment Action**
    - Automatically calculated based on score
    - Shows current and new information
    - Color-coded status badges
    - Detailed descriptions

3. **Special Notes**
    - Level 0 employees see termination warning if score < 40

##  Understanding the UI

### Color Meanings
- **Green**: Promotions, success, excellent scores
- **Blue**: No change, info, general navigation
- **Orange**: Demotions, warnings, poor scores
- **Red**: Terminations, errors, failing scores

### Productivity Score Ranges
| Score Range | Color  | Action      |
|-------------|--------|-------------|
| 80-100      | Green  | Promotion   |
| 50-79       | Blue   | No Change   |
| 40-49       | Orange | Demotion    |
| 0-39        | Red    | Termination |

##  Customization Tips

### Changing Colors
Edit `lib/common/constants/app_colors.dart`:
```dart
static const Color primary = Color(0xFF1976D2); // Change this
```

### Adding New Filters
Edit `lib/features/home/presentation/widgets/filter_bottom_sheet.dart`

### Modifying Salary Levels
Edit `lib/common/constants/salary_levels.dart`:
```dart
static const Map<int, int> levelSalaries = {
  0: 70000,
  // Add more levels here
};
```

## 🧪 Testing

### Run All Tests
```bash
flutter test
```

### Run Specific Test
```bash
flutter test test/employment_action_test.dart
```

### Run with Coverage
```bash
flutter test --coverage
```

## 📦 Building for Release

### Android APK
```bash
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

### iOS
```bash
flutter build ios --release
```

## 🐛 Troubleshooting

### Common Issues

**Problem**: "Provider not found"
**Solution**: Make sure `EmployeeProvider` is wrapped in `MultiProvider` in `root_widget.dart`

**Problem**: Database not saving
**Solution**: Check permissions in `AndroidManifest.xml` and `Info.plist`

**Problem**: Hot reload not working
**Solution**: Try hot restart (Shift+R in terminal) or restart app completely

**Problem**: Build errors after updating dependencies
**Solution**: Run `flutter clean && flutter pub get`

## Project Files Overview

### Core Files You'll Work With Most
- `lib/features/home/presentation/screens/home_screen.dart` - Main screen
- `lib/features/details/presentation/screens/details_screen.dart` - Details view
- `lib/common/constants/app_colors.dart` - Color definitions
- `lib/core/models/employee.dart` - Employee data model
- `lib/features/home/presentation/providers/employee_provider.dart` - State management

### Important Configuration Files
- `pubspec.yaml` - Dependencies
- `lib/common/theme/app_theme.dart` - App theme
- `lib/main.dart` - App entry point

## 🎯 Next Steps

1. **Customize the UI** to match your preferences
2. **Add more employees** to `lib/core/network/api.dart`
3. **Write more tests** in `test/` directory
4. **Add features** like:
    - Employee photos
    - Performance history charts
    - Export to PDF
    - Dark mode
5. **Optimize performance** with lazy loading
6. **Add animations** for better UX

## Pro Tips

- Use `flutter pub run build_runner watch` for continuous code generation
- Install Flutter DevTools for debugging: `flutter pub global activate devtools`
- Use VS Code Flutter extension or Android Studio for better development experience
- Check `flutter doctor` to ensure your environment is properly set up

## Learning Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Provider Package](https://pub.dev/packages/provider)
- [Material Design Guidelines](https://m3.material.io/)
- [SQLite in Flutter](https://docs.flutter.dev/cookbook/persistence/sqlite)

##  Getting Help

If you encounter issues:
1. Check this guide first
2. Review the main README.md
3. Check Flutter documentation
4. Search Stack Overflow
5. Ask in Flutter Discord/Reddit communities

