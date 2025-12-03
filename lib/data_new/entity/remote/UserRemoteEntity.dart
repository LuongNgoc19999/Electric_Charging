class UserRemoteEntity {
  UserRemoteEntity({
    required this.id,
    required this.keycloakUserId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.avatarUrl,
    required this.walletBalance,
    required this.isActive,
  });

  int id;
  String keycloakUserId;
  String name;
  String email;
  String phoneNumber;
  String avatarUrl;
  String walletBalance;
  bool isActive;

}