import 'dart:async';

import 'package:alchemist/alchemist.dart';

/// Configure Alchemist for golden tests.
///
/// Only sets CI diffThreshold to allow minor pixel differences.
/// Does NOT apply custom theme to avoid changing image sizes.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return AlchemistConfig.runWithConfig(
    config: const AlchemistConfig(
      ciGoldensConfig: CiGoldensConfig(
        diffThreshold: 0.01, // Allow up to 1% pixel difference
      ),
    ),
    run: testMain,
  );
}
