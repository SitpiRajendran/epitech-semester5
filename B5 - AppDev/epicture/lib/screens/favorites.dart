import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:test_flutter/model/showcase.dart';
import 'package:test_flutter/model/images.dart';
import 'package:test_flutter/widgets/showCase.dart';
import 'package:http/http.dart' as http;
import 'package:test_flutter/main.dart';
import 'dart:convert';

class Favorites extends StatefulWidget {
  @override
  _Favorites createState() => _Favorites();
}

class _Favorites extends State<Favorites> {
  final LinearGradient favColor = LinearGradient(colors: [
    Colors.deepOrange[400],
    Colors.red[900],
  ]);
  List<Showcase> _cases = [];

  void getData() async {
    var searchUrl;
    _cases.clear();
    searchUrl =
        "https://api.imgur.com/3/account/$theUsername/gallery_favorites/";
    await http.get(Uri.encodeFull(searchUrl),
        headers: {"Authorization": 'Bearer ' + theAccessToken}).then((res) {
      if (res.statusCode == 200) {
        var rest = json.decode(res.body);
        var data = rest["data"] as List;
        List<Img> list = data.map<Img>((json) => Img.fromJson(json)).toList();
        if (mounted) {
          setState(() {
            for (var i in list) {
              var myurl;
              if (i.imgsInfo == null || i.imgsInfo[0].type.contains("video/")) {
                continue;
              } else {
                myurl = i.imgsInfo[0].url;
              }
              Showcase tuile = new Showcase(
                  i.postName,
                  myurl,
                  i.postName,
                  i.link,
                  i.postAuthor,
                  i.date,
                  i.postViews,
                  i.postUp,
                  i.postDown,
                  i.postFav);
              _cases.add(tuile);
            }
            print(_cases.length);
            setState(() {
              _cases = _cases;
            });
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(child: Container()),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
        children: <Widget>[
          Container(
            height: screensize.height * .20,
            decoration: BoxDecoration(gradient: favColor),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            left: 12, top: screensize.height * .11),
                        child: Text(
                          "FAVORITES",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: screensize.height * .05,
                              color: Colors.white),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
          StaggeredGridView.countBuilder(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(12),
            crossAxisCount: 4,
            mainAxisSpacing: 24,
            crossAxisSpacing: 12,
            itemCount: _cases.length,
            itemBuilder: (BuildContext context, int index) => ShowcaseWidget(
              showcase: _cases[index],
              deco: favColor,
              theColor: Colors.red[900],
            ),
            staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
          ),
        ],
      ),
    );
  }
}
