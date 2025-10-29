import 'package:electric_charging/presentation/view_models/login_viewmodel.dart';
import 'package:electric_charging/presentation/views/login/login_screen.dart';
import 'package:electric_charging/presentation/views/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'data/data_sources/user_remote_data_source.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/usecases/login_user.dart';

void main() {
  final remoteDataSource = UserRemoteDataSourceImpl(http.Client());
  final repository = UserRepositoryImpl(remoteDataSource);
  final loginUser = LoginUser(repository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel(loginUser)),
      ],
      child: MaterialApp(home: MainScreen()),
    ),
  );
}
