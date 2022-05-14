import 'package:flutter/material.dart';
import 'package:wabmart/helpers/common_style.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(child: Body()),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: new IconButton(
        icon: new Icon(Icons.arrow_back),
        color: Colors.black,
        onPressed: () => Navigator.pop(context),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      title: Text(
        'Privacy Policy',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "Just Done",
                    style: textStyle,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
