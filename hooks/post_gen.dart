import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final useL10n = context.vars['use_l10n'] as bool;
  if (useL10n) {
    _setupL10n(context);
  }
}

Future<void> _setupL10n(HookContext context) async {
  final name = context.vars['name'] as String;
  final flutterProjRoot = Directory('${name}');

  await File('${flutterProjRoot.absolute.path}/l10n.yaml')
      .create(recursive: true)
    ..writeAsString(
      '''
arb-dir: lib/l10n
template-arb-file: app_ja.arb
output-localization-file: app_l10n.dart
''',
    );

  await File('${flutterProjRoot.absolute.path}/lib/l10n/app_ja.arb')
      .create(recursive: true)
    ..writeAsString(
      '''
{
    "helloWorld": "Hello World!",
    "@helloWorld": {
      "description": "The conventional newborn programmer greeting"
    }
}
''',
    );
}
