import 'package:flutter/material.dart';


class MainScreen extends StatefulWidget {
  final String email;

 const MainScreen({Key key,this.email}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
 List<Widget> tabs;

 int currentTabIndex = 0;

  String $pagetitle = "Home";

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text($pagetitle),
      ),
      body: tabs[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex: currentTabIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text("Jobs"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            title: Text("Messages"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
          )
        ],
      ),
    );
  }

  
}