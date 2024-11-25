// widgets/daily_feeling_widget.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tt_27/models/feeling.dart';
import 'package:tt_27/styles/app_theme.dart';

class DailyFeelingWidget extends StatelessWidget {
  final Feeling? feeling;
  final VoidCallback onAddFeeling;

  const DailyFeelingWidget({
    Key? key,
    required this.feeling,
    required this.onAddFeeling,
  }) : super(key: key);

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
                Text(
                  "Daily Feeling",
                  style:
                      AppTheme.bodyMedium.copyWith(color: AppTheme.onPrimary),
                ),
                const SizedBox(height: 8),
                feeling != null
                    ? Column(
                        children: [
                          Text(
                            feeling!.mood,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(feeling!.description,
                              style: AppTheme.displaySmall
                                  .copyWith(color: AppTheme.primary)),
                        ],
                      )
                    : const SizedBox(),
                const SizedBox(height: 16),
                // Условное отображение кнопки "Add Feeling"
                if (feeling == null)
                  CupertinoButton(
                    onPressed: onAddFeeling,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                    color: AppTheme.onSurface
                        .withOpacity(0.7), // Полупрозрачный фон
                    borderRadius:
                        BorderRadius.circular(16), // Закругленные углы
                    child: Text(
                      "Add Feeling",
                      style: AppTheme.labelLarge
                          .copyWith(color: AppTheme.secondary),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
