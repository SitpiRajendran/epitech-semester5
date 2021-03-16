import 'package:flutter/material.dart';
import 'package:test_flutter/screens/detailPages.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:test_flutter/model/showcase.dart';

class ShowcaseWidget extends StatelessWidget {
  final Showcase showcase;
  final LinearGradient deco;
  final Color theColor;

  const ShowcaseWidget({
    @required this.showcase,
    this.deco,
    this.theColor,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
        gradient: deco,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            blurRadius: 3,
            spreadRadius: 1,
            color: Colors.black38,
          ),
        ],
      ),
      child: InkWell(
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailPage(
                          imagePath: showcase.picSrc,
                          title: showcase.title,
                          link: showcase.link,
                          author: showcase.author,
                          date: showcase.date,
                          views: showcase.views,
                          upvote: showcase.upvote,
                          downvote: showcase.downvote,
                          favorite: showcase.favorite,
                          theColor: theColor,
                        )));
          },
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(showcase.picSrc, fit: BoxFit.cover),
                  ),
                ],
              ),
              buildInfo(context),
            ],
          ),
        ),
      ));

  Widget buildInfo(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            AutoSizeText(
              (showcase.picDesc.length < 45
                  ? showcase.title
                  : (showcase.title.substring(0, 40) + "...")),
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              minFontSize: 5,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 5),
            Text(
              showcase.author,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10),
          ],
        ),
      );
}
