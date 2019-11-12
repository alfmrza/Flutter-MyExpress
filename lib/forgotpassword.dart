import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_express/loginscreen.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

String urlUpload =
    "http://alifmirzaandriyanto.com/myexpress/php/forgot_password.php";
const PrimaryColor = const Color(0xFF3da886);

class ForgotPassScreen extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassScreen> {
  final TextEditingController _emcontroller = TextEditingController();
String _email;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        title: Text("Forgot Password"),
      ),
      body: new Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Enter your email"),
              Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey.withOpacity(0.2),
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: TextField(
                        controller: _emcontroller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          icon: Icon(Icons.email),
                        ),
                      ),
                    ),
                    ),
                    ),
                    SizedBox(height: 10,),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                minWidth: 300,
                height: 50,
                child: Text('Submit'),
                color: Color.fromRGBO(61, 168, 134, 1),
                textColor: Colors.white,
                elevation: 15,
                onPressed: _onTap,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTap() {
    _email = _emcontroller.text;
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    http.post(urlUpload, body: {
      "email": _email,
    }).then((res) {
      print(res.statusCode);
      Toast.show(res.body, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      if (res.body == "Check your email") {
        _emcontroller.text = '';
        pr.dismiss();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
      }else {
        pr.dismiss();
      }
    }).catchError((err) {
      print(err);
    });
  }
}
