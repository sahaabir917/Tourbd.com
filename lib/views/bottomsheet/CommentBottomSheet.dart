import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopx/controllers/ReviewController.dart';
import 'package:get/get.dart';
import 'package:shopx/controllers/TourController.dart';

class CommentBottomSheet extends StatefulWidget {
  final int index;

  CommentBottomSheet(@required this.index);

  @override
  _CommentBottomSheetState createState() => _CommentBottomSheetState(index);
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  int index;

  final TourController tourController = Get.put(TourController());
  final ReviewController reviewController = Get.put(ReviewController());

  _CommentBottomSheetState(int index) {
    this.index = index;
    reviewController.fetchReviews(tourController.tourModel[index].id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Obx(
      () {
        TextEditingController commentController = new TextEditingController();
        if (reviewController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.3,
            maxChildSize: 0.6,
            builder: (_, controller) => Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              child: ListView(controller: controller, children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            "Comments",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          )),
                      decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      height: 40,
                    ),
                  ],
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: reviewController.reviewModel.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 10,),
                          CircleAvatar(child: Image(image: AssetImage('assets/placeholder.png'),height: 50,width: 50,),backgroundColor: Colors.blueAccent,),
                          SizedBox(width: 10,),
                          Column(
                            children: [
                              // Container(
                              //   child:Text(reviewController.reviewModel[0].user.name) ,
                              // width: MediaQuery.of(context).size.width/1.5,
                              // ),
                              Container(
                                child: Text(
                                  reviewController.reviewModel[index].review,
                                  softWrap: true,
                                ),
                                width: MediaQuery.of(context).size.width / 1.3,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/1.46,
                        child: TextFormField(
                          controller: commentController,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              hintText: "Enter Comment",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              hintStyle: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        width: 80,
                        height: 30,
                        child: RaisedButton(onPressed: (){
                          var comment = commentController.text;
                          reviewController.createReview(comment,tourController.tourModel[index].id,5);
                        },
                          color: Colors.deepOrangeAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Text("Comment",style: TextStyle(fontSize: 10.0),),
                          textColor: Colors.white,
                        ),
                      )
                    ],
                  ),
                )
              ]
              ),
            ),
          );
        }
      },
    ));
  }
}
