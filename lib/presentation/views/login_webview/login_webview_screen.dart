import 'package:electric_charging/presentation/views/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginWebViewPage extends StatefulWidget {
  const LoginWebViewPage({super.key});

  @override
  State<LoginWebViewPage> createState() => _LoginWebViewPageState();
}

class _LoginWebViewPageState extends State<LoginWebViewPage> {
  late final WebViewController controller;
  bool _isLoading = true;
  String? _errorMessage;

  // Keycloak OAuth configuration
  static const String authUrl =
      'https://sacxanh.io.vn:8025/realms/EcoCharge/protocol/openid-connect/auth';
  static const String clientId = 'login-mobile';
  static const String redirectUri = 'https://sacxanh.io.vn/api/management/stations/all';
  static const String responseType = 'code';

  // Build the complete authorization URL
  String get authorizationUrl {
    final params = {
      'client_id': clientId,
      'response_type': responseType,
      'redirect_uri': redirectUri,
    };

    final queryString = params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');

    return '$authUrl?$queryString';
  }

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..loadRequest(Uri.parse(authorizationUrl))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            print("🔄 Page started: $url");
            setState(() {
              _isLoading = true;
              _errorMessage = null;
            });
          },
          onPageFinished: (url) {
            print("✅ Page finished: $url");
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (error) {
            print("❌ WebView error: ${error.description}");
            setState(() {
              _isLoading = false;
              _errorMessage = error.description;
            });
          },
          onNavigationRequest: (request) {
            print("🧭 Navigation request: ${request.url}");

            // Check if this is the redirect callback URL
            if (request.url.startsWith(redirectUri)) {
              _handleCallback(request.url);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      );
  }

  void _handleCallback(String url) {
    try {
      final uri = Uri.parse(url);
      final code = uri.queryParameters['code'];
      final error = uri.queryParameters['error'];
      final errorDescription = uri.queryParameters['error_description'];

      if (error != null) {
        print("❌ OAuth error: $error - $errorDescription");
        _showErrorDialog("Lỗi đăng nhập", errorDescription ?? error);
        return;
      }

      if (code != null) {
        print("🎉 Authorization code received: $code");
        // Return the code to the previous screen
        Navigator.push(context, MaterialPageRoute(builder: (_) => MainScreen()),);
        // Navigator.of(context).pop({
        //   'code': code,
        //   'success': true,
        // });
      } else {
        print("⚠️ No code or error in callback");
        _showErrorDialog("Lỗi", "Không nhận được mã xác thực");
      }
    } catch (e) {
      print("❌ Error parsing callback: $e");
      _showErrorDialog("Lỗi", "Không thể xử lý phản hồi đăng nhập");
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop({'success': false, 'error': message});
            },
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng nhập'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            ),
          if (_errorMessage != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      'Lỗi tải trang',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _errorMessage = null;
                        });
                        controller.loadRequest(Uri.parse(authorizationUrl));
                      },
                      child: const Text('Thử lại'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
