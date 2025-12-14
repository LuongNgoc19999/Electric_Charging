import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorageService {
  static final TokenStorageService _instance = TokenStorageService._internal();
  factory TokenStorageService() => _instance;
  TokenStorageService._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  // Storage keys
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _idTokenKey = 'id_token';
  static const String _tokenExpiryKey = 'token_expiry';
  static const String _userInfoKey = 'user_info';

  /// Save access token
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  /// Get access token
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  /// Save refresh token
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  /// Get refresh token
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  /// Save ID token
  Future<void> saveIdToken(String token) async {
    await _storage.write(key: _idTokenKey, value: token);
  }

  /// Get ID token
  Future<String?> getIdToken() async {
    return await _storage.read(key: _idTokenKey);
  }

  /// Save token expiry time
  Future<void> saveTokenExpiry(int expiresIn) async {
    final expiryTime = DateTime.now().add(Duration(seconds: expiresIn));
    await _storage.write(
      key: _tokenExpiryKey,
      value: expiryTime.toIso8601String(),
    );
  }

  /// Get token expiry time
  Future<DateTime?> getTokenExpiry() async {
    final expiryStr = await _storage.read(key: _tokenExpiryKey);
    if (expiryStr != null) {
      return DateTime.parse(expiryStr);
    }
    return null;
  }

  /// Check if token is expired
  Future<bool> isTokenExpired() async {
    final expiry = await getTokenExpiry();
    if (expiry == null) return true;

    // Add 1 minute buffer before actual expiry
    return DateTime.now().isAfter(expiry.subtract(const Duration(minutes: 1)));
  }

  /// Save user info as JSON string
  Future<void> saveUserInfo(String userInfoJson) async {
    await _storage.write(key: _userInfoKey, value: userInfoJson);
  }

  /// Get user info
  Future<String?> getUserInfo() async {
    return await _storage.read(key: _userInfoKey);
  }

  /// Save all token data at once
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    String? idToken,
    required int expiresIn,
  }) async {
    await Future.wait([
      saveAccessToken(accessToken),
      saveRefreshToken(refreshToken),
      if (idToken != null) saveIdToken(idToken),
      saveTokenExpiry(expiresIn),
    ]);
  }

  /// Check if user is logged in (has valid tokens)
  Future<bool> isLoggedIn() async {
    final accessToken = await getAccessToken();
    final refreshToken = await getRefreshToken();
    return accessToken != null && refreshToken != null;
  }

  /// Clear all stored tokens (logout)
  Future<void> clearAllTokens() async {
    await _storage.deleteAll();
  }

  /// Clear specific token
  Future<void> clearToken(String key) async {
    await _storage.delete(key: key);
  }
}
