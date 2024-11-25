import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tt_27/models/goal.dart';
import 'package:tt_27/styles/app_theme.dart';

class AddGoal extends StatefulWidget {
  final VoidCallback onSave;

  const AddGoal({super.key, required this.onSave});

  @override
  State<AddGoal> createState() => _AddGoalState();
}

class _AddGoalState extends State<AddGoal> {
  late String selectedCategory;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _targetCountController = TextEditingController();

  final List<Map<String, String>> categories = [
    {"label": "Running", "icon": "directions_run"},
    {"label": "Cycling", "icon": "pedal_bike"},
    {"label": "Swimming", "icon": "pool"},
    {"label": "Yoga", "icon": "self_improvement"},
    {"label": "Squats", "icon": "directions_walk"},
    {"label": "Lunges", "icon": "accessibility_new"},
    {"label": "Deadlifts", "icon": "fitness_center"},
  ];

  @override
  void initState() {
    super.initState();
    selectedCategory = categories[0]["label"]!;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _targetCountController.dispose();
    super.dispose();
  }

  IconData _getIconForCategory(String iconName) {
    switch (iconName) {
      case "directions_run":
        return Icons.directions_run;
      case "pedal_bike":
        return Icons.pedal_bike;
      case "pool":
        return Icons.pool;
      case "self_improvement":
        return Icons.self_improvement;
      case "directions_walk":
        return Icons.directions_walk;
      case "accessibility_new":
        return Icons.accessibility_new;
      case "fitness_center":
        return Icons.fitness_center;
      default:
        return Icons.help;
    }
  }

  void _saveGoal() async {
    String title = _titleController.text.trim();
    String description = _descriptionController.text.trim();
    int targetCount = int.tryParse(_targetCountController.text.trim()) ?? 0;

    if (title.isEmpty || description.isEmpty || targetCount <= 0) {
      // Показать сообщение об ошибке
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    Goal newGoal = Goal(
      category: selectedCategory,
      title: title,
      description: description,
      targetCount: targetCount,
    );

    try {
      var box = await Hive.openBox<Goal>('goals');
      await box.add(newGoal);
      print('Goal saved: ${newGoal.title}');
    } catch (e) {
      print('Error saving goal: $e');
    }

    widget.onSave();

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Цвет фона с закругленными углами уже задается в `showModalBottomSheet`
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок с полосой для перетаскивания
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 16),
            Center(
              child: Text(
                'Add goal',
                style:
                    AppTheme.displayMedium.copyWith(color: AppTheme.secondary),
              ),
            ),
            const SizedBox(height: 16),

            // Категории
            Text(
              'Select a category for goal',
              style: AppTheme.bodyLarge.copyWith(color: AppTheme.onPrimary),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category["label"]!;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: selectedCategory == category["label"]
                            ? AppTheme.primary
                            : AppTheme.surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getIconForCategory(category["icon"]!),
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            category["label"]!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // Поле ввода заголовка
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Goal Title',
                labelStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: AppTheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            // Поле ввода описания
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Goal Description',
                labelStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: AppTheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              maxLines: 3,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            // Поле ввода целевого количества
            Text(
              'Number of training sessions to reach the goal',
              style: AppTheme.bodyLarge.copyWith(color: AppTheme.onPrimary),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _targetCountController,
              decoration: InputDecoration(
                labelText: 'Target Count',
                labelStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: AppTheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            // Кнопка сохранения цели
            ElevatedButton(
              onPressed: _saveGoal,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Center(
                child: Text(
                  "Save Goal",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
