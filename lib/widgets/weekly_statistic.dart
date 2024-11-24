import 'package:flutter/material.dart';

class WeeklyStatisticsWidget extends StatefulWidget {
  const WeeklyStatisticsWidget({super.key});

  @override
  State<WeeklyStatisticsWidget> createState() => _WeeklyStatisticsWidgetState();
}

class _WeeklyStatisticsWidgetState extends State<WeeklyStatisticsWidget> {
  int _currentWeekIndex = 0;

  // Пример данных для нескольких недель
  final List<List<int>> _weeklyData = [
    [50, 30, 60, 70, 90, 20, 40], // Неделя 1
    [20, 40, 50, 80, 100, 60, 70], // Неделя 2
    [60, 30, 40, 50, 90, 80, 70], // Неделя 3
  ];

  // Дни для каждой недели
  final List<List<String>> _weekDays = [
    ["9", "10", "11", "12", "13", "14", "15"], // Неделя 1
    ["16", "17", "18", "19", "20", "21", "22"], // Неделя 2
    ["23", "24", "25", "26", "27", "28", "29"], // Неделя 3
  ];

  void _changeWeek(int direction) {
    setState(() {
      _currentWeekIndex = (_currentWeekIndex + direction) % _weeklyData.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = _weeklyData[_currentWeekIndex];
    final days = _weekDays[_currentWeekIndex];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2B2B2B), // Темный фон
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Training statistics",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment:
                CrossAxisAlignment.end, // Все столбцы выравнены снизу
            children: List.generate(data.length, (index) {
              return _BarChartItem(
                value: data[index],
                day: days[index],
              );
            }),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Week ${_currentWeekIndex + 1}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "1 week",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => _changeWeek(-1),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _changeWeek(1),
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _BarChartItem extends StatelessWidget {
  final int value;
  final String day;

  const _BarChartItem({
    required this.value,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end, // Столбцы выровнены снизу
      children: [
        Container(
          height: value.toDouble(),
          width: 16,
          decoration: BoxDecoration(
            color: const Color(0xFF6B75FF), // Цвет столбца
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          day,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
