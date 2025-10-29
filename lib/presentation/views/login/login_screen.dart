import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_models/login_viewmodel.dart';
import '../main/main_screen.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginScreen({super.key}) {
    emailController.text = "ngoc";
    emailController.text = "ngoc";
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            if (viewModel.isLoading)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: () async {
                  await viewModel.login(
                    emailController.text,
                    passwordController.text,
                  );

                  if (viewModel.user != null) {
                    // 🔥 Chuyển sang màn hình Home nếu login thành công
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MainScreen(/*user: viewModel.user!*/),
                      ),
                    );
                  }
                },
                child: const Text("Login"),
              ),
            const SizedBox(height: 16),
            if (viewModel.errorMessage != null)
              Text(
                viewModel.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
