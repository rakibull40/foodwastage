import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wabmart/data/models/profile_response.dart';
import 'package:wabmart/utils/constants.dart';
import 'package:wabmart/utils/view_utils/colors.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  final dynamic id;
  ProfilePage({@required this.id});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: primaryColor),
        // collapsedHeight: 150,
        title: Text(
          "Profile Page",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        // centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder<ProfileModel>(
                  future: getProfileApi(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                              ],
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 150,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(10, 10),
                                    blurRadius: 10,
                                  ),
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(-10, -10),
                                    blurRadius: 10,
                                  ),
                                ]
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primaryColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(10, 10),
                                      blurRadius: 10,
                                    ),
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(-10, -10),
                                      blurRadius: 10,
                                    ),
                                  ]
                              ),
                              padding: EdgeInsets.all(3),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(snapshot.data.data.image),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Name: "+snapshot.data.data.name,
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins"),
                          ),
                          Text(
                            "Email: "+snapshot.data.data.email,
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          SizedBox(height: 15),
                          Container(
                            height: 130,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(top: 25),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Name:" +
                                                      snapshot.data.data.name,
                                                  style: new TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Email Address: " +
                                                snapshot.data.data.email,
                                            style: new TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Date of Birth:" +
                                                snapshot.data.data.dob.toString(),
                                            style: new TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                )),
          ],
        ),
      ),

    );
  }
}
