import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  await _createApp(context);
}

Future<bool> _createApp(HookContext context) async {
  final logger = context.logger.progress('Creating app...');
  try {
    final name = context.vars['name'] as String;
    final description = context.vars['description'] as String;
    final org = context.vars['org'] as String;
    Process.run(
      'flutter',
      ['create', '$name', '--description', '$description', '--org', '$org'],
    );
    logger.complete('Successfully created.');
    return true;
  } on Exception catch (_) {
    logger.fail('Failed to create the app.');
    return false;
  }
}
