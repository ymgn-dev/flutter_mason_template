import 'package:mason/mason.dart';

import 'utils/add_dependencies.dart';

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

  await addDependencies(context, packages: packages);
  await addDependencies(context, packages: devPackages, isDev: true);
}
