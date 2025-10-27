import 'package:flutter/foundation.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/entities/user.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginUser loginUser;
  bool isLoading = false;
  String? errorMessage;
  User? user;

  LoginViewModel(this.loginUser);

  Future<void> login(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      user = await loginUser(email, password);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}