import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LiveChat extends StatefulWidget {
  const LiveChat({Key? key}) : super(key: key);

  @override
  State<LiveChat> createState() => _LiveChatState();
}

class _LiveChatState extends State<LiveChat> {
  final String title = 'AUY27 online agent';
  final String selectedUrl = '';

  int position = 1;

  final key = UniqueKey();

  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  startLoading(String A) {
    setState(() {
      position = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Center(
          child: const Text(
            'AUY27 Live Chat',
            style: TextStyle(
              color: Color.fromRGBO(47, 79, 79, 1),
            ),
          ),
        ),
        // leading: InkWell(
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        //   child: const Icon(
        //     Icons.arrow_back,
        //     color: Color.fromRGBO(47, 79, 79, 1),
        //   ),
        // ),
      ),
      body: IndexedStack(
        index: position,
        children: <Widget>[
          WebView(
            initialUrl:
                'https://tawk.to/chat/66162bcd1ec1082f04e0b871/1hr39m7co',
            javascriptMode: JavascriptMode.unrestricted,
            key: key,
            onPageFinished: doneLoading,
            onPageStarted: startLoading,
          ),
          Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
