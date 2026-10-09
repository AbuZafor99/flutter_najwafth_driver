import 'package:flutter/foundation.dart';

const String _liveBaseUrl = 'https://api.booksonwheeels.com';
const int _localPort = 5020;
const String _apiBaseUrlOverride = String.fromEnvironment('API_BASE_URL');

enum AppEnvironment { development, staging, production }

final class AppConfig {
  const AppConfig({
    required this.appName,
    required this.environment,
    required this.baseUrl,
    this.connectTimeout = const Duration(seconds: 20),
    this.receiveTimeout = const Duration(seconds: 20),
  });

  factory AppConfig.development() {
    return AppConfig(
      appName: 'Books on Wheels Driver',
      environment: kReleaseMode
          ? AppEnvironment.production
          : AppEnvironment.development,
      baseUrl: _resolveBaseUrl(),
    );
  }

  final String appName;
  final AppEnvironment environment;
  final String baseUrl;
  final Duration connectTimeout;
  final Duration receiveTimeout;

  bool get isDevelopment => environment == AppEnvironment.development;
  bool get isProduction => environment == AppEnvironment.production;
}

String _resolveBaseUrl() {
  if (_apiBaseUrlOverride.isNotEmpty) return _apiBaseUrlOverride;
  if (kReleaseMode) return _liveBaseUrl;
  return defaultTargetPlatform == TargetPlatform.android
      ? 'http://10.0.2.2:$_localPort'
      : 'http://localhost:$_localPort';
}
