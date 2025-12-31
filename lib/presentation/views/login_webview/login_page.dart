import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../view_models/oauth_viewmodel.dart';
import '../main/main_screen.dart';

class LoginPage extends StatefulWidget {
  final String url;

  const LoginPage({super.key, required this.url});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        color: Colors.green,
        child: InAppWebView(
          key: webViewKey,
          initialOptions: InAppWebViewGroupOptions(
            ios: IOSInAppWebViewOptions(
              sharedCookiesEnabled: true,
              disallowOverScroll: true,
              allowsBackForwardNavigationGestures: false,
            ),
            crossPlatform: InAppWebViewOptions(
              transparentBackground: true,
              verticalScrollBarEnabled: false,
              supportZoom: false,
            ),
          ),
          onWebViewCreated: (c) => webViewController = c,
          initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(widget.url))),
          onProgressChanged: (_, progress) => {},
          onLoadError: (_, url, statusCode, description) => Get.back(),
          onLoadHttpError: (_, url, statusCode, description) => Get.back(),
        ),
      ),
    );
  }
}

class OAuthLoginPage extends StatefulWidget {
  const OAuthLoginPage({super.key});

  @override
  State<OAuthLoginPage> createState() => _OAuthLoginPageState();
}

class _OAuthLoginPageState extends State<OAuthLoginPage> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;

  // Build the OAuth authorization URL
  String getAuthorizationUrl() {
    const baseUrl =
        'https://sacxanh.io.vn:8025/realms/EcoCharge/protocol/openid-connect/auth';
    const clientId = 'login-mobile';
    const redirectUri = 'https://sacxanh.io.vn/api/management/stations/all';
    // const scope = 'openid profile email';

    var url =
        '$baseUrl?'
        'client_id=$clientId&'
        'redirect_uri=$redirectUri&'
        'response_type=code';
    // 'scope=$scope';
    debugPrint("ngoc, url: $url");
    return url;
  }

  @override
  Widget build(BuildContext context) {
    final oauthViewModel = Provider.of<OAuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Stack(
        children: [
          InAppWebView(
            key: webViewKey,
            initialOptions: InAppWebViewGroupOptions(
              ios: IOSInAppWebViewOptions(
                sharedCookiesEnabled: true,
                disallowOverScroll: true,
              ),
              crossPlatform: InAppWebViewOptions(
                transparentBackground: true,
                verticalScrollBarEnabled: false,
                supportZoom: false,
              ),
            ),
            onWebViewCreated: (controller) => webViewController = controller,
            initialUrlRequest: URLRequest(
              url: WebUri.uri(Uri.parse(getAuthorizationUrl())),
            ),
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              final uri = navigationAction.request.url;
              debugPrint('ngoc🔗 uri: $uri');

              if (uri != null) {
                final url = uri.toString();
                debugPrint('ngoc🔗 Navigation to: $url');

                // Check if this is the redirect URL with authorization code
                if (url.startsWith(
                  'https://sacxanh.io.vn/api/management/stations/all',
                )) {
                  final code = uri.queryParameters['code'];

                  if (code != null) {
                    debugPrint('ngoc✅ Authorization code received: $code');

                    // Handle the authorization code with OAuthViewModel
                    final success = await oauthViewModel
                        .handleAuthorizationCode(code);

                    if (success && mounted) {
                      // Navigate to home screen after successful login
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => MainScreen()),
                      );
                    }

                    // Prevent the webview from navigating to the redirect URL
                    return NavigationActionPolicy.CANCEL;
                  }
                }
              }

              return NavigationActionPolicy.ALLOW;
            },
            onLoadError: (controller, url, statusCode, description) {
              debugPrint('ngoc❌ Load error: $statusCode - $description');
            },
            onLoadHttpError: (controller, url, statusCode, description) {
              debugPrint('ngoc❌ HTTP error: $statusCode - $description');
            },
          ),

          // Show loading indicator while processing
          if (oauthViewModel.isLoading)
            Container(
              color: Colors.black54,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
