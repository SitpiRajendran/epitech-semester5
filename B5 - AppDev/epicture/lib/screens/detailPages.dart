import 'package:flutter/material.dart';
import 'package:test_flutter/screens/homePage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:test_flutter/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class DetailPage extends StatefulWidget {
  final String imagePath;
  final String title;
  final String author;
  final String link;
  final int date;
  final int views;
  final int upvote;
  final int downvote;
  final int favorite;
  final Color theColor;
  DetailPage({
    this.imagePath,
    this.title,
    this.author,
    this.link,
    this.date,
    this.views,
    this.upvote,
    this.downvote,
    this.favorite,
    this.theColor,
  });

  @override
  _DetailPage createState() => _DetailPage(
        this.imagePath,
        this.title,
        this.author,
        this.link,
        this.date,
        this.views,
        this.upvote,
        this.downvote,
        this.favorite,
        this.theColor,
      );
}

class _DetailPage extends State<DetailPage> {
  final String imagePath;
  final String title;
  final String author;
  final String link;
  final int date;
  final int views;
  final int upvote;
  final int downvote;
  final int favorite;
  final Color theColor;
  _DetailPage(
    this.imagePath,
    this.title,
    this.author,
    this.link,
    this.date,
    this.views,
    this.upvote,
    this.downvote,
    this.favorite,
    this.theColor,
  );

  int isUpvote = 0;
  int isFavorite = 0;

  void updateData(albumId) async {
    await http.post(
        Uri.encodeFull("https://api.imgur.com/3/album/$albumId/favorite"),
        headers: {"Authorization": 'Bearer ' + theAccessToken});
    await http.post(
        Uri.encodeFull("https://api.imgur.com/3/album/$albumId/favorite"),
        headers: {"Authorization": 'Bearer ' + theAccessToken}).then((res) {
      if (res.statusCode == 200) {
        var rest = json.decode(res.body);
        var data = rest["data"] as String;
        if (data == "favorited") {
          print("is in favorite");
          setState(() {
            isFavorite = 1;
          });
        } else if (data == "unfavorited") {
          print("is not in favorite");
          setState(() {
            isFavorite = 0;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    print(link);
    var albumId = link.substring(20);
    print(albumId);
    updateData(albumId);
    String string = DateFormat()
        .format(DateTime.fromMicrosecondsSinceEpoch(date * 1000000));
    return Scaffold(
        appBar: AppBar(
            backgroundColor: theColor,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            title: new Text("Details")),
        body: Container(
            color: theColor,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              Expanded(
                child: Center(
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Hero(
                          tag: title,
                          child: Image.network(
                            imagePath,
                            fit: BoxFit.fitHeight,
                          ))),
                ),
              ),
              Container(
                width: screensize.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "by $author",
                            style: TextStyle(
                              backgroundColor: theColor,
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Text(
                          "On " + string,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: screensize.height * 0.01,
                        ),
                        Row(children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.keyboard_arrow_up,
                                  color: (isUpvote == 1
                                      ? Colors.green
                                      : Colors.black)),
                              onPressed: () {
                                if (isUpvote != 1) {
                                  http.post(
                                      Uri.encodeFull(
                                          "https://api.imgur.com/3/gallery/$albumId/vote/up"),
                                      headers: {
                                        "Authorization":
                                            'Bearer ' + theAccessToken
                                      }).then((res) {
                                    if (res.statusCode == 200) {
                                      Fluttertoast.showToast(
                                          msg: "You up-voted this post 👍",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 14.0);
                                    }
                                    setState(() {
                                      isUpvote = 1;
                                    });
                                  });
                                } else {
                                  http.post(
                                      Uri.encodeFull(
                                          "https://api.imgur.com/3/gallery/$albumId/vote/veto"),
                                      headers: {
                                        "Authorization":
                                            'Bearer ' + theAccessToken
                                      }).then((res) {
                                    if (res.statusCode == 200) {
                                      Fluttertoast.showToast(
                                          msg: "Up vote has been remove ❌",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 14.0);
                                    }
                                    setState(() {
                                      isUpvote = 0;
                                    });
                                  });
                                }
                              }),
                          Text(upvote.toString()),
                          Spacer(),
                          IconButton(
                              icon: Icon(Icons.keyboard_arrow_down,
                                  color: (isUpvote == 2
                                      ? Colors.deepOrange
                                      : Colors.black)),
                              onPressed: () {
                                if (isUpvote != 2) {
                                  http.post(
                                      Uri.encodeFull(
                                          "https://api.imgur.com/3/gallery/$albumId/vote/down"),
                                      headers: {
                                        "Authorization":
                                            'Bearer ' + theAccessToken
                                      }).then((res) {
                                    if (res.statusCode == 200) {
                                      Fluttertoast.showToast(
                                          msg: "You down-voted this post 👎",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 14.0);
                                      setState(() {
                                        isUpvote = 2;
                                      });
                                    }
                                  });
                                } else {
                                  http.post(
                                      Uri.encodeFull(
                                          "https://api.imgur.com/3/gallery/$albumId/vote/veto"),
                                      headers: {
                                        "Authorization":
                                            'Bearer ' + theAccessToken
                                      }).then((res) {
                                    if (res.statusCode == 200) {
                                      Fluttertoast.showToast(
                                          msg: "Down vote has been remove ❌",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 14.0);
                                      setState(() {
                                        isUpvote = 0;
                                      });
                                    }
                                  });
                                }
                              }),
                          Text(downvote.toString()),
                          Spacer(),
                          IconButton(
                              icon: Icon(Icons.favorite,
                                  color: (isFavorite == 1
                                      ? Colors.red
                                      : Colors.black)),
                              onPressed: () {
                                http.post(
                                    Uri.encodeFull(
                                        "https://api.imgur.com/3/album/$albumId/favorite"),
                                    headers: {
                                      "Authorization":
                                          'Bearer ' + theAccessToken
                                    }).then((res) {
                                  if (res.statusCode == 200) {
                                    Fluttertoast.showToast(
                                        msg: isFavorite == 1
                                            ? "This post has been removed from your favorites 💔"
                                            : "This post has been added in your favorites ❤️",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 14.0);
                                    setState(() {
                                      if (isFavorite == 1)
                                        isFavorite = 0;
                                      else
                                        isFavorite = 1;
                                    });
                                  }
                                });
                              }),
                          Text(favorite.toString()),
                          Spacer(),
                          Icon(Icons.remove_red_eye),
                          Text("  " +
                              (views > 1000
                                  ? ((views / 100).round() / 10).toString() +
                                      'k'
                                  : views.toString())),
                        ])
                      ]),
                ),
              ),
            ])));
  }
}
