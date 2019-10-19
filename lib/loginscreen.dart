import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_express/mainscreen.dart';
import 'package:my_express/registrationscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

String urlLogin = "http://alifmirzaandriyanto.com/myexpress/php/login_user.php";

void main() => runApp(LoginScreen());

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark));
    return MaterialApp(
      home: LoginPage(),
    ); //MaterialApp
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailcontroller = TextEditingController();
  String _email = "";
  final TextEditingController _passwordcontroller = TextEditingController();
  String _password = "";
  bool _isChecked = false;
  bool _obscureText = true;

  @override
  void initState() {
    loadpref();
    print('Init: $_email');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressAppBar,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: new Container(
            padding: EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/splash.png',
                  scale: 1.5,
                ), //Image.asset
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey.withOpacity(0.2),
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: TextField(
                        controller: _emailcontroller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          icon: Icon(Icons.email),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 15.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey.withOpacity(0.2),
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: TextField(
                        controller: _passwordcontroller,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          icon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                              icon: Icon(Icons.lock_open),
                              onPressed: () {
                                debugPrint('done');
                                _toggle();
                              }),
                        ),
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20.0)), //RoundedRectangleBorder
                  minWidth: 300,
                  height: 50,
                  child: Text('Login'),
                  color: Color.fromRGBO(61, 168, 134, 1),
                  textColor: Colors.white,
                  elevation: 15,
                  onPressed: _onLogin,
                ), //MaterialButton
                SizedBox(
                  height: 5,
                ), //SizedBox
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool value) {
                        _onChange(value);
                      },
                    ), //Checkbox
                    Text('Remember Me', style: TextStyle(fontSize: 16))
                  ], //<Widget>[]
                ), //Row
                GestureDetector(
                    onTap: _onRegister,
                    child: Text('Register New Account',
                        style: TextStyle(fontSize: 16)) //Text
                    ), //GestureDetector
                SizedBox(
                  height: 10,
                ), //SizedBox
                GestureDetector(
                    onTap: _onForgot,
                    child:
                        Text('Forgot Account', style: TextStyle(fontSize: 16))),
              ], //<Widget>
            ), //Column
          ), //Container
        ) //Scaffold
        );
  }

  void _onLogin() {
    _email = _emailcontroller.text;
    _password = _passwordcontroller.text;
    if (_isEmailValid(_email) && (_password.length > 4)) {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: "Logging in");
      pr.show();
      http.post(urlLogin, body: {
        "email": _email,
        "password": _password,
      }).then((res) {
        print(res.statusCode);
        Toast.show(res.body, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        if (res.body == "success") {
          pr.dismiss();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MainScreen(email: _email)));
          pr.dismiss();
        } else {
          pr.dismiss();
        }
      }).catchError((err) {
        pr.dismiss();
        print(err);
      });
    } else {}
  }

  void _onRegister() {
    print('onRegister');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterScreen()));
  }

  void _onForgot() {
    print('Forgot');
  }

  void _onChange(bool value) {
    setState(() {
      _isChecked = value;
      savepref(value);
    });
  }

  void loadpref() async {
    print('Inside loadpref()');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = (prefs.getString('email'));
    _password = (prefs.getString('pass'));
    print(_email);
    print(_password);
    if (_email.length > 1) {
      _emailcontroller.text = _email;
      _passwordcontroller.text = _password;
      setState(() {
        _isChecked = true;
      });
    } else {
      print('No pref');
      setState(() {
        _isChecked = false;
      });
    }
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void savepref(bool value) async {
    print('Inside savepref');
    _email = _emailcontroller.text;
    _password = _passwordcontroller.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value) {
      if (_isEmailValid(_email) && (_password.length > 5)) {
        await prefs.setString('email', _email);
        await prefs.setString('pass', _password);
        print('Save pref $_email');
        print('Save pref $_password');
        Toast.show("Preferences have been saved", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      } else {
        print('No email');
        setState(() {
          _isChecked = false;
        });
        Toast.show("Check your credentials", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    } else {
      await prefs.setString('email', '');
      await prefs.setString('pass', '');
      setState(() {
        _emailcontroller.text = '';
        _passwordcontroller.text = '';
        _isChecked = false;
      });
      print('Remove pref');
      Toast.show("Preferences have been removed", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  Future<bool> _onBackPressAppBar() async {
    SystemNavigator.pop();
    print('Backpress');
    return Future.value(false);
  }

  bool _isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
}
