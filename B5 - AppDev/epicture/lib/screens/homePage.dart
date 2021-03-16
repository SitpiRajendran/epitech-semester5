import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:test_flutter/model/showcase.dart';
import 'package:test_flutter/model/images.dart';
import 'package:test_flutter/widgets/showCase.dart';
import 'package:test_flutter/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var option1 = 1;
List<Showcase> _cases = [];

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LinearGradient homeColor = LinearGradient(colors: [
    Colors.indigoAccent,
    Colors.indigo[800],
  ]);

  void getData() async {
    var searchUrl;
    _cases.clear();
    if (option1 == 1) {
      searchUrl = "https://api.imgur.com/3/gallery/hot";
    } else if (option1 == 2) {
      searchUrl = "https://api.imgur.com/3/gallery/user";
    } else if (option1 == 3) {
      searchUrl = "https://api.imgur.com/3/gallery/top";
    }
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

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 20, bottom: 5),
                  child: Text(
                    "EDIT FILTERS",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: MediaQuery.of(context).size.height * .02),
                  ),
                ),
                ListTile(
                  leading: new Icon(Icons.offline_bolt,
                      color: option1 == 1 ? Colors.blueAccent : Colors.black),
                  title: new Text('Hottest'),
                  onTap: () {
                    option1 = 1;
                    getData();
                    Navigator.of(context).pop();
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                ),
                ListTile(
                    leading: new Icon(Icons.gesture,
                        color: option1 == 2 ? Colors.blueAccent : Colors.black),
                    title: new Text('Random'),
                    onTap: () {
                      option1 = 2;
                      getData();
                      Navigator.of(context).pop();
                      FocusScope.of(context).requestFocus(FocusNode());
                    }),
                ListTile(
                    leading: new Icon(Icons.star,
                        color: option1 == 3 ? Colors.blueAccent : Colors.black),
                    title: new Text('Newest'),
                    onTap: () {
                      option1 = 3;
                      getData();
                      Navigator.of(context).pop();
                      FocusScope.of(context).requestFocus(FocusNode());
                    }),
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;

    return Scaffold(
      drawer: Drawer(child: Container()),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
        children: <Widget>[
          Container(
            height: screensize.height * .28,
            decoration: BoxDecoration(gradient: homeColor),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: 7, top: screensize.height * .04),
                          child: IconButton(
                            icon: Icon(
                              Icons.filter_list,
                              color: Colors.white,
                              size: screensize.height * .04,
                            ),
                            onPressed: () {
                              _settingModalBottomSheet(context);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          "TRENDING",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: screensize.height * .05,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: screensize.height * .02,
                            bottom: screensize.height * .01),
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(29.5),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search",
                            icon: Icon(Icons.search),
                            border: InputBorder.none,
                          ),
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
              deco: homeColor,
              theColor: Colors.indigo[800],
            ),
            staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
          ),
        ],
      ),
    );
  }
}
