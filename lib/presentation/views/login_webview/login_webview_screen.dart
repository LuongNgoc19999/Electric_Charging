import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginWebViewPage extends StatefulWidget {
  const LoginWebViewPage({super.key});

  @override
  State<LoginWebViewPage> createState() => _LoginWebViewPageState();
}

class _LoginWebViewPageState extends State<LoginWebViewPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // bật JS
      ..loadRequest(
        Uri.parse("com.sacxanh://login-callback"),
        //headers: {"Authorization": "Bearer $token"}
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            print("START: $url");
          },
          onPageFinished: (url) {
            print("FINISH: $url");
          },
          onNavigationRequest: (request) {
            print("NAVIGATE: ${request.url}");

            if (request.url.startsWith("com.sacxanh://login-callback")) {
              // lấy code từ đường dẫn
              final uri = Uri.parse(request.url);
              final code = uri.queryParameters['code'];

              print("AUTH CODE = $code");

              // chặn WebView không load callback
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WebViewWidget(controller: controller));
  }
}
