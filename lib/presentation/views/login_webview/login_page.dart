import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final String url = "";
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async => false,
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
        initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(url))),
        onProgressChanged: (_, progress) => {},
        onLoadError: (_, url, statusCode, description) => Get.back(),
        onLoadHttpError: (_, url, statusCode, description) => Get.back(),
      ),
    ));
  }
}
