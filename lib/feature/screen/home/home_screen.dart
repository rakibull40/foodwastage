import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inkwell_splash/inkwell_splash.dart';
import 'package:wabmart/feature/screen/user/profile/profile_page.dart';
import 'package:wabmart/utils/view_utils/colors.dart';
import 'package:wabmart/drawer.dart';
import 'package:wabmart/get_prefs.dart';

class HomeScreen extends StatefulWidget {
  final dynamic id, role;
  HomeScreen({@required this.id, this.role});
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // HomeController _controller = HomeController(repository: Get.find());
  bool navbarScrolled = false;
  // AnimationController _controller_body;
  var user;
  double width, height = 55.0;
  double customFontSize = 13;
  String defaultFontFamily = 'Roboto-Light.ttf';

  @override
  void initState() {
    getUser().then((value) {
      setState(() {
        user = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(id: widget.id),
      // bottomNavigationBar: CustomBottomNavigation(),
      extendBody: true,
      body: new NestedScrollView(
          key: UniqueKey(),
          controller: ScrollController(keepScrollOffset: true),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // print(innerBoxIsScrolled);

            return <Widget>[
              new SliverAppBar(
                iconTheme: IconThemeData(color: primaryColor),
                // collapsedHeight: 150,
                title: Image.asset(
                  'assets/food.png',
                  fit: BoxFit.contain,
                  height: 100,
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
                pinned: true,
                floating: true,
                forceElevated: innerBoxIsScrolled,
              ),
            ];
          },
          body: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Welcome to Food Waste Management System\nSelect an option",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 5),
                      SizedBox(
                        width: 160.0,
                        height: 160.0,
                        child: Card(
                          color: Colors.deepPurple,
                          shadowColor: Colors.black,
                          elevation: 6.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: InkWellSplash(
                            splashFactory: InkRipple.splashFactory,
                            splashColor: Colors.white70,
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.only(top: 25.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/avatar.jpg",
                                    width: 64.0,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "User Profile",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                ],
                              ),
                            )),
                            onTap: () {
                              Get.to(ProfilePage(id: widget.id));
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ))),
    );
  }
}
