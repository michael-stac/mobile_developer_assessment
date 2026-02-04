import 'package:json_annotation/json_annotation.dart';

part 'employee.g.dart';

@JsonSerializable()
class Employee {
  final int id;

  @JsonKey(name: 'first_name')
  final String firstName;

  @JsonKey(name: 'last_name')
  final String lastName;

  final String designation;
  final int level;

  @JsonKey(name: 'productivity_score')
  final double productivityScore;

  @JsonKey(name: 'current_salary')
  final String currentSalary;

  @JsonKey(name: 'employment_status')
  final int employmentStatus;

  const Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.designation,
    required this.level,
    required this.productivityScore,
    required this.currentSalary,
    required this.employmentStatus,
  });

  /// Get full name
  String get fullName => '$firstName $lastName';

  /// Get current salary as integer
  int get currentSalaryInt {
    final cleanedSalary = currentSalary.replaceAll(RegExp(r'[\$,\s]'), '');
    return int.tryParse(cleanedSalary) ?? 0;
  }

  /// Check if employee is active
  bool get isActive => employmentStatus == 1;

  factory Employee.fromJson(Map<String, dynamic> json) => _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);

  /// Create a copy with modified fields
  Employee copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? designation,
    int? level,
    double? productivityScore,
    String? currentSalary,
    int? employmentStatus,
  }) {
    return Employee(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      designation: designation ?? this.designation,
      level: level ?? this.level,
      productivityScore: productivityScore ?? this.productivityScore,
      currentSalary: currentSalary ?? this.currentSalary,
      employmentStatus: employmentStatus ?? this.employmentStatus,
    );
  }

  /// Convert to database map
  Map<String, dynamic> toDatabase() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'designation': designation,
      'level': level,
      'productivity_score': productivityScore,
      'current_salary': currentSalary,
      'employment_status': employmentStatus,
    };
  }

  /// Create from database map
  factory Employee.fromDatabase(Map<String, dynamic> map) {
    return Employee(
      id: map['id'] as int,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      designation: map['designation'] as String,
      level: map['level'] as int,
      productivityScore: map['productivity_score'] as double,
      currentSalary: map['current_salary'] as String,
      employmentStatus: map['employment_status'] as int,
    );
  }

  @override
  String toString() {
    return 'Employee{id: $id, name: $fullName, designation: $designation, level: $level, score: $productivityScore}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Employee && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}