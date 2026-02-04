import '../../../../common/constants/salary_levels.dart';

/// Result of employment action calculation
class EmploymentActionResult {
  final EmploymentAction action;
  final int currentLevel;
  final int newLevel;
  final int currentSalary;
  final int newSalary;
  final double productivityScore;
  final String description;

  const EmploymentActionResult({
    required this.action,
    required this.currentLevel,
    required this.newLevel,
    required this.currentSalary,
    required this.newSalary,
    required this.productivityScore,
    required this.description,
  });

  /// Calculate employment action based on productivity score and level
  factory EmploymentActionResult.calculate({
    required double productivityScore,
    required int currentLevel,
    required int currentSalary,
  }) {
    final action = EmploymentActionExtension.determineAction(
      productivityScore,
      currentLevel,
    );

    final newLevel = EmploymentActionExtension.calculateNewLevel(
      action,
      currentLevel,
    );

    final newSalary = EmploymentActionExtension.calculateNewSalary(
      action,
      currentLevel,
    );

    return EmploymentActionResult(
      action: action,
      currentLevel: currentLevel,
      newLevel: newLevel,
      currentSalary: currentSalary,
      newSalary: newSalary,
      productivityScore: productivityScore,
      description: _generateDescription(action, currentLevel, newLevel),
    );
  }

  static String _generateDescription(
      EmploymentAction action,
      int currentLevel,
      int newLevel,
      ) {
    switch (action) {
      case EmploymentAction.promotion:
        return 'Promoted from Level $currentLevel to Level $newLevel';
      case EmploymentAction.demotion:
        if (currentLevel == 0) {
          return 'Level 0 employee cannot be demoted - will be terminated';
        }
        return 'Demoted from Level $currentLevel to Level $newLevel';
      case EmploymentAction.termination:
        return 'Employment terminated due to low productivity';
      case EmploymentAction.noChange:
        return 'No change in employment status';
    }
  }

  /// Get salary change amount
  int get salaryChange => newSalary - currentSalary;

  /// Get salary change percentage
  double get salaryChangePercentage {
    if (currentSalary == 0) return 0;
    return (salaryChange / currentSalary) * 100;
  }

  /// Check if there's a level change
  bool get hasLevelChange => newLevel != currentLevel;

  /// Check if there's a salary change
  bool get hasSalaryChange => newSalary != currentSalary;

  /// Check if action is positive
  bool get isPositive => action == EmploymentAction.promotion || action == EmploymentAction.noChange;

  /// Check if action is negative
  bool get isNegative => action == EmploymentAction.demotion || action == EmploymentAction.termination;

  @override
  String toString() {
    return 'EmploymentActionResult{action: ${action.displayName}, '
        'currentLevel: $currentLevel, newLevel: $newLevel, '
        'currentSalary: $currentSalary, newSalary: $newSalary}';
  }
}