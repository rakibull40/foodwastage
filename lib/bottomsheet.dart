import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';


class Bottomsheet extends StatefulWidget {
  final String title;
  final String content;
  Bottomsheet({Key key, this.content, this.title}) : super(key: key);

  @override
  _BottomsheetState createState() => new _BottomsheetState(this.title, this.content);
}

class _BottomsheetState extends State<Bottomsheet> with TickerProviderStateMixin {
  String title;
  String content;
  _BottomsheetState(this.title, this.content);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height-300,

      height: MediaQuery.of(context).size.height * 0.60,
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(this.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),),
            ),
            SizedBox(height: 20,),
              Container(
                height: MediaQuery.of(context).size.height * 0.49,
                child: ListView(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  Html( data: this.content)
                ],
              ),
            )
            // SingleChildScrollView(
            //   scrollDirection: Axis.vertical,
            //   child: Column(
            //     // crossAxisAlignment: CrossAxisAlignment.stretch,
            //     children: [
            //
            //     ]
            //   )
            // )
            // ElevatedButton(
            //   child: const Text('Close BottomSheet'),
            //   onPressed: () => Navigator.pop(context),
            // )
          ],
        ),
      ),
    );
  }
}
