import 'dart:convert';

import 'package:flutter/material.dart';

import './news_block.dart';
import 'package:http/http.dart' as http;
import 'package:date_format/date_format.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final __controller = ScrollController();

  List newsApiKeys = [
    "4314d1a187b74cceaecd878d4916abe0",
    "6e645382a2f148c6bbb16d29f0c0fc11",
    "d32a99886414479ca5ff90620c0a4d32"
  ];

  List newsData = [];
  List newsTitle = [];
  List newsDesc = [];
  List newsUrl = [];
  List newsImgUrl = [];
  List newsPublishedAt = [];
  List newsContent = [];
  bool isAssigned = false;

  int index = 0;

  final _controller = ScrollController();

  getNews() async {
    http.Response response = await http.get(Uri.parse(
        "https://newsapi.org/v2/everything?q=programming&from=" +
            formatDate(DateTime.now().subtract(const Duration(days: 7)),
                [yyyy, '-', mm, '-', dd]) +
            "&sortBy=publishedAt&apiKey=d32a99886414479ca5ff90620c0a4d32"));
    final json = "[" + response.body + "]";
    newsData = jsonDecode(json);
    setState(() {
      isAssigned = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    getNews();
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xFFCFD8DC),
        Color(0xFF546E7A),
      ])),
      child: Column(children: [
        const Text(
          "Newsify",
          style: TextStyle(
            color: Colors.black,
            fontSize: 50.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.85,
            alignment: Alignment.center,
            child: Column(
              children: [
                isAssigned
                    ? NewsBlock(
                        controller: _controller,
                        isAssigned: isAssigned,
                        newsData: newsData,
                        newsTitle: newsData[0]["articles"][index]["title"] ??
                            "No Title",
                        newsDesc: newsData[0]["articles"][index]
                                ["description"] ??
                            "No Description",
                        pubAt: newsData[0]["articles"][index]["publishedAt"] ??
                            "unknown publish date",
                        urlToNews: newsData[0]["articles"][index]["url"] ??
                            showDialog(
                                context: context,
                                barrierDismissible:
                                    false, // disables popup to close if tapped outside popup (need a button to close)
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      "No valid url!",
                                    ),
                                    content: const Text("Cannot redirect!"),
                                    //buttons?
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text("Close"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        }, //closes popup
                                      ),
                                    ],
                                  );
                                }))
                    : const CircularProgressIndicator(),
                ElevatedButton(
                  child: const Text("NextNews"),
                  onPressed: () {
                    if (index < newsData[0]['articles'].length - 1) {
                      setState(() {
                        index += 1;
                      });
                    } else if (index == newsData[0]['articles'].length - 1) {
                      showDialog(
                          context: context,
                          barrierDismissible:
                              false, // disables popup to close if tapped outside popup (need a button to close)
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                "No news!",
                              ),
                              content: const Text("No new news to show!"),
                              //buttons?
                              actions: <Widget>[
                                TextButton(
                                  child: const Text("Close"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }, //closes popup
                                ),
                              ],
                            );
                          });
                    }
                  },
                ),
              ],
            )),
      ]),
    ));
  }
}
