import 'package:flutter/material.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:peak_progress/models/feeling.dart';
import 'package:peak_progress/models/goal.dart';
import 'package:peak_progress/models/note.dart';
import 'package:peak_progress/models/training.dart';
import 'package:peak_progress/onboarding_view/initial_page.dart';
import 'package:peak_progress/repos/flagsmith.dart';
import 'package:peak_progress/repos/locator.dart';

void main() async {
  final bindings = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: bindings);
  await Hive.initFlutter();

  Hive.registerAdapter(TrainingAdapter());
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(GoalAdapter());
  Hive.registerAdapter(FeelingAdapter());

  await Hive.openBox<Training>('trainings');
  await Hive.openBox<Goal>('goals');
  await Hive.openBox<Feeling>('feelings');
  await Hive.openBox('settings');
  await Locator.setServices();

  var settingsBox = Hive.box('settings');
  bool isFirstRun = settingsBox.get('isFirstRun', defaultValue: true);
  WidgetsBinding.instance.addObserver(
    AppLifecycleListener(onDetach: GetIt.instance<Flagsmith>().closeClient),
  );
  runApp(
    AppInfo(
      data: await AppInfoData.get(),
      child: MainApp(isFirstRun: isFirstRun),
    ),
  );
}

class MainApp extends StatelessWidget {
  final bool isFirstRun;

  const MainApp({super.key, required this.isFirstRun});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'PeakProgress Win',
        debugShowCheckedModeBanner: false,
        home: InitialPage(isFirstRun: isFirstRun));
  }
}
