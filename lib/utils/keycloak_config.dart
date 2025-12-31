// ignore_for_file: non_constant_identifier_names

class KeycloakConfig {
  // static const ISSUER_URL = 'https://192.168.1.134:8010/realms/MEET_ME';
  static String ISSUER_URL =
      'https://sacxanh.io.vn:8025/realms/EcoCharge/protocol/openid-connect/auth'; // I don't know, mutated by ENV after app start :/
  static String ACCOUNT_URL = '$ISSUER_URL/account';
  static String FILTER_URL = '$ISSUER_URL/account?type=filter';
  static String DELETE_ACCOUNT_URL = '$ISSUER_URL/account?type=delete-account';
  static String UPLOAD_AVATAR_URL = '$ISSUER_URL/account?type=upload-avatar';
  static String LOGOUT_ACCOUNT_URL = '$ISSUER_URL/account?type=logout';
  static const CLIENT_ID = 'login-mobile';
  static const CLIENT_SECRET = 'Xyy9RQxzK4f2h1NyzvzfexNtbWR4NJe5';
  static const KC_LOCALE = 'KEYCLOAK_LOCALE';
  static const List<String> SCOPES = <String>[
    'profile',
    'email',
  ];

  static const String TOKEN_RESPONSE = "TOKEN_RESPONSE";
  static const String USERNAME = "KC_USERNAME";
  static const String AVATAR = "KC_AVATAR";
  static const String BIRTHDAY = "KC_BIRTHDAY";
  static const String FULLNAME = "KC_FULLNAME";

  static const String COOKIE = "KC_COOKIE";
  static String LOGOUT_URL = '$ISSUER_URL/protocol/openid-connect/logout';

  static String get ISSUER_HOST => Uri.parse(ISSUER_URL).host;
}
