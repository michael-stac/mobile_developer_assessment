import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/models/employee.dart';
import '../../../../common/constants/salary_levels.dart';
import '../../domain/usecases/calculate_employment_action_usecase.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  final Employee employee;

  const EmployeeDetailsScreen({
    Key? key,
    required this.employee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final actionResult = EmploymentActionResult.calculate(
      productivityScore: employee.productivityScore,
      currentLevel: employee.level,
      currentSalary: employee.currentSalaryInt,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor:  Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: _buildHeader(context, actionResult),
            ),
          ),
          // Content
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 24),

                  _buildPerformanceSection(context),
                  const SizedBox(height: 16),

                  _buildSalarySection(context, actionResult),
                  const SizedBox(height: 16),

                  _buildEmploymentActionSection(context, actionResult),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, EmploymentActionResult actionResult) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
      decoration: const BoxDecoration(
        color: Color(0xFF2C3E50),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Profile Icon
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          // Employee Name
          Text(
            employee.fullName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          // Designation
          Text(
            employee.designation,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          // Status Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: _getActionColor(actionResult.action).withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _getActionColor(actionResult.action).withOpacity(0.4),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getActionIcon(actionResult.action),
                  color: _getActionColor(actionResult.action),
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  actionResult.action.displayName,
                  style: TextStyle(
                    color: _getActionColor(actionResult.action),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceSection(BuildContext context) {
    // Mock data for 6 months performance
    final performanceData = [
      65.0, // Month 1
      70.0, // Month 2
      68.0, // Month 3
      72.0, // Month 4
      75.0, // Month 5
      employee.productivityScore, // Month 6 (current)
    ];

    final trend = employee.productivityScore - performanceData[0];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF007AFF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.trending_up,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Performance Score',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Last 6 months',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8E8E93),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${employee.productivityScore.toStringAsFixed(1)}%',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A1A),
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Current Score',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF8E8E93),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        trend >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
                        size: 14,
                        color: trend >= 0 ? const Color(0xFF34C759) : const Color(0xFFFF3B30),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${trend >= 0 ? '+' : ''}${trend.toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: trend >= 0 ? const Color(0xFF34C759) : const Color(0xFFFF3B30),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'vs 6 months ago',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF8E8E93),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                height: 60,
                width: 140,
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    minX: 0,
                    maxX: 5,
                    minY: performanceData.reduce((a, b) => a < b ? a : b) - 5,
                    maxY: performanceData.reduce((a, b) => a > b ? a : b) + 5,
                    lineBarsData: [
                      LineChartBarData(
                        spots: List.generate(
                          performanceData.length,
                              (index) => FlSpot(index.toDouble(), performanceData[index]),
                        ),
                        isCurved: true,
                        color: const Color(0xFF007AFF),
                        barWidth: 2.5,
                        isStrokeCapRound: true,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                    lineTouchData: const LineTouchData(enabled: false),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildInfoPill(
                  'Employee ID',
                  '#${employee.id}',
                  const Color(0xFF007AFF),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildInfoPill(
                  'Level',
                  'Level ${employee.level}',
                  _getLevelColor(employee.level),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSalarySection(BuildContext context, EmploymentActionResult actionResult) {
    final salaryChange = actionResult.newSalary - employee.currentSalaryInt;
    final hasChange = salaryChange != 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF34C759),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.attach_money,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Salary Information',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Current & projected',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8E8E93),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      SalaryLevels.formatSalary(employee.currentSalaryInt),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A1A),
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Current Salary',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF8E8E93),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (hasChange)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: salaryChange >= 0
                        ? const Color(0xFF34C759).withOpacity(0.1)
                        : const Color(0xFFFF3B30).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        salaryChange >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
                        size: 14,
                        color: salaryChange >= 0
                            ? const Color(0xFF34C759)
                            : const Color(0xFFFF3B30),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${actionResult.salaryChangePercentage.toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: salaryChange >= 0
                              ? const Color(0xFF34C759)
                              : const Color(0xFFFF3B30),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          if (hasChange) ...[
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'After Action',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF8E8E93),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  actionResult.action == EmploymentAction.termination
                      ? 'Terminated'
                      : SalaryLevels.formatSalary(actionResult.newSalary),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: actionResult.action == EmploymentAction.termination
                        ? const Color(0xFFFF3B30)
                        : const Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Change Amount',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF8E8E93),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  actionResult.action == EmploymentAction.termination
                      ? 'N/A'
                      : '${salaryChange >= 0 ? '+' : ''}${SalaryLevels.formatSalary(salaryChange.abs())}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: salaryChange >= 0
                        ? const Color(0xFF34C759)
                        : const Color(0xFFFF3B30),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmploymentActionSection(BuildContext context, EmploymentActionResult actionResult) {
    final actionColor = _getActionColor(actionResult.action);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
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
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  _getActionIcon(actionResult.action),
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Employment Action',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Recommended action',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8E8E93),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            actionResult.action.displayName,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: actionColor,
              height: 1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _getActionSubtitle(actionResult),
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF8E8E93),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 12),
          Text(
            actionResult.description,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: actionColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 18,
                  color: actionColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    actionResult.action.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: actionColor,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (actionResult.hasLevelChange) ...[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Current Level',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8E8E93),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Level ${employee.level}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.grey[400],
                  size: 24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'New Level',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8E8E93),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      actionResult.action == EmploymentAction.termination
                          ? 'N/A'
                          : 'Level ${actionResult.newLevel}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: actionResult.action == EmploymentAction.termination
                            ? const Color(0xFFFF3B30)
                            : actionColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoPill(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Color _getLevelColor(int level) {
    switch (level) {
      case 0:
        return const Color(0xFF8E8E93);
      case 1:
        return const Color(0xFF34C759);
      case 2:
        return const Color(0xFF007AFF);
      case 3:
        return const Color(0xFFAF52DE);
      case 4:
        return const Color(0xFFFF9500);
      case 5:
        return const Color(0xFFFF3B30);
      default:
        return const Color(0xFF8E8E93);
    }
  }

  Color _getActionColor(EmploymentAction action) {
    switch (action) {
      case EmploymentAction.promotion:
        return const Color(0xFF34C759);
      case EmploymentAction.demotion:
        return const Color(0xFFFF9500);
      case EmploymentAction.termination:
        return const Color(0xFFFF3B30);
      case EmploymentAction.noChange:
        return const Color(0xFF007AFF);
    }
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