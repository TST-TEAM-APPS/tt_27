import 'package:flutter/material.dart';
import 'package:tt_27/home_view/add_training_bottom_sheet.dart';
import 'package:tt_27/home_view/home_page.dart';
import 'package:tt_27/styles/app_theme.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const HomePage(),
    const HomePage(),
    const HomePage(),
  ];

  // Колбек для отображения BottomSheet
  void showAddTrainingBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Делает BottomSheet адаптивным к содержимому
      backgroundColor: Colors.transparent, // Убирает фоновый цвет
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7, // Высота BottomSheet при открытии
          maxChildSize: 0.9, // Максимальная высота
          minChildSize: 0.5, // Минимальная высота
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: const AddTrainingBottomSheet(), // Ваш BottomSheet
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_currentIndex],
          // Навигационная панель
          Positioned(
            bottom: 40.0,
            left: 40.0,
            right: 40.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 56,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2B2B2B), // Dark background color
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _NavBarItem(
                            icon: Icons.directions_run,
                            isActive: _currentIndex == 0,
                            onTap: () => _onItemTapped(0),
                          ),
                          _NavBarItem(
                            icon: Icons.bar_chart_outlined,
                            isActive: _currentIndex == 1,
                            onTap: () => _onItemTapped(1),
                          ),
                          _NavBarItem(
                            icon: Icons.settings_outlined,
                            isActive: _currentIndex == 2,
                            onTap: () => _onItemTapped(2),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 56,
                      decoration: const BoxDecoration(
                        color: AppTheme.primary, // Dark background color
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16),
                            bottomRight: Radius.circular(16)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _NavBarItem(
                              icon: Icons.add,
                              isActive: _currentIndex == 3,
                              onTap: () => showAddTrainingBottomSheet(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // Кнопка добавления
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? AppTheme.primary : Colors.grey,
            size: 28,
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 2,
              width: 30,
              color: AppTheme.primary, // Цвет индикатора
            ),
        ],
      ),
    );
  }
}
