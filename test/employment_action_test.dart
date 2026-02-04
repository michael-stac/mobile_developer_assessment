import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_assessment/common/constants/salary_levels.dart';

import '../../features/details/domain/usecases/calculate_employment_action_usecase.dart';

void main() {
  group('Employment Action Calculation Tests', () {
    test('Score 80-100 should result in Promotion', () {
      final result = EmploymentActionResult.calculate(
        productivityScore: 91.0,
        currentLevel: 2,
        currentSalary: 120000,
      );

      expect(result.action, EmploymentAction.promotion);
      expect(result.newLevel, 3);
      expect(result.newSalary, 180000);
      expect(result.isPositive, true);
    });

    test('Score 50-79 should result in No Change', () {
      final result = EmploymentActionResult.calculate(
        productivityScore: 67.0,
        currentLevel: 2,
        currentSalary: 120000,
      );

      expect(result.action, EmploymentAction.noChange);
      expect(result.newLevel, 2);
      expect(result.newSalary, 120000);
      expect(result.hasSalaryChange, false);
    });

    test('Score 40-49 should result in Demotion', () {
      final result = EmploymentActionResult.calculate(
        productivityScore: 44.0,
        currentLevel: 1,
        currentSalary: 100000,
      );

      expect(result.action, EmploymentAction.demotion);
      expect(result.newLevel, 0);
      expect(result.newSalary, 70000);
      expect(result.isNegative, true);
    });

    test('Score below 40 should result in Termination', () {
      final result = EmploymentActionResult.calculate(
        productivityScore: 31.0,
        currentLevel: 2,
        currentSalary: 120000,
      );

      expect(result.action, EmploymentAction.termination);
      expect(result.newSalary, 0);
      expect(result.isNegative, true);
    });

    test('Level 0 with score 40-49 should be Terminated (cannot demote)', () {
      final result = EmploymentActionResult.calculate(
        productivityScore: 45.0,
        currentLevel: 0,
        currentSalary: 70000,
      );

      expect(result.action, EmploymentAction.termination);
      expect(result.newSalary, 0);
    });

    test('Level 5 with score 80+ should not be promoted (max level)', () {
      final result = EmploymentActionResult.calculate(
        productivityScore: 89.0,
        currentLevel: 5,
        currentSalary: 250000,
      );

      expect(result.action, EmploymentAction.noChange);
      expect(result.newLevel, 5);
      expect(result.newSalary, 250000);
    });

    test('Salary change calculation should be correct', () {
      final result = EmploymentActionResult.calculate(
        productivityScore: 91.0,
        currentLevel: 1,
        currentSalary: 100000,
      );

      expect(result.salaryChange, 20000); // 120000 - 100000
      expect(result.salaryChangePercentage, 20.0);
    });
  });

  group('Salary Levels Tests', () {
    test('Should return correct salary for each level', () {
      expect(SalaryLevels.getSalary(0), 70000);
      expect(SalaryLevels.getSalary(1), 100000);
      expect(SalaryLevels.getSalary(2), 120000);
      expect(SalaryLevels.getSalary(3), 180000);
      expect(SalaryLevels.getSalary(4), 200000);
      expect(SalaryLevels.getSalary(5), 250000);
    });

    test('Should format salary correctly', () {
      expect(SalaryLevels.formatSalary(100000), '\$100,000');
      expect(SalaryLevels.formatSalary(250000), '\$250,000');
      expect(SalaryLevels.formatSalary(70000), '\$70,000');
    });

    test('Should parse salary correctly', () {
      expect(SalaryLevels.parseSalary('100,000'), 100000);
      expect(SalaryLevels.parseSalary('\$250,000'), 250000);
      expect(SalaryLevels.parseSalary('70000'), 70000);
    });

    test('Should correctly identify promotion capability', () {
      expect(SalaryLevels.canBePromoted(0), true);
      expect(SalaryLevels.canBePromoted(4), true);
      expect(SalaryLevels.canBePromoted(5), false);
    });

    test('Should correctly identify demotion capability', () {
      expect(SalaryLevels.canBeDemoted(0), false);
      expect(SalaryLevels.canBeDemoted(1), true);
      expect(SalaryLevels.canBeDemoted(5), true);
    });

    test('Should get correct level descriptions', () {
      expect(SalaryLevels.getLevelDescription(0), 'Entry Level');
      expect(SalaryLevels.getLevelDescription(5), 'Executive');
    });
  });

  group('Edge Cases Tests', () {
    test('Score exactly 80 should be Promotion', () {
      final result = EmploymentActionResult.calculate(
        productivityScore: 80.0,
        currentLevel: 1,
        currentSalary: 100000,
      );

      expect(result.action, EmploymentAction.promotion);
    });

    test('Score exactly 50 should be No Change', () {
      final result = EmploymentActionResult.calculate(
        productivityScore: 50.0,
        currentLevel: 2,
        currentSalary: 120000,
      );

      expect(result.action, EmploymentAction.noChange);
    });

    test('Score exactly 40 should be Demotion (or Termination for Level 0)', () {
      // Level 1
      final result1 = EmploymentActionResult.calculate(
        productivityScore: 40.0,
        currentLevel: 1,
        currentSalary: 100000,
      );
      expect(result1.action, EmploymentAction.demotion);

      // Level 0
      final result0 = EmploymentActionResult.calculate(
        productivityScore: 40.0,
        currentLevel: 0,
        currentSalary: 70000,
      );
      expect(result0.action, EmploymentAction.termination);
    });

    test('Score 0 should be Termination', () {
      final result = EmploymentActionResult.calculate(
        productivityScore: 0.0,
        currentLevel: 3,
        currentSalary: 180000,
      );

      expect(result.action, EmploymentAction.termination);
    });

    test('Score 100 should be Promotion', () {
      final result = EmploymentActionResult.calculate(
        productivityScore: 100.0,
        currentLevel: 2,
        currentSalary: 120000,
      );

      expect(result.action, EmploymentAction.promotion);
    });
  });
}