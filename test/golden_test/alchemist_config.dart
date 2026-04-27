import 'dart:io';

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';

/// Build golden test theme
GoldenTestTheme buildGoldenTestTheme() {
  return GoldenTestTheme(
    backgroundColor: const Color(0xFFFFFFFF),
    borderColor: const Color(0xFFE0E0E0),
    nameTextStyle: const TextStyle(
      fontSize: 12,
      color: Colors.black87,
      fontWeight: FontWeight.bold,
    ),
  );
}

/// Check if running in CI environment
bool get isRunningInCi => Platform.environment['CI'] == 'true';

/// Build Alchemist configuration
/// 
/// Platform-specific goldens are disabled in CI to ensure consistent results.
AlchemistConfig buildAlchemistConfig() {
  return AlchemistConfig(
    goldenTestTheme: buildGoldenTestTheme(),
    platformGoldensConfig: PlatformGoldensConfig(
      enabled: !isRunningInCi,
    ),
  );
}

/// Wrapper widget for golden tests that provides necessary context
class GoldenTestWrapper extends StatelessWidget {
  const GoldenTestWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: child,
        ),
      ),
    );
  }
}
