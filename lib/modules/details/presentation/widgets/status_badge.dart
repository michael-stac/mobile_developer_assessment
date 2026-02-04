import 'package:flutter/material.dart';
import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/salary_levels.dart';

class StatusBadge extends StatelessWidget {
  final EmploymentAction action;

  const StatusBadge({
    Key? key,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    final icon = _getIcon();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            action.displayName,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor() {
    switch (action) {
      case EmploymentAction.promotion:
        return AppColors.promoted;
      case EmploymentAction.demotion:
        return AppColors.demoted;
      case EmploymentAction.termination:
        return AppColors.terminated;
      case EmploymentAction.noChange:
        return AppColors.noChange;
    }
  }

  IconData _getIcon() {
    switch (action) {
      case EmploymentAction.promotion:
        return Icons.arrow_upward;
      case EmploymentAction.demotion:
        return Icons.arrow_downward;
      case EmploymentAction.termination:
        return Icons.cancel;
      case EmploymentAction.noChange:
        return Icons.check_circle;
    }
  }
}