import 'package:flutter/material.dart';
import '../../../../core/models/employee.dart';
import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/salary_levels.dart';
import '../widgets/action_button.dart';
import '../widgets/info_card.dart';
import '../widgets/productivity_meter.dart';
import '../widgets/status_badge.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  final Employee employee;

  const EmployeeDetailsScreen({
    Key? key,
    required this.employee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate employment action
    final actionResult = EmploymentActionResult.calculate(
      productivityScore: employee.productivityScore,
      currentLevel: employee.level,
      currentSalary: employee.currentSalaryInt,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Card
            _buildHeaderCard(context, actionResult),
            const SizedBox(height: 16),
            // Productivity Meter
            ProductivityMeter(score: employee.productivityScore),
            const SizedBox(height: 16),
            // Current Information
            _buildSectionTitle(context, 'Current Information'),
            InfoCard(
              icon: Icons.badge_outlined,
              label: 'Employee ID',
              value: '#${employee.id}',
              color: AppColors.primary,
            ),
            InfoCard(
              icon: Icons.business_center_outlined,
              label: 'Designation',
              value: employee.designation,
              color: AppColors.secondary,
            ),
            InfoCard(
              icon: Icons.trending_up_outlined,
              label: 'Current Level',
              value: 'Level ${employee.level} - ${SalaryLevels.getLevelDescription(employee.level)}',
              color: AppColors.getLevelColor(employee.level),
            ),
            InfoCard(
              icon: Icons.attach_money_outlined,
              label: 'Current Salary',
              value: SalaryLevels.formatSalary(employee.currentSalaryInt),
              color: AppColors.success,
            ),
            const SizedBox(height: 16),
            // Employment Action
            _buildSectionTitle(context, 'Employment Action'),
            _buildActionCard(context, actionResult),
            const SizedBox(height: 16),
            // New Information (if changed)
            if (actionResult.hasLevelChange || actionResult.hasSalaryChange) ...[
              _buildSectionTitle(context, 'After Action'),
              if (actionResult.action != EmploymentAction.termination)
                InfoCard(
                  icon: Icons.trending_up_outlined,
                  label: 'New Level',
                  value: 'Level ${actionResult.newLevel} - ${SalaryLevels.getLevelDescription(actionResult.newLevel)}',
                  color: AppColors.getLevelColor(actionResult.newLevel),
                ),
              InfoCard(
                icon: Icons.attach_money_outlined,
                label: 'New Salary',
                value: actionResult.action == EmploymentAction.termination
                    ? 'N/A'
                    : SalaryLevels.formatSalary(actionResult.newSalary),
                color: actionResult.isPositive ? AppColors.success : AppColors.error,
              ),
              if (actionResult.hasSalaryChange &&
                  actionResult.action != EmploymentAction.termination)
                InfoCard(
                  icon: Icons.trending_up_outlined,
                  label: 'Salary Change',
                  value: '${actionResult.salaryChange >= 0 ? '+' : ''}${SalaryLevels.formatSalary(actionResult.salaryChange.abs())} (${actionResult.salaryChangePercentage.toStringAsFixed(1)}%)',
                  color: actionResult.salaryChange >= 0
                      ? AppColors.success
                      : AppColors.error,
                ),
              const SizedBox(height: 16),
            ],
            // Special Note for Level 0
            if (employee.level == 0 &&
                employee.productivityScore < SalaryLevels.noChangeThresholdLow)
              _buildSpecialNote(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context, EmploymentActionResult actionResult) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile Icon
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              size: 48,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          // Employee Name
          Text(
            employee.fullName,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          // Designation
          Text(
            employee.designation,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Status Badge
          StatusBadge(action: actionResult.action),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, EmploymentActionResult actionResult) {
    final actionColor = AppColors.getActionColor(actionResult.action.displayName);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: actionColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: actionColor.withOpacity(0.3), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: actionColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getActionIcon(actionResult.action),
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      actionResult.action.displayName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: actionColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getActionSubtitle(actionResult),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 12),
          // Description
          Text(
            actionResult.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          // Explanation
          Text(
            actionResult.action.description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              fontStyle: FontStyle.italic,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialNote(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.warning.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.warning.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            color: AppColors.warning,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Special Note: Level 0 employees cannot be demoted. With a productivity score below 40%, this employee will be terminated.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textPrimary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getActionIcon(EmploymentAction action) {
    switch (action) {
      case EmploymentAction.promotion:
        return Icons.trending_up;
      case EmploymentAction.demotion:
        return Icons.trending_down;
      case EmploymentAction.termination:
        return Icons.close;
      case EmploymentAction.noChange:
        return Icons.check;
    }
  }

  String _getActionSubtitle(EmploymentActionResult result) {
    switch (result.action) {
      case EmploymentAction.promotion:
        return 'Congratulations! Performance score: ${result.productivityScore}%';
      case EmploymentAction.demotion:
        return 'Below expectations. Performance score: ${result.productivityScore}%';
      case EmploymentAction.termination:
        return 'Insufficient performance. Score: ${result.productivityScore}%';
      case EmploymentAction.noChange:
        return 'Satisfactory performance. Score: ${result.productivityScore}%';
    }
  }
}