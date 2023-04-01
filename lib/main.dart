import 'package:flutter/material.dart';
import 'package:helix_with_clean_architecture/src/app/app.dart';
import 'src/injector.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.initializeDependencies();

   runApp(App());
}
