import 'package:flutter/foundation.dart';

class RegisterViewModel extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  bool isRegistered = false;

  // ✅ Regex kiểm tra password hợp lệ
  final passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,12}$',
  );

  bool isPasswordValid(String password) {
    return passwordRegex.hasMatch(password);
  }

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String avatar,
    required String password,
    required String confirmPassword,
  }) async {
    errorMessage = null;
    isRegistered = false;

    // 🔍 Kiểm tra dữ liệu đầu vào
    if (name.isEmpty || email.isEmpty || phone.isEmpty || avatar.isEmpty) {
      errorMessage = "Vui lòng nhập đầy đủ thông tin.";
      notifyListeners();
      return;
    }

    if (password != confirmPassword) {
      errorMessage = "Mật khẩu không khớp.";
      notifyListeners();
      return;
    }

    if (!isPasswordValid(password)) {
      errorMessage =
      "Mật khẩu phải 8–12 ký tự, gồm chữ hoa, chữ thường, số và ký tự đặc biệt.";
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    // 🧠 Giả lập API đăng ký (fake delay)
    await Future.delayed(const Duration(seconds: 2));

    isLoading = false;
    isRegistered = true;
    notifyListeners();
  }
}