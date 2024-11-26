import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:gaimon/gaimon.dart';
import 'package:peak_progress/repos/mixins/config_mixin.dart';
import 'package:peak_progress/styles/app_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SettingsPage extends StatelessWidget with ConfigMixin {
  SettingsPage({super.key});

  void _showAppData({
    required BuildContext context,
    required String link,
  }) =>
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoPopupSurface(
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CupertinoButton(
                  padding: const EdgeInsets.only(right: 10),
                  onPressed: Navigator.of(context).pop,
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      fontSize: 20,
                      color: CupertinoColors.darkBackgroundGray,
                    ),
                  ),
                ),
                Expanded(
                  child: WebViewWidget(
                    controller: WebViewController()
                      ..loadRequest(
                        Uri.parse(link),
                      ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final version = AppInfo.of(context).package.version;
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

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

              Row(
                children: [
                  Expanded(
                    child: _buildSettingsCard(
                      icon: Icons.lock,
                      iconColor: AppTheme.primary,
                      title: 'Privacy Policy',
                      onTap: () => _showAppData(
                        context: context,
                        link: privacyLink,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildSettingsCard(
                      icon: Icons.description,
                      iconColor: AppTheme.primary,
                      title: 'Terms of Use',
                      onTap: () => _showAppData(
                        context: context,
                        link: termsLink,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              _buildFeedbackCard(
                () async => await FlutterEmailSender.send(
                  Email(),
                ),
              ),
              const Spacer(),

              Center(
                child: Column(
                  children: [
                    const Text(
                      'Activity Diary',
                      style: TextStyle(
                        color: AppTheme.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Version ${version.major}.${version.minor}.${version.patch}',
                      style: const TextStyle(
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
  Widget _buildFeedbackCard(VoidCallback callback) {
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
          const SizedBox(
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
                callback.call();
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
