import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wabmart/feature/screen/auth/ProgressHUD.dart';
import 'package:wabmart/feature/screen/auth/hero_sign_up.dart';
import 'package:wabmart/feature/screen/auth/signin.dart';
import 'package:wabmart/feature/screen/auth/signup.dart';
import 'package:wabmart/feature/screen/home/home_screen.dart';
import 'package:wabmart/show_toast.dart';
import 'package:wabmart/utils/constants.dart';
import 'package:wabmart/utils/view_utils/colors.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  void login(String  email, password) async {
    try {
      Response response = await post(
          Uri.parse(NetworkConstants.BASE_URL + 'login'),
          body: {
            'email': email,
            'password': password,
          });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        pageRoute(data["token"]);
        // print('created');
        setState(() {
          isApiCallProcess = false;
        });
        showToast(context, data['message']);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(id: data['user_info']['id'])),
        );
      } else {
        var data = jsonDecode(response.body.toString());
        showToast(context, data['message']);
      }
    } catch (e) {
      setState(() {
        isApiCallProcess = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("server error"),
              actions: [
                FlatButton(
                  child: Text("Try Again"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  bool isApiCallProcess = false;
 pageRoute(String token)async{
   SharedPreferences pref = await SharedPreferences.getInstance();
       await pref.setString("user", token);
 }
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetupp(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget _uiSetupp(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: new Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                    Colors.deepPurpleAccent.shade200,
                    Colors.deepPurpleAccent.shade700,
                    Colors.deepPurpleAccent.shade400
                  ])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  // #login, #welcome
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign In",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60)),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Container(
                                    child: SingleChildScrollView(
                                        physics: NeverScrollableScrollPhysics(),
                                        child: Column(
                                          children: <Widget>[
                                            Image.asset('assets/food.png',
                                                width: 160, height: 120),
                                            new Row(
                                              children: <Widget>[
                                                new Expanded(
                                                  child: new Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 40.0),
                                                    child: new Text(
                                                      "EMAIL",
                                                      style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        color: primaryColor,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            new Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: const EdgeInsets.only(
                                                  left: 40.0,
                                                  right: 40.0,
                                                  top: 10.0),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      color: primaryColor,
                                                      width: 0.5,
                                                      style: BorderStyle.solid),
                                                ),
                                              ),
                                              padding: const EdgeInsets.only(
                                                  left: 0.0, right: 10.0),
                                              child: new Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: <Widget>[
                                                  new Expanded(
                                                    child: TextFormField(
                                                      textAlign: TextAlign.left,
                                                      controller:
                                                      emailEditingController,
                                                      keyboardType:
                                                      TextInputType
                                                          .emailAddress,
                                                      // inputFormatters: <TextInputFormatter>[
                                                      //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                      // ],
                                                      decoration:
                                                      InputDecoration(
                                                        border:
                                                        InputBorder.none,
                                                        hintText:
                                                        'youremail@live.com',
                                                        hintStyle: TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter your email';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              height: 24.0,
                                            ),
                                            new Row(
                                              children: <Widget>[
                                                new Expanded(
                                                  child: new Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 40.0),
                                                    child: new Text(
                                                      "PASSWORD",
                                                      style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        color: primaryColor,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            new Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: const EdgeInsets.only(
                                                  left: 40.0,
                                                  right: 40.0,
                                                  top: 10.0),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      color: primaryColor,
                                                      width: 0.5,
                                                      style: BorderStyle.solid),
                                                ),
                                              ),
                                              padding: const EdgeInsets.only(
                                                  left: 0.0, right: 10.0),
                                              child: new Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: <Widget>[
                                                  new Expanded(
                                                    child: TextFormField(
                                                      controller:
                                                      passwordEditingController,
                                                      obscureText: true,
                                                      textAlign: TextAlign.left,
                                                      decoration:
                                                      InputDecoration(
                                                        border:
                                                        InputBorder.none,
                                                        hintText: '*********',
                                                        hintStyle: TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter your password';
                                                        }
                                                        if (value.length < 6) {
                                                          return 'Password must be at least 6 characters in';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            new Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 20.0),
                                                  child: new FlatButton(
                                                    child: new Text(
                                                      "Forgot Password",
                                                          style:TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 15.0,
                                                            color:Colors.red,
                                                          ),
                                                      textAlign: TextAlign.end,
                                                    ),
                                                    onPressed: (){return showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: Text('Enter Phone number'),
                                                            content: TextField(
                                                              onChanged: (value) {
                                                                setState(() {
                                                                });
                                                              },
                                                              decoration: InputDecoration(hintText: "Phone Number"),
                                                            ),
                                                            actions: <Widget>[
                                                              FlatButton(
                                                                color: Colors.red,
                                                                textColor: Colors.white,
                                                                child: Text('CANCEL'),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    Navigator.pop(context);
                                                                  });
                                                                },
                                                              ),
                                                              FlatButton(
                                                                color: Colors.green,
                                                                textColor: Colors.white,
                                                                child: Text('OK'),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    Navigator.pop(context);
                                                                  });
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        });},
                                                  ),
                                                )
                                              ],
                                            ),
                                            Divider(
                                              height: 24.0,
                                            ),
                                            new Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: const EdgeInsets.only(
                                                  left: 30.0,
                                                  right: 30.0,
                                                  top: 10.0),
                                              alignment: Alignment.center,
                                              child: new Row(
                                                children: <Widget>[
                                                  new Expanded(
                                                    child: new FlatButton(
                                                      shape:
                                                      new RoundedRectangleBorder(
                                                        borderRadius:
                                                        new BorderRadius
                                                            .circular(30.0),
                                                      ),
                                                      color: primaryColor,
                                                      onPressed: () {
                                                        if (formKey.currentState
                                                            .validate()) {
                                                          setState(() {
                                                            isApiCallProcess =
                                                            true;
                                                          });
                                                          login(
                                                            emailEditingController
                                                                .text
                                                                .toString(),
                                                            passwordEditingController
                                                                .text
                                                                .toString(),
                                                          );
                                                        }
                                                      },
                                                      child: new Container(
                                                        padding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                          vertical: 20.0,
                                                          horizontal: 20.0,
                                                        ),
                                                        child: new Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: <Widget>[
                                                            new Expanded(
                                                              child: Text(
                                                                "LOG IN",
                                                                textAlign:
                                                                TextAlign
                                                                    .center,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: new Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    "Register Here",
                                                    style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 18.0,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: new TextButton(
                                                      child: new Text(
                                                        "SignUp",
                                                        style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color: Colors.blue,
                                                          fontSize: 18.0,
                                                        ),
                                                        textAlign:
                                                        TextAlign.center,
                                                      ),
                                                      onPressed: () => {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                  SignUp()),
                                                        ),
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ))),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }
}
