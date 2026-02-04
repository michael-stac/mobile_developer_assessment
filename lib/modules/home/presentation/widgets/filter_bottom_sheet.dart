import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/employee_provider.dart';
import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/app_strings.dart';
import '../../../../common/constants/salary_levels.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? _selectedDesignation;
  int? _selectedLevel;

  @override
  void initState() {
    super.initState();
    final provider = context.read<EmployeeProvider>();
    _selectedDesignation = provider.selectedDesignation;
    _selectedLevel = provider.selectedLevel;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<EmployeeProvider>();

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.divider),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.filter_list,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  AppStrings.filterTitle,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
          // Filter Options
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Designation Filter
                Text(
                  AppStrings.filterByDesignation,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                _buildDesignationFilter(provider),
                const SizedBox(height: 24),
                // Level Filter
                Text(
                  AppStrings.filterByLevel,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                _buildLevelFilter(provider),
                const SizedBox(height: 24),
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _selectedDesignation = null;
                            _selectedLevel = null;
                          });
                          provider.clearFilters();
                          Navigator.pop(context);
                        },
                        child: const Text('Clear All'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          provider.filterByDesignation(_selectedDesignation);
                          provider.filterByLevel(_selectedLevel);
                          Navigator.pop(context);
                        },
                        child: const Text('Apply Filters'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesignationFilter(EmployeeProvider provider) {
    final designations = provider.allDesignations;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        // All option
        FilterChip(
          label: const Text(AppStrings.allDesignations),
          selected: _selectedDesignation == null,
          onSelected: (selected) {
            setState(() {
              _selectedDesignation = null;
            });
          },
          selectedColor: AppColors.primary.withOpacity(0.2),
          checkmarkColor: AppColors.primary,
        ),
        // Individual designations
        ...designations.map(
              (designation) => FilterChip(
            label: Text(designation),
            selected: _selectedDesignation == designation,
            onSelected: (selected) {
              setState(() {
                _selectedDesignation = selected ? designation : null;
              });
            },
            selectedColor: AppColors.primary.withOpacity(0.2),
            checkmarkColor: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildLevelFilter(EmployeeProvider provider) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        // All levels option
        FilterChip(
          label: const Text(AppStrings.allLevels),
          selected: _selectedLevel == null,
          onSelected: (selected) {
            setState(() {
              _selectedLevel = null;
            });
          },
          selectedColor: AppColors.primary.withOpacity(0.2),
          checkmarkColor: AppColors.primary,
        ),
        // Individual levels
        for (int level = SalaryLevels.minLevel; level <= SalaryLevels.maxLevel; level++)
          FilterChip(
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColors.getLevelColor(level),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text('Level $level'),
              ],
            ),
            selected: _selectedLevel == level,
            onSelected: (selected) {
              setState(() {
                _selectedLevel = selected ? level : null;
              });
            },
            selectedColor: AppColors.primary.withOpacity(0.2),
            checkmarkColor: AppColors.primary,
          ),
      ],
    );
  }
}