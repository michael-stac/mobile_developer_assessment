import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  /// Primary Colors
  static const Color primary = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFF63A4FF);
  static const Color primaryDark = Color(0xFF004BA0);

  /// Secondary Colors
  static const Color secondary = Color(0xFF424242);
  static const Color secondaryLight = Color(0xFF6D6D6D);
  static const Color secondaryDark = Color(0xFF1B1B1B);

  /// Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFF80E27E);
  static const Color successDark = Color(0xFF087F23);

  static const Color warning = Color(0xFFFF9800);
  static const Color warningLight = Color(0xFFFFD54F);
  static const Color warningDark = Color(0xFFF57C00);

  static const Color error = Color(0xFFF44336);
  static const Color errorLight = Color(0xFFE57373);
  static const Color errorDark = Color(0xFFD32F2F);

  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFF64B5F6);
  static const Color infoDark = Color(0xFF1976D2);

  /// Background Colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFFEEEEEE);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFFFAFAFA);

  /// Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textDisabled = Color(0xFFE0E0E0);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  /// Divider & Border Colors
  static const Color divider = Color(0xFFE0E0E0);
  static const Color border = Color(0xFFBDBDBD);
  static const Color borderLight = Color(0xFFE0E0E0);

  /// Employment Status Colors
  static const Color promoted = Color(0xFF4CAF50);
  static const Color demoted = Color(0xFFFF9800);
  static const Color terminated = Color(0xFFF44336);
  static const Color noChange = Color(0xFF2196F3);

  /// Level Badge Colors
  static const Color level0 = Color(0xFF9E9E9E);
  static const Color level1 = Color(0xFF8BC34A);
  static const Color level2 = Color(0xFF2196F3);
  static const Color level3 = Color(0xFF9C27B0);
  static const Color level4 = Color(0xFFFF9800);
  static const Color level5 = Color(0xFFFFD700);

  /// Productivity Score Colors (gradient)
  static const Color scoreExcellent = Color(0xFF4CAF50);
  static const Color scoreGood = Color(0xFF8BC34A);
  static const Color scorePoor = Color(0xFFFF9800);
  static const Color scoreFailing = Color(0xFFF44336);

  /// Chart Colors
  static const List<Color> chartColors = [
    Color(0xFF1976D2),
    Color(0xFF4CAF50),
    Color(0xFFFF9800),
    Color(0xFFF44336),
    Color(0xFF9C27B0),
    Color(0xFF00BCD4),
  ];

  /// Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [success, successDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient warningGradient = LinearGradient(
    colors: [warning, warningDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient errorGradient = LinearGradient(
    colors: [error, errorDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Shadow Colors
  static const Color shadow = Color(0x1A000000);
  static const Color shadowLight = Color(0x0D000000);
  static const Color shadowDark = Color(0x33000000);

  /// Get color based on productivity score
  static Color getScoreColor(double score) {
    if (score >= 80) return scoreExcellent;
    if (score >= 50) return scoreGood;
    if (score >= 40) return scorePoor;
    return scoreFailing;
  }

  /// Get color based on employee level
  static Color getLevelColor(int level) {
    switch (level) {
      case 0:
        return level0;
      case 1:
        return level1;
      case 2:
        return level2;
      case 3:
        return level3;
      case 4:
        return level4;
      case 5:
        return level5;
      default:
        return level0;
    }
  }

  /// Get color based on employment action
  static Color getActionColor(String action) {
    switch (action.toLowerCase()) {
      case 'promotion':
        return promoted;
      case 'demotion':
        return demoted;
      case 'termination':
        return terminated;
      case 'no change':
        return noChange;
      default:
        return textSecondary;
    }
  }
}