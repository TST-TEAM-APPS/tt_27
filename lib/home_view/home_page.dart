import 'package:flutter/material.dart';
import 'package:tt_27/models/activity.dart';
import 'package:tt_27/styles/app_theme.dart';
import 'package:tt_27/widgets/daily_feeling_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ActivityCardData> activities = [
    ActivityCardData(icon: Icons.directions_run, label: "Running"),
    ActivityCardData(icon: Icons.pedal_bike, label: "Cycling"),
    ActivityCardData(icon: Icons.pool, label: "Swimming"),
    ActivityCardData(icon: Icons.self_improvement, label: "Yoga"),
    ActivityCardData(icon: Icons.directions_walk, label: "Squats"),
    ActivityCardData(icon: Icons.accessibility_new, label: "Lunges"),
    ActivityCardData(icon: Icons.fitness_center, label: "Deadlifts"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DailyFeelingWidget(),
            Container(
              child: const Text('awdaasd'),
            ),
            Text(
              "Today activity stats",
              style: AppTheme.bodyMedium.copyWith(color: AppTheme.onPrimary),
            ),
            const SizedBox(height: 16),
            // Карточки статистики
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _StatCard(
                  value: "0 h 0 min",
                  label: "Duration",
                  icon: Icons.timer_outlined,
                ),
                SizedBox(width: 16), // Промежуток между карточками
                _StatCard(
                  value: "0 cal",
                  label: "Calories burned",
                  icon: Icons.local_fire_department_outlined,
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Training",
              style: AppTheme.bodyMedium.copyWith(color: AppTheme.onPrimary),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              height: 90, // Высота виджета
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0
                          ? 8
                          : 8, // Отступ слева для первой карточки
                      right: index == activities.length - 1
                          ? 8
                          : 8, // Отступ справа для последней
                    ),
                    child: ActivityCard(
                      icon: activities[index].icon,
                      label: activities[index].label,
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 220, // Высота контейнера
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32), // Закругленные углы
                image: const DecorationImage(
                  image: AssetImage(
                      'assets/images/96725c70e31c85b6e40bd7c397adb024.png'), // Путь к изображению
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  // Затемнение фона
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: const Color.fromARGB(255, 0, 0, 0)
                          .withOpacity(0.3), // Затемнение (50%)
                    ),
                  ),

                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text("You haven't added training yet",
                            style: AppTheme.bodyLarge
                                .copyWith(color: AppTheme.onPrimary)),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surface, // Темный фон карточки
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Значение
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: value.split(' ')[0], // Часть значения до пробела
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text:
                        " ${value.split(' ').skip(1).join(' ')}", // Остальная часть
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Метка
            Row(
              children: [
                Icon(
                  icon,
                  color: AppTheme.onPrimary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.onPrimary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const ActivityCard({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: AppTheme.surface, // Цвет фона карточки
        borderRadius: BorderRadius.circular(16), // Закругленные углы
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: AppTheme.onPrimary, // Цвет иконки
            size: 28,
          ),
          const SizedBox(width: 8),
          Text(label,
              style: AppTheme.bodyLarge.copyWith(color: AppTheme.onPrimary)),
        ],
      ),
    );
  }
}
