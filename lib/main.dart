import 'package:flutter/material.dart';
import 'package:clean_architecture_template/core/di/service_locator.dart' as di;
import 'package:clean_architecture_template/presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependencies
  await di.init();
  
  runApp(const App());
} 