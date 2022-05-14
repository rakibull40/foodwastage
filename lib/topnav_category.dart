import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wabmart/http_request.dart';
import 'package:wabmart/utils/view_utils/colors.dart';


class TopNavCategory extends StatefulWidget {
  List categories;

  TopNavCategory(this.categories);

  @override
  _TopNavCategoryState createState() =>
      new _TopNavCategoryState(this.categories);
}

class _TopNavCategoryState extends State<TopNavCategory>
    with TickerProviderStateMixin {
  List categories;

  _TopNavCategoryState(this.categories);

  ScrollController _catScrollController;

  @override
  void initState() {
    super.initState();
    _catScrollController = ScrollController();
    // _catScrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 76.0,
        width: MediaQuery.of(context).size.width,
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int idx) {
                  return category(context, categories[idx]);
                },
                childCount: categories.length,
              ),
            ),
          ],
        )
        // child: new ListView.builder(
        //   scrollDirection: Axis.horizontal,
        //   controller: _catScrollController,
        //   itemCount: categories.length,
        //   shrinkWrap: true,
        //   itemBuilder: (BuildContext context, int index){
        //     return category(context, categories[index]);
        //   },
        // )
        );
  }

  Widget category(BuildContext ctx, dynamic item) {
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, '/products');


      },
      child: SizedBox(
        width: 76,
        height: 76,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(
                color: primaryColor,
                width: 3.0,
              ),
              bottom: BorderSide(
                color: primaryColor,
                width: 3.0,
              ),
            ),
          ),
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                item['image_url'] != null
                    ? Image.network(
                        'https://admin.wabmart.com.bd' + item['image_url'],
                        height: 35)
                    : Image.asset('./assets/limited-time-offer.png',
                        height: 35),
                SizedBox(height: 10),
                Text(item['name'],
                    style: TextStyle(
                        fontSize: 10,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        height: 0.9),
                    textAlign: TextAlign.center)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
