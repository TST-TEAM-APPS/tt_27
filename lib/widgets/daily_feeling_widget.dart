import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tt_27/styles/app_theme.dart';

class DailyFeelingWidget extends StatelessWidget {
  const DailyFeelingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120, // Высота контейнера
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32), // Закругленные углы
        image: const DecorationImage(
          image: AssetImage(
              'assets/images/c606fee0e304d36c51b151e2c8442aa2.png'), // Путь к изображению
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Затемнение фона
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Colors.black.withOpacity(0.5), // Затемнение (50%)
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text("Daily feeling",
                    style: AppTheme.bodyMedium
                        .copyWith(color: AppTheme.onPrimary)),
                const SizedBox(height: 16),
                CupertinoButton(
                  onPressed: () {
                    // Обработчик нажатия кнопки
                  },
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                  color: AppTheme.onSurface, // Полупрозрачный фон
                  borderRadius: BorderRadius.circular(16), // Внутренние отступы
                  child: Text(
                    "Add feeling",
                    style: AppTheme.labelLarge
                        .copyWith(color: AppTheme.secondary), // Стиль текста
                  ), // Закругленные углы
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
