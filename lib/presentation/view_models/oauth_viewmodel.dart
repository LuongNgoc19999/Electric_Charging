import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../data/services/oauth_service.dart';
import '../../data/services/token_storage_service.dart';

class OAuthViewModel extends ChangeNotifier {
  final OAuthService _oauthService = OAuthService();
  final TokenStorageService _tokenStorage = TokenStorageService();

  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic>? _userInfo;
  bool _isLoggedIn = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get userInfo => _userInfo;
  bool get isLoggedIn => _isLoggedIn;

  /// Handle the authorization code received from WebView
  Future<bool> handleAuthorizationCode(String code) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Step 1: Exchange code for tokens
      print('🔄 Exchanging authorization code for tokens...');
      final tokenResponse = await _oauthService.exchangeCodeForToken(code);

      if (!tokenResponse['success']) {
        _errorMessage = tokenResponse['error_description'] ?? 'Failed to get tokens';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // Step 2: Save tokens to secure storage
      print('💾 Saving tokens to secure storage...');
      await _tokenStorage.saveTokens(
        accessToken: tokenResponse['access_token'],
        refreshToken: tokenResponse['refresh_token'],
        idToken: tokenResponse['id_token'],
        expiresIn: tokenResponse['expires_in'],
      );

      // Step 3: Get user info
      print('👤 Fetching user info...');
      final userInfoResponse = await _oauthService.getUserInfo(
        tokenResponse['access_token'],
      );

      if (userInfoResponse['success']) {
        _userInfo = userInfoResponse['user_info'];
        await _tokenStorage.saveUserInfo(json.encode(_userInfo));
        print('✅ User info: $_userInfo');
      }

      _isLoggedIn = true;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('❌ Error handling authorization code: $e');
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Check if user is already logged in
  Future<void> checkLoginStatus() async {
    _isLoading = true;
    notifyListeners();

    try {
      final hasTokens = await _tokenStorage.isLoggedIn();

      if (hasTokens) {
        // Check if token is expired
        final isExpired = await _tokenStorage.isTokenExpired();

        if (isExpired) {
          // Try to refresh the token
          final refreshed = await refreshToken();
          _isLoggedIn = refreshed;
        } else {
          // Token is still valid
          _isLoggedIn = true;

          // Load user info from storage
          final userInfoJson = await _tokenStorage.getUserInfo();
          if (userInfoJson != null) {
            _userInfo = json.decode(userInfoJson);
          }
        }
      } else {
        _isLoggedIn = false;
      }
    } catch (e) {
      print('Error checking login status: $e');
      _isLoggedIn = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Refresh the access token
  Future<bool> refreshToken() async {
    try {
      final refreshTokenStr = await _tokenStorage.getRefreshToken();

      if (refreshTokenStr == null) {
        print('No refresh token available');
        return false;
      }

      print('🔄 Refreshing access token...');
      final response = await _oauthService.refreshAccessToken(refreshTokenStr);

      if (response['success']) {
        await _tokenStorage.saveTokens(
          accessToken: response['access_token'],
          refreshToken: response['refresh_token'],
          expiresIn: response['expires_in'],
        );

        print('✅ Token refreshed successfully');
        return true;
      } else {
        print('❌ Failed to refresh token: ${response['error_description']}');
        return false;
      }
    } catch (e) {
      print('Error refreshing token: $e');
      return false;
    }
  }

  /// Logout the user
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Get refresh token for logout
      final refreshToken = await _tokenStorage.getRefreshToken();

      if (refreshToken != null) {
        // Try to revoke token on server
        await _oauthService.logout(refreshToken);
      }

      // Clear all local tokens
      await _tokenStorage.clearAllTokens();

      _isLoggedIn = false;
      _userInfo = null;
      _errorMessage = null;

      print('✅ Logged out successfully');
    } catch (e) {
      print('Error during logout: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Get the current access token (with auto-refresh if needed)
  Future<String?> getAccessToken() async {
    // Check if token is expired
    final isExpired = await _tokenStorage.isTokenExpired();

    if (isExpired) {
      // Try to refresh
      final refreshed = await refreshToken();
      if (!refreshed) {
        return null;
      }
    }

    return await _tokenStorage.getAccessToken();
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
