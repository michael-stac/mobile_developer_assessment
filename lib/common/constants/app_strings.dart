class AppStrings {
  AppStrings._();

  /// App Info
  static const String appName = 'XYZ Inc. Portal';
  static const String appVersion = '1.0.0';

  /// Screen Titles
  static const String homeTitle = 'Employee Management';
  static const String detailsTitle = 'Employee Details';
  static const String filterTitle = 'Filter Employees';

  /// Actions
  static const String refresh = 'Refresh';
  static const String filter = 'Filter';
  static const String clearFilter = 'Clear Filter';
  static const String apply = 'Apply';
  static const String cancel = 'Cancel';
  static const String search = 'Search';
  static const String viewDetails = 'View Details';

  /// Employment Actions
  static const String promotion = 'Promotion';
  static const String demotion = 'Demotion';
  static const String termination = 'Termination';
  static const String noChange = 'No Change';

  /// Labels
  static const String employeeId = 'Employee ID';
  static const String firstName = 'First Name';
  static const String lastName = 'Last Name';
  static const String fullName = 'Full Name';
  static const String designation = 'Designation';
  static const String level = 'Level';
  static const String currentSalary = 'Current Salary';
  static const String newSalary = 'New Salary';
  static const String productivityScore = 'Productivity Score';
  static const String employmentStatus = 'Employment Status';
  static const String action = 'Action';

  /// Filter Options
  static const String filterByName = 'Filter by Name';
  static const String filterByDesignation = 'Filter by Designation';
  static const String filterByLevel = 'Filter by Level';
  static const String allLevels = 'All Levels';
  static const String allDesignations = 'All Designations';

  /// Status Messages
  static const String loading = 'Loading...';
  static const String loadingEmployees = 'Loading employees...';
  static const String noEmployeesFound = 'No employees found';
  static const String noEmployeesMatchFilter =
      'No employees match your filter criteria';
  static const String errorLoadingData = 'Error loading employee data';
  static const String dataLoadedSuccessfully =
      'Employee data loaded successfully';
  static const String dataSavedLocally = 'Data saved to local database';

  /// Error Messages
  static const String errorOccurred = 'An error occurred';
  static const String errorFetchingData = 'Error fetching employee data';
  static const String errorSavingData = 'Error saving data to database';
  static const String errorCalculating = 'Error calculating employment action';
  static const String tryAgain = 'Try Again';

  /// Productivity Score Ranges
  static const String scoreExcellent = 'Excellent (80-100)';
  static const String scoreGood = 'Good (50-79)';
  static const String scorePoor = 'Poor (40-49)';
  static const String scoreFailing = 'Failing (0-39)';

  /// Employment Action Descriptions
  static const String promotionDesc =
      'Employee will be promoted to the next level with a salary increase';
  static const String demotionDesc =
      'Employee will be demoted to the previous level with a salary reduction';
  static const String terminationDesc =
      'Employee will be terminated from the company';
  static const String noChangeDesc = 'Employee status remains unchanged';
  static const String level0TerminationNote =
      'Level 0 employees cannot be demoted and will be terminated if score is below 40';

  /// Salary Format
  static const String salaryPrefix = '\$';
  static const String salarySuffix = '';

  /// Empty State Messages
  static const String emptyStateTitle = 'No Employees';
  static const String emptyStateMessage =
      'There are no employees in the system yet';
  static const String emptyFilterStateTitle = 'No Results';
  static const String emptyFilterStateMessage = 'Try adjusting your filters';

  /// Database Messages
  static const String databaseInitialized = 'Database initialized successfully';
  static const String databaseError = 'Database error occurred';
}
