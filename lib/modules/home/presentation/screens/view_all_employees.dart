import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/employee_provider.dart';
import '../../../../common/widgets/loading_widget.dart';
import '../../../../common/widgets/empty_state_widget.dart';
import '../../../../common/widgets/error_widget.dart';
import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/app_strings.dart';
import '../widgets/employee_card.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../../../details/presentation/screens/details_screen.dart';

class AllEmployeesScreen extends StatefulWidget {
  const AllEmployeesScreen({Key? key}) : super(key: key);

  @override
  State<AllEmployeesScreen> createState() => _AllEmployeesScreenState();
}

class _AllEmployeesScreenState extends State<AllEmployeesScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A1A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'All Employees',
          style: TextStyle(
            color: Color(0xFF1A1A1A),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: false,
        actions: [
          Consumer<EmployeeProvider>(
            builder: (context, provider, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.filter_list, color: Color(0xFF1A1A1A)),
                    onPressed: () => _showFilterBottomSheet(context),
                    tooltip: AppStrings.filter,
                  ),
                  if (provider.hasActiveFilters)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF9500),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Color(0xFF1A1A1A)),
            onSelected: (value) {
              if (value == 'refresh') {
                context.read<EmployeeProvider>().refresh();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'refresh',
                child: Row(
                  children: [
                    Icon(Icons.refresh, size: 20),
                    SizedBox(width: 12),
                    Text('Refresh Data'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          _buildSearchBar(),
          // Active Filters Chips
          _buildActiveFiltersChips(),
          // API Errors Display
          _buildApiErrors(),
          // Employees List
          Expanded(
            child: _buildEmployeesList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          context.read<EmployeeProvider>().searchEmployees(value);
        },
        decoration: InputDecoration(
          hintText: 'Search by name...',
          hintStyle: const TextStyle(
            color: Color(0xFFAEAEB2),
            fontSize: 15,
          ),
          prefixIcon: const Icon(Icons.search, color: Color(0xFFAEAEB2), size: 20),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.clear, color: Color(0xFFAEAEB2), size: 20),
            onPressed: () {
              _searchController.clear();
              context.read<EmployeeProvider>().searchEmployees('');
            },
          )
              : null,
          filled: true,
          fillColor: const Color(0xFFF8F9FA),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE5E5EA), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE5E5EA), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF007AFF), width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _buildActiveFiltersChips() {
    return Consumer<EmployeeProvider>(
      builder: (context, provider, child) {
        if (!provider.hasActiveFilters) {
          return const SizedBox.shrink();
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: const Color(0xFFF8F9FA),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Active Filters:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF8E8E93),
                    ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () {
                      _searchController.clear();
                      context.read<EmployeeProvider>().clearFilters();
                    },
                    icon: const Icon(Icons.clear_all, size: 16),
                    label: const Text('Clear All'),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFFFF3B30),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  if (provider.selectedDesignation != null)
                    Chip(
                      label: Text(provider.selectedDesignation!),
                      onDeleted: () {
                        context.read<EmployeeProvider>().filterByDesignation(null);
                      },
                      deleteIcon: const Icon(Icons.close, size: 16),
                      backgroundColor: Colors.white,
                    ),
                  if (provider.selectedLevel != null)
                    Chip(
                      label: Text('Level ${provider.selectedLevel}'),
                      onDeleted: () {
                        context.read<EmployeeProvider>().filterByLevel(null);
                      },
                      deleteIcon: const Icon(Icons.close, size: 16),
                      backgroundColor: Colors.white,
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildApiErrors() {
    return Consumer<EmployeeProvider>(
      builder: (context, provider, child) {
        if (!provider.hasErrors) {
          return const SizedBox.shrink();
        }

        return ApiErrorListWidget(
          errors: provider.apiErrors!,
          onDismiss: () {
            context.read<EmployeeProvider>().clearErrors();
          },
        );
      },
    );
  }

  Widget _buildEmployeesList() {
    return Consumer<EmployeeProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading && !provider.hasEmployees) {
          return const LoadingWidget(
            message: AppStrings.loadingEmployees,
          );
        }

        if (provider.state == EmployeeLoadingState.error &&
            !provider.hasEmployees &&
            !provider.hasErrors) {
          return ErrorDisplayWidget(
            message: provider.errorMessage ?? AppStrings.errorLoadingData,
            title: 'Error',
            onRetry: () => provider.loadEmployees(forceRefresh: true),
          );
        }

        if (!provider.hasFilteredEmployees) {
          if (provider.hasActiveFilters) {
            return EmptyStateWidget(
              title: AppStrings.emptyFilterStateTitle,
              message: AppStrings.emptyFilterStateMessage,
              icon: Icons.search_off,
              action: ElevatedButton.icon(
                onPressed: () {
                  _searchController.clear();
                  provider.clearFilters();
                },
                icon: const Icon(Icons.clear_all),
                label: const Text('Clear Filters'),
              ),
            );
          }
          return const EmptyStateWidget(
            title: AppStrings.emptyStateTitle,
            message: AppStrings.emptyStateMessage,
            icon: Icons.people_outline,
          );
        }

        return RefreshIndicator(
          onRefresh: () => provider.refresh(),
          color: const Color(0xFF007AFF),
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: provider.employees.length,
            itemBuilder: (context, index) {
              final employee = provider.employees[index];
              return EmployeeCard(
                employee: employee,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmployeeDetailsScreen(
                        employee: employee,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheet(),
    );
  }
}