import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopx/controllers/TourController.dart';
import 'package:shopx/controllers/TourController.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:shopx/views/TourDetailsPage.dart';
import 'TourTile.dart';
import 'product_tile.dart';

class TourPage extends StatelessWidget {
  final TourController tourController = Get.put(TourController());
  List<int> id = new List<int>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Tour"),
        actions: [],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (tourController.isLoading.value)
                return Center(child: CircularProgressIndicator());
              else
                return ListView.builder(
                  itemCount: tourController.tourModel.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(20.0),
                      child: ListTile(
                        title: Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 180,
                                      width: double.infinity,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Image.network(
                                        "https://tourguidebd.herokuapp.com/img/tours/${tourController.tourModel[index].imageCover}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text(
                                  tourController.tourModel[index].name,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontFamily: 'avenir',
                                      fontWeight: FontWeight.w800),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8),
                                if (tourController.tourModel[index].duration !=
                                    null)
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 2),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          tourController
                                              .tourModel[index].duration
                                              .toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                SizedBox(height: 8),
                                Text(
                                    '\$${tourController.tourModel[index].price}',
                                    style: TextStyle(
                                        fontSize: 32, fontFamily: 'avenir')),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          checkLoginStatus(context,index);
                        },
                      ),
                    );
                  },
                );
            }),
          )
        ],
      ),
    );
  }

   checkLoginStatus(BuildContext context, int index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool("isLogin") != null) {
      if (preferences.getBool("isLogin")) {
       // Navigator.pushNamed(context, '/tour_details',arguments: <String,int>{
       //   "index" : index,
       // });
        Navigator.pushNamed(context, '/tour_details',arguments: {'index': index});
      } else {
        Navigator.pushNamed(context, '/login_page');
      }
    }
    else{
      Navigator.pushNamed(context, '/login_page');
    }
  }
}
