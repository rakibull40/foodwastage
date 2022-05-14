import 'dart:convert';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wabmart/data/models/profile_response.dart';
import 'package:wabmart/feature/screen/auth/signin.dart';
import 'package:wabmart/utils/constants.dart';
import 'package:wabmart/utils/view_utils/colors.dart';
import 'package:wabmart/http_request.dart';
import 'package:wabmart/utils/view_utils/common_util.dart';
import 'feature/screen/about_page.dart';
import 'feature/screen/policy_page.dart';
import 'get_prefs.dart';
import 'package:http/http.dart' as http;

class NavDrawer extends StatefulWidget {
  final dynamic id;
  NavDrawer({@required this.id});
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  String token = "";

  @override
  void initState() {
    super.initState();
    getCred();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString("user");
    });
  }

  Future<ProfileModel> getProfileApi() async {
    final response = await http.get(
        Uri.parse(NetworkConstants.BASE_URL + 'user/${widget.id}'),
        headers: {"Authorization": "Bearer $token"});
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProfileModel.fromJson(data);
    } else {
      return ProfileModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          FutureBuilder<ProfileModel>(
              future: getProfileApi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    color: Colors.deepPurple,
                    height: 100,
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(snapshot.data.data.name,
                                  style: TextStyle(fontSize: 20,color: Colors.white)),
                            ],
                          ),
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.green,
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(snapshot.data.data.image),
                              radius: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container(
                    color: Colors.deepPurple,
                    height: 100,
                    width: 100,
                  );
                }
              }),
          // Container(
          //   child: new TabBar(
          //     tabs: [
          //       Tab(
          //         text: ("Help"),
          //       ),
          //       Tab(
          //         text: ("Wallet"),
          //       ),
          //       Tab(
          //         text: ("History"),
          //       )
          //     ],
          //     unselectedLabelColor: Colors.black26,
          //     indicatorSize: TabBarIndicatorSize.tab,
          //     indicator: BubbleTabIndicator(
          //       indicatorHeight: 40.0,
          //       indicatorColor: Colors.amber,
          //       indicatorRadius: 10,
          //       tabBarIndicatorSize: TabBarIndicatorSize.tab,
          //       // Other flags
          //       // indicatorRadius: 1,
          //       // insets: EdgeInsets.all(1),
          //       // padding: EdgeInsets.all(10)
          //     ),
          //   ),
          // ),
          token != null
              ? Container()
              :
        new ListTile(
                  leading: Icon(FontAwesomeIcons.signInAlt),
                  title: new Text("Sign In"),
                  onTap: () {
                    // Navigator.pushNamed(context, '/categories');
                    Get.to(SignIn());
                  }),

          // new Divider(),
          // new ListTile(
          //     leading: Icon(Icons.settings),
          //     title: new Text("Settings"),
          //     onTap: () {
          //       Navigator.pop(context);
          //     }),
          // new ListTile(
          //     leading: Icon(Icons.info),
          //     title: new Text("About"),
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => AboutUs()),
          //       );
          //     }),
          // new ListTile(
          //     leading: Icon(Icons.policy),
          //     title: new Text("Policy"),
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => PrivacyPolicy()),
          //       );
          //     }),
          token != null
              ? new ListTile(
                  leading: Icon(Icons.power_settings_new),
                  title: new Text("Logout"),
                  onTap: () async {
                    // print(user['token']);
                    // await prefs.clear();
                    // Navigator.pop(context);
                    getRequest('/api/logout', null, {
                      'Content-Type': "application/json",
                      "Authorization": "Bearer ${token}"
                    }).then((value) async {
                      await prefs.clear();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                      );
                      showToast("Logged Out");
                    });
                  })
              : Container(
                  height: 0,
                ),
        ],
      ),
    );
  }
}
