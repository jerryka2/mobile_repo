import 'package:flutter/material.dart';
import 'package:sprint4_fix/app/app.dart';
import 'package:sprint4_fix/app/di/di.dart';
import 'package:sprint4_fix/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  // await HiveService().clearStudentBox();

  await initDependencies();

  runApp(
    const App(),
  );
}
