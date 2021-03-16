import 'package:flutter/material.dart';
import 'package:test_flutter/widgets/navBar.dart';
import 'package:test_flutter/main.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ConnectionScreen extends StatefulWidget {
  @override
  _ConnectionScreen createState() => _ConnectionScreen();
}

class _ConnectionScreen extends State<ConnectionScreen> {
  BuildContext context;
  final flutterWebviewPlugin = FlutterWebviewPlugin();

  void clearData() {
    flutterWebviewPlugin.cleanCookies();
    flutterWebviewPlugin.clearCache();
    flutterWebviewPlugin.close();
  }

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (state.url.indexOf("https://m.imgur.com/#access_token") != -1) {
        var parser = state.url.split('#');
        parser = parser[1].split('&');
        theAccessToken = parser[0].replaceFirst("access_token=", "");
        theRefreshToken = parser[3].replaceFirst("refresh_token=", "");
        theUsername = parser[4].replaceFirst("account_username=", "");
        theUserID = parser[5].replaceFirst("account_id=", "");
        print(theAccessToken);
        print(theRefreshToken);
        print(theUsername);
        print(theUserID);
      }
      if (theUsername != "") {
        flutterWebviewPlugin.close();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyPackage(),
            ));
      }
    });
  }

  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() => this.context = context);
    return WebviewScaffold(
      url: theUrl,
      appBar: new AppBar(title: new Text("Login to Imgur")),
      clearCache: true,
      appCacheEnabled: true,
    );
  }
}
