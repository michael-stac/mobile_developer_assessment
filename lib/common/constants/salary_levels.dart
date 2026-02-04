class SalaryLevels {
  SalaryLevels._();

  /// Salary levels as specified in requirements
  static const Map<int, int> levelSalaries = {
    0: 70000,
    1: 100000,
    2: 120000,
    3: 180000,
    4: 200000,
    5: 250000,
  };

  /// Maximum and minimum levels
  static const int minLevel = 0;
  static const int maxLevel = 5;

  /// Productivity score thresholds
  static const double promotionThreshold = 80.0;
  static const double noChangeThresholdHigh = 79.0;
  static const double noChangeThresholdLow = 50.0;
  static const double demotionThresholdHigh = 49.0;
  static const double demotionThresholdLow = 40.0;
  static const double terminationThreshold = 39.0;

  /// Get salary for a given level
  static int getSalary(int level) {
    return levelSalaries[level] ?? 70000;
  }

  /// Get the next level
  static int? getNextLevel(int currentLevel) {
    if (currentLevel >= maxLevel) return null;
    return currentLevel + 1;
  }

  /// Get the previous level
  static int? getPreviousLevel(int currentLevel) {
    if (currentLevel <= minLevel) return null;
    return currentLevel - 1;
  }

  /// Check if level can be promoted
  static bool canBePromoted(int level) {
    return level < maxLevel;
  }

  /// Check if level can be demoted
  static bool canBeDemoted(int level) {
    return level > minLevel;
  }

  /// Get level description
  static String getLevelDescription(int level) {
    switch (level) {
      case 0:
        return 'Entry Level';
      case 1:
        return 'Junior';
      case 2:
        return 'Mid-Level';
      case 3:
        return 'Senior';
      case 4:
        return 'Lead';
      case 5:
        return 'Executive';
      default:
        return 'Unknown';
    }
  }

  /// Format salary as currency string
  static String formatSalary(int salary) {
    return '\$${salary.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    )}';
  }

  /// Parse salary from string (handles both "100,000" and "100000" formats)
  static int parseSalary(String salaryString) {
    /// Remove dollar signs, commas, and spaces if need be
    final cleanedString = salaryString.replaceAll(RegExp(r'[$,\s]'), '');
    return int.tryParse(cleanedString) ?? 0;
  }
}

/// Employment action types
enum EmploymentAction {
  promotion,
  noChange,
  demotion,
  termination,
}

extension EmploymentActionExtension on EmploymentAction {
  String get displayName {
    switch (this) {
      case EmploymentAction.promotion:
        return 'Promotion';
      case EmploymentAction.noChange:
        return 'No Change';
      case EmploymentAction.demotion:
        return 'Demotion';
      case EmploymentAction.termination:
        return 'Termination';
    }
  }

  String get description {
    switch (this) {
      case EmploymentAction.promotion:
        return 'Employee will be promoted to the next level with a salary increase';
      case EmploymentAction.noChange:
        return 'Employee status and salary remain unchanged';
      case EmploymentAction.demotion:
        return 'Employee will be demoted to the previous level with a salary reduction';
      case EmploymentAction.termination:
        return 'Employee will be terminated from the company';
    }
  }

  /// Determine action based on productivity score and current level
  static EmploymentAction determineAction(double productivityScore, int currentLevel) {
    if (productivityScore >= SalaryLevels.promotionThreshold) {
      /// 80-100: Promotion (if possible)
      return SalaryLevels.canBePromoted(currentLevel)
          ? EmploymentAction.promotion
          : EmploymentAction.noChange;
    } else if (productivityScore >= SalaryLevels.noChangeThresholdLow) {
      /// 50-79: No change
      return EmploymentAction.noChange;
    } else if (productivityScore >= SalaryLevels.demotionThresholdLow) {
      /// 40-49: Demotion (if possible, otherwise termination for level 0)
      if (currentLevel == SalaryLevels.minLevel) {
        return EmploymentAction.termination;
      }
      return EmploymentAction.demotion;
    } else {
      /// 0-39: Termination
      return EmploymentAction.termination;
    }
  }

  /// Calculate new salary based on action
  static int calculateNewSalary(EmploymentAction action, int currentLevel) {
    switch (action) {
      case EmploymentAction.promotion:
        final nextLevel = SalaryLevels.getNextLevel(currentLevel);
        return nextLevel != null ? SalaryLevels.getSalary(nextLevel) : SalaryLevels.getSalary(currentLevel);
      case EmploymentAction.demotion:
        final previousLevel = SalaryLevels.getPreviousLevel(currentLevel);
        return previousLevel != null ? SalaryLevels.getSalary(previousLevel) : SalaryLevels.getSalary(currentLevel);
      case EmploymentAction.termination:
        return 0;
      case EmploymentAction.noChange:
        return SalaryLevels.getSalary(currentLevel);
    }
  }

  /// Calculate new level based on action
  static int calculateNewLevel(EmploymentAction action, int currentLevel) {
    switch (action) {
      case EmploymentAction.promotion:
        return SalaryLevels.getNextLevel(currentLevel) ?? currentLevel;
      case EmploymentAction.demotion:
        return SalaryLevels.getPreviousLevel(currentLevel) ?? currentLevel;
      case EmploymentAction.termination:
        return currentLevel;
      case EmploymentAction.noChange:
        return currentLevel;
    }
  }
}