import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final logger = context.logger.progress('Creating app');
  try {
    await _createApp(context);
    logger.complete('Successfully created');
  } catch (e) {
    logger.fail('Failed to create the app');
  }
}

Future<ProcessResult> _createApp(HookContext context) async {
  context.logger.info('Running flutter create...');
  final name = context.vars['name'];
  final description = context.vars['description'];
  final org = context.vars['org'];
  return Process.run(
    'flutter',
    ['create', '$name', '--description', '$description', '--org', '$org'],
  );
}
