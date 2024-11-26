import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaimon/gaimon.dart';
import 'package:tt_27/styles/app_theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background, // Фон страницы
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Заголовок
              const Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Подзаголовок
              const Text(
                'Application settings',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              // Карточки настроек
              Row(
                children: [
                  Expanded(
                    child: _buildSettingsCard(
                      icon: Icons.lock,
                      iconColor: AppTheme.primary,
                      title: 'Privacy Policy',
                      onTap: () {
                        // Действие нажатия
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildSettingsCard(
                      icon: Icons.description,
                      iconColor: AppTheme.primary,
                      title: 'Terms of Use',
                      onTap: () {
                        // Действие нажатия
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Карточка обратной связи
              _buildFeedbackCard(),
              const Spacer(),
              // Версия приложения
              Center(
                child: Column(
                  children: const [
                    Text(
                      'Activity Diary',
                      style: TextStyle(
                        color: AppTheme.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Version 0.1',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 200),
            ],
          ),
        ),
      ),
    );
  }

  // Карточка настройки
  Widget _buildSettingsCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2E), // Фон карточки
          borderRadius: BorderRadius.circular(12), // Скругленные углы
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Карточка обратной связи
  Widget _buildFeedbackCard() {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E), // Фон карточки
        borderRadius: BorderRadius.circular(12), // Скругленные углы
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.feedback,
            color: AppTheme.primary,
            size: 24,
          ),
          const Spacer(),
          const Text(
            'Feedback',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Send feedback, suggestions, or bug reports.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              height: 1.5,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              color: AppTheme.primary, // Цвет кнопки
              borderRadius: BorderRadius.circular(8),
              onPressed: () {
                Gaimon.selection();
              },
              child: const Text(
                'Send',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
