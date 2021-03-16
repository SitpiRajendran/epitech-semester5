import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:test_flutter/model/showcase.dart';
import 'package:test_flutter/model/images.dart';
import 'package:test_flutter/widgets/showCase.dart';
import 'package:http/http.dart' as http;
import 'package:test_flutter/main.dart';
import 'dart:convert';

class Account extends StatefulWidget {
  @override
  _Account createState() => _Account();
}

class _Account extends State<Account> {
  final LinearGradient homeColor = LinearGradient(colors: [
    Colors.greenAccent[700],
    Colors.green[800],
  ]);
  List<Showcase> _cases = [];

  void getData() async {
    var searchUrl;
    _cases.clear();
    searchUrl = "https://api.imgur.com/3/account/me/images";
    await http.get(Uri.encodeFull(searchUrl),
        headers: {"Authorization": 'Bearer ' + theAccessToken}).then((res) {
      if (res.statusCode == 200) {
        var rest = json.decode(res.body);
        var data = rest["data"] as List;
        List<Img> list = data.map<Img>((json) => Img.fromJson(json)).toList();
        if (mounted) {
          setState(() {
            for (var i in list) {
              Showcase tuile = new Showcase(
                  i.postName,
                  i.link,
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
            decoration: BoxDecoration(gradient: homeColor),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            right: 12, top: screensize.height * .11),
                        child: AutoSizeText(
                          theUsername,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: screensize.height * .05,
                              color: Colors.white),
                          maxLines: 1,
                        ),
                      )
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
            itemCount: _cases.length - 1,
            itemBuilder: (BuildContext context, int index) => ShowcaseWidget(
              showcase: _cases[index],
              deco: homeColor,
              theColor: Colors.greenAccent[700],
            ),
            staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
          ),
        ],
      ),
    );
  }
}
