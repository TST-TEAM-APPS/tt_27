import 'package:flutter/material.dart';

class AddTrainingBottomSheet extends StatefulWidget {
  const AddTrainingBottomSheet({super.key});

  @override
  _AddTrainingBottomSheetState createState() => _AddTrainingBottomSheetState();
}

class _AddTrainingBottomSheetState extends State<AddTrainingBottomSheet> {
  String selectedCategory = "Running"; // Выбранная категория
  String intensity = "Easy"; // Выбранная интенсивность
  String description = "";
  String durationMinutes = "00";
  String durationHours = "00";
  String caloriesBurned = "0";

  final List<Map<String, String>> categories = [
    {"label": "Running", "icon": "directions_run"},
    {"label": "Cycling", "icon": "pedal_bike"},
    {"label": "Swimming", "icon": "pool"},
    {"label": "Yoga", "icon": "self_improvement"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF2B2B2B),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Add training",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Категории
            const Text(
              "Select a category for training",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: categories.map((category) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = category["label"]!;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: selectedCategory == category["label"]
                          ? const Color(0xFF6B75FF)
                          : const Color(0xFF3A3A3A),
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
              }).toList(),
            ),
            const SizedBox(height: 16),
            // Описание тренировки
            TextField(
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Training description",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFF3A3A3A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Длительность и калории
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    "Duration",
                    "$durationHours h  $durationMinutes min",
                    (value) {
                      setState(() {
                        durationMinutes = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildInputField(
                    "Calories burned",
                    caloriesBurned,
                    (value) {
                      setState(() {
                        caloriesBurned = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Интенсивность
            const Text(
              "Intensity",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildRadioButton("Easy"),
                const SizedBox(width: 16),
                _buildRadioButton("Moderate"),
              ],
            ),
            const SizedBox(height: 16),
            // Кнопка сохранения
            ElevatedButton(
              onPressed: () {
                // Сохранение тренировки
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6B75FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Center(
                child: Text(
                  "Save",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Дата
            const Center(
              child: Text(
                "Nov 14, 2024",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Метод для построения радио-кнопок
  Widget _buildRadioButton(String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          intensity = label;
        });
      },
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Icon(
            intensity == label
                ? Icons.radio_button_checked
                : Icons.radio_button_off,
            color: Colors.white,
            size: 20,
          ),
        ],
      ),
    );
  }

  // Метод для создания поля ввода
  Widget _buildInputField(
      String label, String value, ValueChanged<String> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        TextField(
          onChanged: onChanged,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: value,
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: const Color(0xFF3A3A3A),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  // Метод для получения иконки по имени
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
      default:
        return Icons.help;
    }
  }
}
