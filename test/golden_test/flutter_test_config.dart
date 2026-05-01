import 'dart:async';
import 'dart:io';

import 'package:alchemist/alchemist.dart';

/// Check if running in CI environment
bool get _isRunningInCi => Platform.environment['CI'] == 'true';

/// Configure Alchemist for golden tests.
///
/// - CI environment: Only CI goldens are enabled (platform goldens disabled)
/// - Local environment: Only platform goldens are enabled (CI goldens disabled)
///
/// CI goldens use Ahem font and obscured text for consistent cross-platform results.
/// Allows up to 1% pixel difference in CI to account for minor rendering variations.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return AlchemistConfig.runWithConfig(
    config: AlchemistConfig(
      ciGoldensConfig: CiGoldensConfig(
        enabled: _isRunningInCi,
        diffThreshold: 0.01, // Allow up to 1% pixel difference
      ),
      platformGoldensConfig: PlatformGoldensConfig(
        enabled: !_isRunningInCi,
      ),
    ),
    run: testMain,
  );
}
