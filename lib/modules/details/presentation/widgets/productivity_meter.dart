import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../../common/constants/app_colors.dart';

class ProductivityMeter extends StatelessWidget {
  final double score;

  const ProductivityMeter({
    Key? key,
    required this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = AppColors.getScoreColor(score);
    final percentage = score / 100;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Productivity Score',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          // Circular Progress
          SizedBox(
            width: 200,
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background Circle
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: 1.0,
                    strokeWidth: 20,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.divider,
                    ),
                  ),
                ),
                // Progress Circle
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: percentage,
                    strokeWidth: 20,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
                // Score Text
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${score.toStringAsFixed(1)}%',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getScoreLabel(score),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Score Range Indicator
          _buildScoreRanges(context),
        ],
      ),
    );
  }

  Widget _buildScoreRanges(BuildContext context) {
    return Column(
      children: [
        _buildScoreRange(
          context,
          '80 - 100',
          'Promotion',
          AppColors.scoreExcellent,
          score >= 80,
        ),
        const SizedBox(height: 8),
        _buildScoreRange(
          context,
          '50 - 79',
          'No Change',
          AppColors.scoreGood,
          score >= 50 && score < 80,
        ),
        const SizedBox(height: 8),
        _buildScoreRange(
          context,
          '40 - 49',
          'Demotion',
          AppColors.scorePoor,
          score >= 40 && score < 50,
        ),
        const SizedBox(height: 8),
        _buildScoreRange(
          context,
          '0 - 39',
          'Termination',
          AppColors.scoreFailing,
          score < 40,
        ),
      ],
    );
  }

  Widget _buildScoreRange(
      BuildContext context,
      String range,
      String label,
      Color color,
      bool isActive,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isActive ? color.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isActive ? color : AppColors.borderLight,
          width: isActive ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            range,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? color : AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? color : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  String _getScoreLabel(double score) {
    if (score >= 80) return 'Excellent';
    if (score >= 50) return 'Good';
    if (score >= 40) return 'Poor';
    return 'Failing';
  }
}