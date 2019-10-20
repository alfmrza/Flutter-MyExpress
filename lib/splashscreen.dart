import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'loginscreen.dart'; 
void main() => runApp(SplashScreen());
 
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.dark));
    return MaterialApp(
      theme: new ThemeData(primarySwatch: MaterialColor(0xFF3da886, color)),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/splash.png',
                scale: 1,
              ), 
              new ProgressIndicator(),
            ], 
          ), 
        ), 
      ), 
    ); 
  }
}
class ProgressIndicator extends StatefulWidget{
  @override
  _ProgressIndicatorState createState() => new _ProgressIndicatorState();
}

class _ProgressIndicatorState extends State<ProgressIndicator>
with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation<double>animation;

  @override
  void initState(){
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 2000), vsync: this); //AnimationController
      animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener((){
        setState(() {
          if (animation.value > 0.99){
            Navigator.pushReplacement(context, 
            MaterialPageRoute(
              builder: (BuildContext context) =>LoginScreen()
              )
              );   
                controller.dispose();      
                }
        });
      });
    controller.repeat();
  }
  @override
  Widget build(BuildContext context){
    
    return new Center(
      child: new Container(
        width: 200,
        color: Colors.teal,
        child: LinearProgressIndicator(
          value: animation.value,
          backgroundColor: Colors.black,
          valueColor: 
          new AlwaysStoppedAnimation<Color>(Color.fromRGBO(61, 168, 134, 1)),
          ), //LinearProgressIndicator
      ) //Container
      ); //Center
  }
}

Map<int, Color> color = {
  50: Color.fromRGBO(61, 168, 134, .1),
  100: Color.fromRGBO(61, 168, 134, .2),
  200: Color.fromRGBO(61, 168, 134, .3),
  300: Color.fromRGBO(61, 168, 134, .4),
  400: Color.fromRGBO(61, 168, 134, .5),
  500: Color.fromRGBO(61, 168, 134, .6),
  600: Color.fromRGBO(61, 168, 134, .7),
  700: Color.fromRGBO(61, 168, 134, .8),
  800: Color.fromRGBO(61, 168, 134, .9),
  900: Color.fromRGBO(61, 168, 134, 1),
};