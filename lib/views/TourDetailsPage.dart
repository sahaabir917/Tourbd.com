import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shopx/controllers/ReviewController.dart';
import 'package:shopx/controllers/TourController.dart';
import 'package:get/get.dart';

class TourDetailsPage extends StatefulWidget {
  final int index;

  TourDetailsPage({@required this.index});

  @override
  _TourDetailsPageState createState() => _TourDetailsPageState(index);
}

class _TourDetailsPageState extends State<TourDetailsPage> {
  int index;
  final TourController tourController = Get.put(TourController());
  final ReviewController reviewController = Get.put(ReviewController());

  _TourDetailsPageState(int index) {}

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) {
      this.index = arguments['index'];
      reviewController.fetchReviews(tourController.tourModel[index].id);
      print(this.index);
    }
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Text(tourController.tourModel[index].name),
                excludeHeaderSemantics : true,
                expandedHeight: 50.0,
                forceElevated: innerBoxIsScrolled,
              ),
            ];
          },
          body: SafeArea(child: Obx(() {
            if (reviewController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView(
                children: [
                  Column(
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(top: 1.0),
                          child: Center(
                            child: Image.network(
                              "https://tourguidebd.herokuapp.com/img/tours/${tourController.tourModel[index].imageCover}",
                              height: 200,
                              width: 380,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Tour Details :",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 25.0),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              top: 10.0, right: 20.0, left: 20.0),
                          child: Text(
                            tourController.tourModel[index].description,
                            style: TextStyle(fontSize: 15.0),
                          )),
                      SizedBox(
                        height: 15.0,
                      ),
                      CarouselSlider(
                        options: CarouselOptions(
                            height: 250.0,
                            enableInfiniteScroll: false,
                            autoPlay: true,
                            initialPage: 1),
                        items: tourController.tourModel[index].images.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Container(
                                    child: Card(
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Column(
                                        children: <Widget>[
                                          Image.network(
                                            'https://tourguidebd.herokuapp.com/img/tours/${i}',
                                            fit: BoxFit.fill,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 230.0,
                                          ),
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      margin: EdgeInsets.all(10),
                                    ),
                                  ));
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            "Summary : ${tourController.tourModel[index].summary}",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Package price : ${tourController.tourModel[index].price}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0),
                            ),
                            Text(
                                "${tourController.tourModel[index].difficulty}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "The Spots : ",
                        style: TextStyle(
                            color: Colors.teal,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                      CarouselSlider(
                        options: CarouselOptions(
                            height: 60.0,
                            enableInfiniteScroll: false,
                            initialPage: 1),
                        items:
                            tourController.tourModel[index].locations.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Container(
                                    child: Card(
                                      color: Colors.cyanAccent,
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                              "${i.description}(${i.day} days)"),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      margin: EdgeInsets.all(10),
                                    ),
                                  ));
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Tour Guides : ",
                        style: TextStyle(
                            color: Colors.teal,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      CarouselSlider(
                        options: CarouselOptions(
                            height: 220.0,
                            enableInfiniteScroll: false,
                            initialPage: 1),
                        items: tourController.tourModel[index].guides.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Container(
                                    child: Card(
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Column(
                                        children: <Widget>[
                                          Image.network(
                                            'https://tourguidebd.herokuapp.com/img/users/${i.photo}',
                                            fit: BoxFit.fill,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 135.0,
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Text("${i.name}"),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text("${i.email}"),
                                          SizedBox(
                                            height: 2.0,
                                          ),
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      margin: EdgeInsets.all(10),
                                    ),
                                  ));
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: LinearPercentIndicator(
                          lineHeight: 15.0,
                          progressColor: Colors.blueAccent,
                          leading: Text(
                            "Average Rating : ${tourController.tourModel[index].ratingsAverage}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
                          ),
                          percent:
                              tourController.tourModel[index].ratingsAverage /
                                  10,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Rated by             : ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                            Text(
                              "${tourController.tourModel[index].ratingsQuantity} Peoples",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      RaisedButton(
                        onPressed: () {},
                        color: Colors.deepOrangeAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Text("Checkout"),
                        textColor: Colors.white,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: reviewController.reviewModel.length,
                        itemBuilder: (context, index) {
                          return Text(
                              reviewController.reviewModel[index].review);
                        },
                      ),
                    ],
                  ),
                ],
              );
            }
          })),
        ));
  }
}
