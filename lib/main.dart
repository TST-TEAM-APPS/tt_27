import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tt_27/models/feeling.dart';
import 'package:tt_27/models/goal.dart';
import 'package:tt_27/models/note.dart';
import 'package:tt_27/models/training.dart';
import 'package:tt_27/onboarding_view/onboarding_page.dart';

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
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: OnboardingScreen());
  }
}
