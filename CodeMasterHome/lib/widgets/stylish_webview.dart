import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StylishWebview extends StatefulWidget {
  final String url ;
  final String? title;


  StylishWebview({required this.url,this.title});

  @override
  _StylishWebviewState createState() => _StylishWebviewState();
}

class _StylishWebviewState extends State<StylishWebview> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print("Loading progress: $progress%");
          },
          onPageStarted: (String url) {
            print("Page started: $url");
          },
          onPageFinished: (String url) {
            print("Page finished: $url");
          },
          onWebResourceError: (WebResourceError error) {
            print("Web resource error: ${error.description}");
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('${widget.title}')),
      body: PopScope(
        canPop: false, // Prevent default back behavior
        onPopInvoked: (bool didPop) async {
          if (didPop) {
            return; // Don't do anything if PopScope already handled it
          }
          if (await _controller.canGoBack()) {
            _controller.goBack();
          } else {
            Navigator.of(context).pop(); // Go back from the webview screen
          }
        },
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}