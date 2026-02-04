import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_assessment/core/models/employee.dart';

import '../../features/home/presentation/widgets/employee_card.dart';

void main() {
  group('EmployeeCard Widget Tests', () {
    const testEmployee = Employee(
      id: 1,
      firstName: 'John',
      lastName: 'Doe',
      designation: 'Software Engineer',
      level: 2,
      productivityScore: 85.0,
      currentSalary: '120,000',
      employmentStatus: 1,
    );

    testWidgets('Should display employee name', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EmployeeCard(
              employee: testEmployee,
            ),
          ),
        ),
      );

      expect(find.text('John Doe'), findsOneWidget);
    });

    testWidgets('Should display employee designation', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmployeeCard(
              employee: testEmployee,
            ),
          ),
        ),
      );

      expect(find.text('Software Engineer'), findsOneWidget);
    });

    testWidgets('Should display productivity score', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmployeeCard(
              employee: testEmployee,
            ),
          ),
        ),
      );

      expect(find.text('85.0%'), findsOneWidget);
    });

    testWidgets('Should display employee level', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmployeeCard(
              employee: testEmployee,
            ),
          ),
        ),
      );

      expect(find.text('Level 2'), findsOneWidget);
    });

    testWidgets('Should call onTap when card is tapped', (WidgetTester tester) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmployeeCard(
              employee: testEmployee,
              onTap: () {
                wasTapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(InkWell));
      await tester.pump();

      expect(wasTapped, true);
    });

    testWidgets('Should render with different productivity scores', (WidgetTester tester) async {
      final lowScoreEmployee = testEmployee.copyWith(productivityScore: 35.0);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmployeeCard(
              employee: lowScoreEmployee,
            ),
          ),
        ),
      );

      expect(find.text('35.0%'), findsOneWidget);
    });

    testWidgets('Should display View Details button', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmployeeCard(
              employee: testEmployee,
            ),
          ),
        ),
      );

      expect(find.text('View Details'), findsOneWidget);
    });
  });
}