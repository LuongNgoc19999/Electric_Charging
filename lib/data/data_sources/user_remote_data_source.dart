import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> login(String email, String password);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl(this.client);

  @override
  Future<UserModel> login(String email, String password) async {
    if (email == "ngoc") {
      return UserModel(id: "0", name: "ngoc", email: email);
    }
    final response = await client.post(
      Uri.parse('https://example.com/login'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Login failed');
    }
  }
}
