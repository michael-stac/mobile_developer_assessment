// import 'package:flutter/material.dart';
// import '../../../../common/constants/app_colors.dart';
// import '../../../../common/constants/salary_levels.dart';
// import '../../../../core/models/employee.dart';
//
//
// /// Reusable employee card widget
// class EmployeeCard extends StatelessWidget {
//   final Employee employee;
//   final VoidCallback? onTap;
//
//   const EmployeeCard({
//     Key? key,
//     required this.employee,
//     this.onTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final scoreColor = AppColors.getScoreColor(employee.productivityScore);
//     final levelColor = AppColors.getLevelColor(employee.level);
//
//     return Card(
//       elevation: 2,
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(12),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header Row - Name and Level Badge
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           employee.fullName,
//                           style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           employee.designation,
//                           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                             color: AppColors.textSecondary,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Level Badge
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: levelColor.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(color: levelColor, width: 1.5),
//                     ),
//                     child: Text(
//                       'Level ${employee.level}',
//                       style: TextStyle(
//                         color: levelColor,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               const Divider(height: 1),
//               const SizedBox(height: 12),
//               // Details Row
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Productivity Score
//                   Expanded(
//                     child: _DetailItem(
//                       icon: Icons.analytics_outlined,
//                       label: 'Score',
//                       value: '${employee.productivityScore.toStringAsFixed(1)}%',
//                       color: scoreColor,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   // Salary
//                   Expanded(
//                     child: _DetailItem(
//                       icon: Icons.attach_money,
//                       label: 'Salary',
//                       value: SalaryLevels.formatSalary(employee.currentSalaryInt),
//                       color: AppColors.primary,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               // View Details Button
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton.icon(
//                   onPressed: onTap,
//                   icon: const Icon(Icons.arrow_forward, size: 16),
//                   label: const Text('View Details'),
//                   style: TextButton.styleFrom(
//                     foregroundColor: AppColors.primary,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _DetailItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String value;
//   final Color color;
//
//   const _DetailItem({
//     Key? key,
//     required this.icon,
//     required this.label,
//     required this.value,
//     required this.color,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Icon(
//             icon,
//             size: 20,
//             color: color,
//           ),
//         ),
//         const SizedBox(width: 8),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: const TextStyle(
//                   fontSize: 11,
//                   color: AppColors.textSecondary,
//                 ),
//               ),
//               const SizedBox(height: 2),
//               Text(
//                 value,
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   color: color,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }



import 'package:flutter/material.dart';
import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/salary_levels.dart';
import '../../../../core/models/employee.dart';

/// Redesigned employee card widget with modern aesthetics
class EmployeeCard extends StatelessWidget {
  final Employee employee;
  final VoidCallback? onTap;

  const EmployeeCard({
    Key? key,
    required this.employee,
    this.onTap,
  }) : super(key: key);

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

  Color _getScoreColor(double score) {
    if (score >= 80) return const Color(0xFF34C759);
    if (score >= 60) return const Color(0xFFFFCC00);
    if (score >= 40) return const Color(0xFFFF9500);
    return const Color(0xFFFF3B30);
  }

  @override
  Widget build(BuildContext context) {
    final levelColor = _getLevelColor(employee.level);
    final scoreColor = _getScoreColor(employee.productivityScore);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Name and Level Badge
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            employee.fullName,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A1A1A),
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            employee.designation,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF8E8E93),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Level Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: levelColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: levelColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'Level ${employee.level}',
                        style: TextStyle(
                          color: levelColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Divider
                Container(
                  height: 1,
                  color: const Color(0xFFF2F2F7),
                ),
                const SizedBox(height: 16),
                // Stats Row
                Row(
                  children: [
                    // Score
                    Expanded(
                      child: _StatItem(
                        icon: Icons.analytics_outlined,
                        iconColor: scoreColor,
                        label: 'Score',
                        value: '${employee.productivityScore.toStringAsFixed(1)}%',
                        valueColor: scoreColor,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: const Color(0xFFF2F2F7),
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    // Salary
                    Expanded(
                      child: _StatItem(
                        icon: Icons.attach_money,
                        iconColor: const Color(0xFF007AFF),
                        label: 'Salary',
                        value: SalaryLevels.formatSalary(employee.currentSalaryInt),
                        valueColor: const Color(0xFF007AFF),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // View Details Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: onTap,
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF007AFF),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'View Details',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final Color valueColor;

  const _StatItem({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 18,
            color: iconColor,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF8E8E93),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: valueColor,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}