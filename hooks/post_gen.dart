import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  await _installDependencies(context);
}

Future<void> _installDependencies(HookContext context) async {
  final install = context.logger.progress('Installing dependencies...');
  var result = await Process.run(
    'flutter',
    [
      'pub',
      'add',
      'get_it',
    ],
    workingDirectory: './{{name}}',
  );
  if (result.exitCode == 0) {
    install.complete('Dependencies installed!');
  } else {
    context.logger.err(result.stderr);
  }
}
