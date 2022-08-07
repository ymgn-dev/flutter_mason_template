import 'dart:io';

import 'package:mason/mason.dart';

Future<void> addDependencies(
  HookContext context, {
  required List<String> packages,
  bool isDev = false,
}) async {
  final install = context.logger.progress(
    isDev ? 'Installing dev dependencies...' : 'Installing dependencies...',
  );

  final result = await Process.run(
    'flutter',
    ['pub', 'add', if (isDev) '--dev', ...packages],
    workingDirectory: './{{name}}',
  );

  result.exitCode == 0
      ? install.complete('Successfully installed!')
      : install.fail(result.stderr);
}
