import 'package:egattracking/service/UserService.dart';
import 'package:flutter/material.dart';
import 'dart:ui';


class LoginPage extends StatefulWidget {
  final ValueChanged<bool> loginTriggeredAction;
  const LoginPage({Key? key, required this.loginTriggeredAction}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
  static final String keylogin = "KEY_IS_LOGIN";
}

class _LoginPageState extends State<LoginPage> {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatelessWidget inputTextWithIcon(Icon fieldIcon, String hintText,
        bool hide, TextEditingController textController) {
      return Container(
        width: 350,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: fieldIcon,
                enabled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    gapPadding: 4.0),
                hintText: hintText,
                fillColor: Colors.white,
                filled: true),
            style: TextStyle(fontSize: 16.0, color: Colors.black),
            obscureText: hide,
            controller: textController,
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 155.0,
                    child: Image.asset(
                      "assets/mainLogo.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  Container(
                    width: 250,
                    height: 50,
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  inputTextWithIcon(
                      Icon(Icons.mail), 'Username', false, _userController),
                  SizedBox(height: 10.0),
                  inputTextWithIcon(
                      Icon(Icons.lock), 'Password', true, _passwordController),
                  SizedBox(
                    height: 35.0,
                  ),
                  Container(
                    width: 250,
                    height: 50,
                    child: Text(
                      "รหัสผ่านเดียวกับเมล์ กฟผ.",
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: 250,
                    height: 50,
                    child: MaterialButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => Container(
                                  width: 40,
                                  height: 40,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(Colors.yellow),
                                    ),
                                  ),
                                ));
                        UserService.login(
                                _userController.text, _passwordController.text)
                            .then((result) => {
                                  Navigator.pop(context),
                                  if (result.uid != null)
                                    widget.loginTriggeredAction(true)
                                  else
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text("Error"),
                                              content: Text("can not login"),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("OK"),
                                                )
                                              ],
                                            ))
                                });
                      },
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      color: Color(0xfff2b706),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 155.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}