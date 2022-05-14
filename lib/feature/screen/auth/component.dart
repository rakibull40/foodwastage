import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
              // top: 200,
              // left: 0,
              child: Container(
            height: double.infinity,
            width: double.infinity,
            // child: Image.asset(
            //   "",
            //   fit: BoxFit.cover,
            // ),
          )),
          child,
        ],
      ),
    );
  }
}
