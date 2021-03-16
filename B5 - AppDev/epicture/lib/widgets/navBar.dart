import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:test_flutter/screens/favorites.dart';
import 'package:test_flutter/screens/account.dart';
import 'package:test_flutter/screens/homePage.dart';
import 'package:test_flutter/screens/uploadPage.dart';

class MyPackage extends StatefulWidget {
  @override
  _MyPackageState createState() => _MyPackageState();
}

class _MyPackageState extends State<MyPackage> {
  int currentIndex = 1;

  List listOfPages = [
    ImageCapture(),
    HomeScreen(),
    Favorites(),
    Account(),
  ];

  List decoGradient = [
    BoxDecoration(
        gradient: RadialGradient(
            radius: 2.3,
            colors: [Colors.yellowAccent[700], Colors.yellow[900]])),
    BoxDecoration(
        gradient: RadialGradient(
            radius: 2.3, colors: [Colors.indigoAccent, Colors.indigo[800]])),
    BoxDecoration(
        gradient: RadialGradient(radius: 2.3, colors: [
      Colors.deepOrange[400],
      Colors.red[900],
    ])),
    BoxDecoration(
        gradient: RadialGradient(
            radius: 2.3, colors: [Colors.greenAccent[700], Colors.green[800]])),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: listOfPages[currentIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: decoGradient[currentIndex],
        height: MediaQuery.of(context).size.height * .09,
        child: BottomNavyBar(
          animationDuration: Duration(milliseconds: 300),
          selectedIndex: currentIndex,
          showElevation: false,
          backgroundColor: Color.fromRGBO(0, 0, 0, 0),
          itemCornerRadius: 8,
          curve: Curves.easeInBack,
          onItemSelected: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.add_a_photo),
              title: Text('Upload'),
              activeColor: Colors.white,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.trending_up),
              title: Text('Trending'),
              activeColor: Colors.white,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.favorite),
              title: Text(
                'Favorites',
              ),
              activeColor: Colors.white,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Account'),
              activeColor: Colors.white,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
