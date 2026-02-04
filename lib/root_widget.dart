import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/theme/app_theme.dart';
import 'common/constants/app_strings.dart';
import 'modules/home/presentation/providers/employee_provider.dart';
import 'modules/home/presentation/screens/home_screen.dart';

class MobileAssessmentApp extends StatelessWidget {
  final bool isDebug;

  const MobileAssessmentApp({
    Key? key,
    this.isDebug = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => EmployeeProvider(),
        ),
        // Add more providers here as needed
      ],
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: isDebug,
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),

      ),
    );
  }
}