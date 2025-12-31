class KeycloakConfig {
  //      'https://sacxanh.io.vn:8025/realms/EcoCharge/protocol/openid-connect/auth?client_id=login-mobile&response_type=code&redirect_uri=https://sacxanh.io.vn/api/management/stations/all'; // I don't know, mutated by ENV after app start :/
  static const issuer =
      'https://sacxanh.io.vn:8025/realms/EcoCharge';
  static const clientId = 'login-mobile';
  static const clientSecret = 'Xyy9RQxzK4f2h1NyzvzfexNtbWR4NJe5';
  static const redirectUri = 'https://sacxanh.io.vn/api/management/stations/all';

  static const KC_LOCALE = 'KEYCLOAK_LOCALE';
}
