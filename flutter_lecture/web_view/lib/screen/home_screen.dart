import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


final Uri homeUrl = Uri.parse("https://blog.codefactory.ai");


class HomeScreen extends StatelessWidget {
  WebViewController controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..loadRequest(homeUrl);

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CodeFactory"),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {
                controller.loadRequest(homeUrl);
              },
              icon: const Icon(Icons.home))
        ],
      ),
      body: WebViewWidget(controller: controller,)
      // WebView(
      //   onWebViewCreated: (WebViewController controller) {
      //     this.controller = controller;
      //   },
      //   initialUrl: homeUrl,
      //   javascriptMode: JavascriptMode.unrestricted,
      // ),
    );
  }
}
