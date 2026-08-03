import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:alagappa_nme_flutter/main.dart';
import 'package:alagappa_nme_flutter/providers/theme_provider.dart';
import 'package:alagappa_nme_flutter/providers/language_provider.dart';
import 'package:alagappa_nme_flutter/providers/auth_provider.dart';
import 'package:alagappa_nme_flutter/providers/course_provider.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app with required providers and trigger a frame.
    await tester.pumpWidget(
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

    await tester.pumpAndSettle();

    // Verify that login screen or app title renders.
    expect(find.textContaining('Alagappa'), findsWidgets);
  });
}
