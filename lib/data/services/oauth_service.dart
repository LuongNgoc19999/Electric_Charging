import 'dart:convert';
import 'package:http/http.dart' as http;

class OAuthService {
  // Keycloak OAuth configuration
  static const String tokenUrl =
      'https://sacxanh.io.vn:8025/realms/EcoCharge/protocol/openid-connect/token';
  static const String userInfoUrl =
      'https://sacxanh.io.vn:8025/realms/EcoCharge/protocol/openid-connect/userinfo';
  static const String clientId = 'login-mobile';
  static const String redirectUri =
      'https://sacxanh.io.vn/api/management/stations/all';

  /// Exchange authorization code for access token
  Future<Map<String, dynamic>> exchangeCodeForToken(String code) async {
    try {
      final response = await http.post(
        Uri.parse(tokenUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'grant_type': 'authorization_code',
          'client_id': clientId,
          'code': code,
          'redirect_uri': redirectUri,
        },
      );

      print('Token exchange status: ${response.statusCode}');
      print('Token exchange response: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'success': true,
          'access_token': data['access_token'],
          'refresh_token': data['refresh_token'],
          'expires_in': data['expires_in'],
          'token_type': data['token_type'],
          'id_token': data['id_token'],
        };
      } else {
        final error = json.decode(response.body);
        return {
          'success': false,
          'error': error['error'] ?? 'unknown_error',
          'error_description':
              error['error_description'] ?? 'Failed to exchange token',
        };
      }
    } catch (e) {
      print('Error exchanging code for token: $e');
      return {
        'success': false,
        'error': 'network_error',
        'error_description': e.toString(),
      };
    }
  }

  /// Refresh the access token using refresh token
  Future<Map<String, dynamic>> refreshAccessToken(String refreshToken) async {
    try {
      final response = await http.post(
        Uri.parse(tokenUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'grant_type': 'refresh_token',
          'client_id': clientId,
          'refresh_token': refreshToken,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'success': true,
          'access_token': data['access_token'],
          'refresh_token': data['refresh_token'],
          'expires_in': data['expires_in'],
          'token_type': data['token_type'],
        };
      } else {
        final error = json.decode(response.body);
        return {
          'success': false,
          'error': error['error'] ?? 'unknown_error',
          'error_description':
              error['error_description'] ?? 'Failed to refresh token',
        };
      }
    } catch (e) {
      print('Error refreshing token: $e');
      return {
        'success': false,
        'error': 'network_error',
        'error_description': e.toString(),
      };
    }
  }

  /// Get user information using access token
  Future<Map<String, dynamic>> getUserInfo(String accessToken) async {
    try {
      final response = await http.get(
        Uri.parse(userInfoUrl),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        // Decode with UTF-8 to handle Vietnamese characters
        final data = json.decode(utf8.decode(response.bodyBytes));
        return {
          'success': true,
          'user_info': data,
        };
      } else {
        return {
          'success': false,
          'error': 'Failed to get user info',
        };
      }
    } catch (e) {
      print('Error getting user info: $e');
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Logout by revoking the token
  Future<bool> logout(String refreshToken) async {
    try {
      final logoutUrl =
          'https://sacxanh.io.vn:8025/realms/EcoCharge/protocol/openid-connect/logout';

      final response = await http.post(
        Uri.parse(logoutUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'client_id': clientId,
          'refresh_token': refreshToken,
        },
      );

      return response.statusCode == 204 || response.statusCode == 200;
    } catch (e) {
      print('Error during logout: $e');
      return false;
    }
  }
}
