import 'dart:convert';

import 'package:flagsmith/flagsmith.dart';
import 'package:peak_progress/models/config.dart';

class Flagsmith {
  static const _apikey = 'XkonjoUdecj7EMa6WiHRTv';

  late final FlagsmithClient _flagsmithClient;

  late final ConfigModel _config;

  Future<Flagsmith> init() async {
    _flagsmithClient = await FlagsmithClient.init(
      apiKey: _apikey,
      config: const FlagsmithConfig(
        caches: true,
      ),
    );
    await _flagsmithClient.getFeatureFlags(reload: true);

    final json = jsonDecode(
        await _flagsmithClient.getFeatureFlagValue(ConfigKey.config.name) ??
            '') as Map<String, dynamic>;
    _config = ConfigModel.fromJson(json);
    return this;
  }

  void closeClient() => _flagsmithClient.close();

  ConfigModel get config => _config;
}

enum ConfigKey { config, link, useMock, privacyLink, termsLink }