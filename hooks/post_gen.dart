import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final packages = [
    'flutter_hooks',
    'hooks_riverpod',
    'freezed_annotation',
    'json_annotation',
  ];
  final devPackages = [
    'build_runner',
    'freezed',
    'json_serializable',
    'pedantic_mono',
  ];

  await _addDependencies(context, packages: packages);
  await _addDependencies(context, packages: devPackages, isDev: true);
}

Future<void> _addDependencies(
  HookContext context, {
  required List<String> packages,
  bool isDev = false,
}) async {
  final logger = context.logger.progress(
    isDev ? 'Installing dev dependencies...' : 'Installing dependencies...',
  );

  final result = await Process.run(
    'flutter',
    ['pub', 'add', if (isDev) '--dev', ...packages],
    workingDirectory: './{{name}}',
  );

  result.exitCode == 0
      ? logger.complete('Successfully installed!')
      : logger.fail(result.stderr);
}
