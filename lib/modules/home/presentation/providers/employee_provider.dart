import 'package:flutter/foundation.dart';

import '../../../../common/io/data.dart';
import '../../../../core/database/database_helper.dart';
import '../../../../core/models/employee.dart';

enum EmployeeLoadingState {
  initial,
  loading,
  loaded,
  error,
}

class EmployeeProvider extends ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // State
  EmployeeLoadingState _state = EmployeeLoadingState.initial;
  List<Employee> _employees = [];
  List<Employee> _filteredEmployees = [];
  String? _errorMessage;
  List<Map<String, dynamic>>? _apiErrors;

  // Filters
  String _searchQuery = '';
  String? _selectedDesignation;
  int? _selectedLevel;

  // Getters
  EmployeeLoadingState get state => _state;
  List<Employee> get employees => _filteredEmployees;
  List<Employee> get allEmployees => _employees;
  String? get errorMessage => _errorMessage;
  List<Map<String, dynamic>>? get apiErrors => _apiErrors;
  bool get hasErrors => _apiErrors != null && _apiErrors!.isNotEmpty;
  bool get isLoading => _state == EmployeeLoadingState.loading;
  bool get hasEmployees => _employees.isNotEmpty;
  bool get hasFilteredEmployees => _filteredEmployees.isNotEmpty;

  String get searchQuery => _searchQuery;
  String? get selectedDesignation => _selectedDesignation;
  int? get selectedLevel => _selectedLevel;
  bool get hasActiveFilters =>
      _searchQuery.isNotEmpty ||
          _selectedDesignation != null ||
          _selectedLevel != null;

  /// Load employees from API and save to local database
  Future<void> loadEmployees({bool forceRefresh = false}) async {
    try {
      _state = EmployeeLoadingState.loading;
      _errorMessage = null;
      _apiErrors = null;
      notifyListeners();

      // Try to load from local database first (if not forcing refresh)
      if (!forceRefresh) {
        final localEmployees = await _databaseHelper.getAllEmployees();
        if (localEmployees.isNotEmpty) {
          _employees = localEmployees;
          _applyFilters();
          _state = EmployeeLoadingState.loaded;
          notifyListeners();
        }
      }

      // Simulate API call (using local Api class)
      await Future.delayed(const Duration(milliseconds: 500));

      // Parse success response
      final response = Api.successResponse;
      if (response['statusCode'] == 200) {
        final List<dynamic> data = response['data'] as List<dynamic>;
        final employees = data
            .map((json) => Employee.fromJson(json as Map<String, dynamic>))
            .toList();

        // Save to local database
        await _databaseHelper.deleteAllEmployees();
        await _databaseHelper.insertEmployees(employees);

        _employees = employees;
        _applyFilters();
        _state = EmployeeLoadingState.loaded;
        _errorMessage = null;
      } else {
        throw Exception('Failed to load employees');
      }

      notifyListeners();
    } catch (e) {
      _state = EmployeeLoadingState.error;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  /// Simulate error response from API
  Future<void> simulateErrorResponse() async {
    try {
      _state = EmployeeLoadingState.loading;
      _errorMessage = null;
      _apiErrors = null;
      notifyListeners();

      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));

      // Parse error response
      final response = Api.errorRexponse;
      _state = EmployeeLoadingState.error;
      _errorMessage = response['message'] as String;
      _apiErrors = (response['errors'] as List<dynamic>)
          .cast<Map<String, dynamic>>();

      notifyListeners();
    } catch (e) {
      _state = EmployeeLoadingState.error;
      _errorMessage = 'Failed to simulate error: ${e.toString()}';
      notifyListeners();
    }
  }

  /// Search employees by name
  void searchEmployees(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
    notifyListeners();
  }

  /// Filter by designation
  void filterByDesignation(String? designation) {
    _selectedDesignation = designation;
    _applyFilters();
    notifyListeners();
  }

  /// Filter by level
  void filterByLevel(int? level) {
    _selectedLevel = level;
    _applyFilters();
    notifyListeners();
  }

  /// Clear all filters
  void clearFilters() {
    _searchQuery = '';
    _selectedDesignation = null;
    _selectedLevel = null;
    _applyFilters();
    notifyListeners();
  }

  /// Apply all active filters
  void _applyFilters() {
    _filteredEmployees = _employees.where((employee) {
      // Search filter
      if (_searchQuery.isNotEmpty) {
        final fullName = employee.fullName.toLowerCase();
        if (!fullName.contains(_searchQuery)) {
          return false;
        }
      }

      // Designation filter
      if (_selectedDesignation != null && _selectedDesignation!.isNotEmpty) {
        if (employee.designation != _selectedDesignation) {
          return false;
        }
      }

      // Level filter
      if (_selectedLevel != null) {
        if (employee.level != _selectedLevel) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  /// Get all unique designations
  List<String> get allDesignations {
    final designations = _employees.map((e) => e.designation).toSet().toList();
    designations.sort();
    return designations;
  }

  /// Get all unique levels
  List<int> get allLevels {
    final levels = _employees.map((e) => e.level).toSet().toList();
    levels.sort();
    return levels;
  }

  /// Clear error state
  void clearErrors() {
    _apiErrors = null;
    _errorMessage = null;
    notifyListeners();
  }

  /// Refresh employees
  Future<void> refresh() async {
    await loadEmployees(forceRefresh: true);
  }
}