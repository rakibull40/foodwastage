import 'package:flutter/material.dart';
import 'package:wabmart/feature/screen/auth/component.dart';
import 'package:wabmart/feature/screen/auth/signin.dart';
import 'package:wabmart/feature/screen/auth/signup.dart';
import 'package:wabmart/feature/screen/auth/widget/rounded_button.dart';

class BodyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "WELCOME TO ",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text("Food wastage management system",
                      style: TextStyle(
                          color: Color(0xFF363062),
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            // Text(
            //   "Let's save some time and energy today!",
            //   style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
            // ),
            Image.asset(
              'assets/Image.png',
              height: size.height * 0.35,
            ),
            SizedBox(height: 15),
            RoundedButton(
              color: Colors.deepPurpleAccent,
              text: "SIGN IN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignIn();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: Colors.deepPurpleAccent,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUp();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
