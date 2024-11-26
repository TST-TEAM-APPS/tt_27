// main.dart

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tt_27/models/feeling.dart';
import 'package:tt_27/models/goal.dart';
import 'package:tt_27/models/note.dart';
import 'package:tt_27/models/training.dart';
import 'package:tt_27/onboarding_view/onboarding_page.dart';
import 'package:tt_27/bottom_navigation_bar/bottom_navigation_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register adapters here
  Hive.registerAdapter(TrainingAdapter());
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(GoalAdapter());
  Hive.registerAdapter(FeelingAdapter());

  // Открытие Hive боксов
  await Hive.openBox<Training>('trainings');
  await Hive.openBox<Goal>('goals');
  await Hive.openBox<Feeling>('feelings');
  await Hive.openBox('settings'); // Открытие бокса для настроек

  // Получение флага завершения онбординга
  var settingsBox = Hive.box('settings');
  bool isOnboardingCompleted =
      settingsBox.get('isOnboardingCompleted', defaultValue: false);

  runApp(MainApp(isOnboardingCompleted: isOnboardingCompleted));
}

class MainApp extends StatelessWidget {
  final bool isOnboardingCompleted;

  const MainApp({super.key, required this.isOnboardingCompleted});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isOnboardingCompleted
          ? const CustomNavigationBar()
          : const OnboardingScreen(),
    );
  }
}
