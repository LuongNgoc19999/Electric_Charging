import 'dart:io';

import 'package:electric_charging/data_new/utils/KeycloakConfig.dart';
import 'package:electric_charging/presentation/views/login_webview/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:openid_client/openid_client.dart';
import 'package:openid_client/openid_client_io.dart' as io;
import 'package:provider/provider.dart';

import '../../view_models/oauth_viewmodel.dart';
import '../main/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final oauthViewModel = Provider.of<OAuthViewModel>(context, listen: false);

    // Check if user is already logged in
    await oauthViewModel.checkLoginStatus();

    if (mounted) {
      if (oauthViewModel.isLoggedIn) {
        debugPrint("ngoc oauthViewModel.isLoggedIn = true");
        // User is logged in, go to home
        // Navigator.of(context).pushReplacementNamed('/home');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => MainScreen()),
        );
      } else {
        debugPrint("ngoc oauthViewModel.isLoggedIn = false");

        final credential = await loginWithKeycloak();
        debugPrint("ngoc credential: $credential");

        // Access Token
        final accessToken = await credential.getTokenResponse();
        debugPrint("ngoc Access Token: ${accessToken.accessToken}");

        // Refresh Token
        debugPrint("ngoc Refresh Token: ${accessToken.refreshToken}");

        // ID Token
        debugPrint("ngoc ID Token: ${accessToken.idToken}");
        // User is not logged in, go to login
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (_) => OAuthLoginPage(),),
        // );
      }
    }
  }

  Future<Credential> loginWithKeycloak() async {
    // 1. Discover issuer
    final issuer = await Issuer.discover(Uri.parse(KeycloakConfig.issuer));
    // 2. Create client
    final client = Client(issuer, KeycloakConfig.clientId, clientSecret: KeycloakConfig.clientSecret);
    debugPrint("ngoc client: $client");
    // 3. Create authenticator
    urlLauncher(String url) async {
      Navigator.push(context, MaterialPageRoute(builder: (_) => AuthWebView(Uri.parse(url))),);
    }
    // 3. Create authenticator
    final authenticator = io.Authenticator(client,
      scopes: ['openid', 'profile', 'email'],
      port: 8025,
      urlLancher: urlLauncher,
      htmlPage: buildLoadingHtmlPage(),
    );
    debugPrint("ngoc authenticator: $authenticator");
    // 4. Start login flow
    final credential = await authenticator.authorize();
    debugPrint("ngoc credential: $credential");
    // 5. Close webview/browse
    if (Platform.isAndroid || Platform.isIOS) {
      // closeInAppWebView();
    }
    return credential;
  }

  static setupKeycloakLocale() {
    CookieManager cookieManager = CookieManager.instance();
    cookieManager.setCookie(
      url: WebUri.uri(Uri.parse(KeycloakConfig.issuer)),
      name: KeycloakConfig.KC_LOCALE,
      value: "vi",
    );
  }

  // static String get getLocale {
  //   var code = Get.locale?.languageCode;
  //   if (code == null) return LocalizationService.defaultCountryCode;
  //   if (!code.contains("en"))
  //     return LocalizationService.defaultCountryCode;
  //   else
  //     return code;
  // }
  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class AuthWebView extends StatefulWidget {
  final Uri authUrl;

  const AuthWebView(this.authUrl, {super.key});

  @override
  State<AuthWebView> createState() => _AuthWebViewState();
}

class _AuthWebViewState extends State<AuthWebView> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
        onWillPop: () async => false,
        child: Container(
          color: Colors.white,
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
            initialUrlRequest: URLRequest(url: WebUri.uri(widget.authUrl)),
            // onProgressChanged: (_, progress) =>
            //     controller.isLoading(progress < 100),
            onLoadError: (_, url, statusCode, description) => {
              debugPrint("ngoc❌ Load error: $statusCode - $description"),
              Navigator.pop(context)
            },
            onLoadHttpError: (_, url, statusCode, description) => {
              debugPrint("ngoc❌ HTTP error: $statusCode - $description"),
              Navigator.pop(context)
            },
          ),
        ),
      );
    //   Scaffold(
    //   appBar: AppBar(title: const Text('Login')),
    //   body: InAppWebView(
    //     initialUrlRequest: URLRequest(url: WebUri.uri(authUrl)),
    //     onLoadStart: (controller, url) async {
    //       debugPrint("ngoc url: ${url.toString()}");
    //       if (url.toString().startsWith(KeycloakConfig.redirectUri)) {
    //         Navigator.of(context).pop(url);
    //       }
    //     },
    //   ),
    // );
  }
}
String buildLoadingHtmlPage() {
StringBuffer html = StringBuffer();

html.writeln('<!DOCTYPE html>');
html.writeln('<html>');
html.writeln('<head>');
html.writeln('  <title>Meetme</title>');
html.writeln('  <style>');
html.writeln('    body {');
html.writeln('      background-color: white;');
html.writeln('      display: flex;');
html.writeln('      align-items: center;');
html.writeln('      justify-content: center;');
html.writeln('      height: 100vh;');
html.writeln('      margin: 0;');
html.writeln('    }');
html.writeln('');
html.writeln('    .loader {');
html.writeln('      border: 4px solid #AA2FE1;');
html.writeln('      border-top: 4px solid white;');
html.writeln('      border-radius: 50%;');
html.writeln('      width: 40px;');
html.writeln('      height: 40px;');
html.writeln('      animation: spin 1s linear infinite;');
html.writeln('    }');
html.writeln('');
html.writeln('    @keyframes spin {');
html.writeln('      0% { transform: rotate(0deg); }');
html.writeln('      100% { transform: rotate(360deg); }');
html.writeln('    }');
html.writeln('  </style>');
html.writeln('</head>');
html.writeln('<body>');
html.writeln('  <div class="loader"></div>');
html.writeln('</body>');
html.writeln('</html>');

return html.toString();
}
