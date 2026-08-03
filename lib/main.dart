import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants/app_colors.dart';
import 'models/user.dart';
import 'providers/auth_provider.dart';
import 'providers/course_provider.dart';
import 'providers/language_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/login_screen.dart';
import 'screens/student/student_dashboard_screen.dart';
import 'screens/faculty/faculty_dashboard_screen.dart';
import 'screens/dept_admin/dept_admin_dashboard_screen.dart';
import 'screens/super_admin/super_admin_dashboard_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CourseProvider()),
      ],
      child: const AlagappaNMEApp(),
    ),
  );
}

class AlagappaNMEApp extends StatelessWidget {
  const AlagappaNMEApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final textTheme = GoogleFonts.interTextTheme();

    return MaterialApp(
      title: 'Alagappa University NME Portal',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.royalBlue,
          primary: AppColors.royalBlue,
          secondary: AppColors.warmGold,
          surface: AppColors.cardLight,
        ),
        textTheme: textTheme,
        scaffoldBackgroundColor: AppColors.backgroundLight,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.royalBlue,
          brightness: Brightness.dark,
          primary: AppColors.royalBlue,
          secondary: AppColors.warmGold,
          surface: AppColors.cardDark,
        ),
        textTheme: textTheme.apply(bodyColor: AppColors.textLight, displayColor: AppColors.textLight),
        scaffoldBackgroundColor: AppColors.backgroundDark,
      ),
      home: const RootNavigator(),
    );
  }
}

class RootNavigator extends StatelessWidget {
  const RootNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    if (!auth.isAuthenticated || auth.currentUser == null) {
      return const LoginScreen();
    }

    switch (auth.currentUser!.role) {
      case UserRole.SUPER_ADMIN:
        return const SuperAdminDashboardScreen();
      case UserRole.DEPT_ADMIN:
        return const DeptAdminDashboardScreen();
      case UserRole.FACULTY:
        return const FacultyDashboardScreen();
      case UserRole.STUDENT:
        return const StudentDashboardScreen();
    }
  }
}
