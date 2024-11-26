import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:in_app_review/in_app_review.dart';
import 'package:peak_progress/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:peak_progress/onboarding_view/onboarding_page.dart';
import 'package:peak_progress/repos/mixins/network_mixin.dart';
import 'package:peak_progress/setting_view/additional_info_page.dart';

class InitialPage extends StatefulWidget {
  final bool isFirstRun;
  const InitialPage({
    super.key,
    this.isFirstRun = true,
  });

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> with NetworkMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
    super.initState();
  }

  Future<void> _init() async {
    await checkConnection(
      onError: () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const InitialPage(),
        ),
      ),
    );

    if (widget.isFirstRun) {
      InAppReview.instance.requestReview();
    }

    if (!showAdditionalInfo) {
      if (widget.isFirstRun) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const OnboardingScreen(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const CustomNavigationBar(),
          ),
        );
      }
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AdditionalInfoPage(),
        ),
      );
    }
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}