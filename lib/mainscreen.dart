import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_express/tab2.dart';
import 'package:my_express/user.dart';
import 'package:my_express/tab1.dart';
import 'package:my_express/tab4.dart';


class MainScreen extends StatefulWidget {
  final User user;

  const MainScreen({Key key, this.user}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> tabs;

  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    tabs = [
      TabScreen(user: widget.user),
      TabScreen2(user: widget.user),
      TabScreen4(user: widget.user),
    ];
  }

  String $pagetitle = "MyExpress";

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(61, 168, 134, 1)));
    return Scaffold(
      body: tabs[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex: currentTabIndex,
        type: BottomNavigationBarType.fixed,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text("Requests"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text("New Request"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, ),
            title: Text("Profile"),
          )
        ],
      ),
    );
  }
}