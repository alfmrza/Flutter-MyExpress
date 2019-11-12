import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final String email;

  const MainScreen({Key key, this.email}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  String $pagetitle = "MyExpress";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text($pagetitle),
        
      ),
      body: new Container(
        child: Center(
            child: Column(
              children: <Widget>[
                Text(widget.email),
                            ]
      ),
    ),
    ),
    );

  }
}
