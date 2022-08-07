import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  await _removeFiles(context, '.gitkeep');
  await _installDependencies(context);
  await _copyGeneratedFilesToLib(context);
}

Future<void> _removeFiles(HookContext context, String name) async {
  final removingFiles = context.logger.progress('removing .gitkeep ...');
  final dir = Directory('.');
  await dir
      .list(recursive: true)
      .where((element) => element.toString().contains(name))
      .listen(
        (element) => element.delete(),
        onDone: () => removingFiles.complete('.gitkeep files removed!'),
      );
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

Future<void> _copyGeneratedFilesToLib(HookContext context) async {
  final copyFiles = context.logger.progress('Copying files to lib...');

  final dir = Directory('.');
  final files = await dir.list().map((element) => element.toString()).toList();

  final result = await Process.run('mv', [
    ...files,
    './{{name}}/lib/',
  ]);
  if (result.exitCode == 0) {
    copyFiles.complete('Files copied successfully');
  } else {
    context.logger.err(result.stderr);
  }
}
