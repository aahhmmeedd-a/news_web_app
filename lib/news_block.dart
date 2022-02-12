import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class NewsBlock extends StatelessWidget {
  final ScrollController? controller;
  final bool? isAssigned;
  final List? newsData;
  final String? newsTitle;
  final String? newsDesc;
  final String? pubAt;
  final String? urlToNews;

  NewsBlock({
    @required this.controller,
    @required this.isAssigned,
    @required this.newsData,
    @required this.newsTitle,
    @required this.newsDesc,
    @required this.pubAt,
    @required this.urlToNews,
  });

  @override
  Widget build(BuildContext context) {
    // getNews();
    return isAssigned!
        ? Container(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 100.0, bottom: 100.0, left: 30.0, right: 30.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFCFD8DC),
                      Color(0xFF546E7A),
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  border: Border.all(width: 3.0),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                child: SingleChildScrollView(
                  controller: controller,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        newsTitle!,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        newsDesc!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(pubAt!),
                    ),
                    Link(
                      uri: Uri.parse(urlToNews!),
                      target: LinkTarget.blank,
                      builder: (context, followLink) => GestureDetector(
                        child: const Text(
                          "Source",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                        ),
                        onTap: followLink,
                      ),
                    )
                  ]),
                ),
              ),
            ),
          )
        : Container(
            width: 20,
            height: 20,
            child: const CircularProgressIndicator(),
          );
  }
}
