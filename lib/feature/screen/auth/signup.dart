import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:date_field/date_field.dart';
import 'package:wabmart/feature/screen/auth/ProgressHUD.dart';
import 'package:wabmart/feature/screen/auth/hero_sign_up.dart';
import 'package:wabmart/feature/screen/auth/signin.dart';
import 'package:wabmart/show_toast.dart';
import 'package:wabmart/utils/constants.dart';
import 'package:wabmart/utils/view_utils/colors.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameEditingController = TextEditingController();

  TextEditingController emailEditingController = TextEditingController();

  TextEditingController phoneEditingController = TextEditingController();

  TextEditingController passwordEditingController = TextEditingController();
  // TextEditingController dobEditingController = TextEditingController();

  void login(String name, email, phone, password) async {
    try {
      Response response = await post(
          Uri.parse(NetworkConstants.BASE_URL + 'user/create'),
          body: {
            'name': name,
            'email': email,
            'password': password,
            'phone': phone,
            'role': 'Master',
            'dob': "1999-10-02",
          });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        // print('created');
        setState(() {
          isApiCallProcess = false;
        });
        showToast(context, data['message']);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignIn()),
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
              title: Text("User Name Exist"),
              content: Text("Please enter new user data."),
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
  double age = 0.0;
  var selectedYear;
  var day;
  var month;
  void _showPicker() {
    showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        initialDate: DateTime(2022),
        lastDate: DateTime.now())
        .then((DateTime year) {
      selectedYear = year?.year;
      day = year?.day;
      month = year?.month;

      calculateAge();
    });
  }

  void calculateAge() {
    setState(() {
      age = (2022 - selectedYear).toDouble();
    });
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
                          "Sign Up",
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
                                                      "NAME",
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
                                                          nameEditingController,
                                                      keyboardType:
                                                          TextInputType.name,
                                                      // inputFormatters: <TextInputFormatter>[
                                                      //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                      // ],
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: 'your name',
                                                        hintStyle: TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter your name';
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
                                                      validator: (value) => EmailValidator.validate(value) ? null : "Please enter a valid email",
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
                                                      "PHONE",
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
                                                          phoneEditingController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: <
                                                          TextInputFormatter>[
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                r'[0-9]')),
                                                      ],
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: '01*********',
                                                        hintStyle: TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter your phone number ';
                                                        }
                                                        if (value.length < 11 || value.length>11) {
                                                          return 'Phone number has to be 11 character';
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
                                                      "Date OF Birth",
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
                                            // new Container(
                                            //   width: MediaQuery.of(context)
                                            //       .size
                                            //       .width,
                                            //   margin: const EdgeInsets.only(
                                            //       left: 40.0,
                                            //       right: 40.0,
                                            //       top: 10.0),
                                            //   alignment: Alignment.center,
                                            //   decoration: BoxDecoration(
                                            //     border: Border(
                                            //       bottom: BorderSide(
                                            //           color: primaryColor,
                                            //           width: 0.5,
                                            //           style: BorderStyle.solid),
                                            //     ),
                                            //   ),
                                            //   padding: const EdgeInsets.only(
                                            //       left: 0.0, right: 10.0),
                                            //   child: new Row(
                                            //     crossAxisAlignment:
                                            //         CrossAxisAlignment.center,
                                            //     mainAxisAlignment:
                                            //         MainAxisAlignment.start,
                                            //     children: <Widget>[
                                            //       new Expanded(
                                            //         child: DateTimeFormField(
                                            //           decoration: const InputDecoration(
                                            //             hintStyle: TextStyle(color: Colors.black45),
                                            //             errorStyle: TextStyle(color: Colors.redAccent),
                                            //             border: OutlineInputBorder(),
                                            //             suffixIcon: Icon(Icons.event_note),
                                            //             labelText: 'date',
                                            //           ),
                                            //           mode: DateTimeFieldPickerMode.date,
                                            //           autovalidateMode: AutovalidateMode.always,
                                            //           // validator: (e) => (e?.day ?? 0) == 6570 ? 'you are under 18' : null,
                                            //           onDateSelected: (DateTime value) {
                                            //             print(value);
                                            //           },
                                            //           validator: (value) {
                                            //             if (value == "April 19,2004" ) {
                                            //               return 'under 18';
                                            //             }
                                            //             return null;
                                            //           },
                                            //         ),
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),
                                            OutlineButton(
                                              child: Text(day != null
                                                  ? day.toString() +
                                                  "/" +
                                                  month.toString() +
                                                  "/" +
                                                  selectedYear.toString()
                                                  : "Select date of birth"),
                                              borderSide: const BorderSide(color: Colors.black, width: 3.0),
                                              color: Colors.white,
                                              onPressed: _showPicker,
                                            ),
                                            age!=0&&age<18?const Text("Age must be 18 or higher",
                                              style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
                                                :Text(""),
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
                                                            nameEditingController
                                                                .text
                                                                .toString(),
                                                            emailEditingController
                                                                .text
                                                                .toString(),
                                                            phoneEditingController
                                                                .text
                                                                .toString(),
                                                            passwordEditingController
                                                                .text
                                                                .toString(),
                                                            // dobEditingController
                                                            //     .text
                                                            //     .toString(),
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
                                                                "REGISTER",
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
                                                    "Already have an account?",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.0,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: new TextButton(
                                                      child: new Text(
                                                        "LOGIN",
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
                                                                      SignIn()),
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
