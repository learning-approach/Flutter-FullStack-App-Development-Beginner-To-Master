import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetails extends StatelessWidget {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  var data;
  NewsDetails(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Details'),
      ),
      body: WebView(
        initialUrl: data!.url ?? 'https://flutter.dev',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}

// to show others data

//  body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.network(
//               data!.urlToImage ??
//                   'https://us.123rf.com/450wm/mattbadal/mattbadal1911/mattbadal191100006/mattbadal191100006.jpg?ver=6',
//               height: 200,
//               width: double.maxFinite,
//               fit: BoxFit.cover,
//             ),
//             Divider(
//               color: Colors.transparent,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                 left: 20,
//                 right: 20,
//                 bottom: 20,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     data.title ?? 'Null',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 18,
//                     ),
//                   ),
//                   Divider(
//                     color: Colors.transparent,
//                   ),
//                   Text(
//                     data.author ?? 'Null',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 18,
//                         color: Colors.redAccent),
//                   ),
//                   Divider(
//                     color: Colors.transparent,
//                   ),
//                   Text(
//                     data.publishedAt ?? 'Null',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 18,
//                         color: Colors.green),
//                   ),
//                   Divider(
//                     color: Colors.transparent,
//                   ),
//                   Text(
//                     data.description ?? 'Null',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 18,
//                     ),
//                   ),
//                   Divider(
//                     color: Colors.transparent,
//                   ),
//                   Text(
//                     data.content ?? 'Null',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w400,
//                         fontSize: 18,
//                         color: Colors.black87),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               height: 250,
//               child: WebView(
//                 initialUrl: data!.url ?? 'https://flutter.dev',
//                 javascriptMode: JavascriptMode.unrestricted,
//                 onWebViewCreated: (WebViewController webViewController) {
//                   _controller.complete(webViewController);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
    