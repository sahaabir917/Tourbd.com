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
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))
              ),
              child: ListView(
                  controller: controller,
                  children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                      ),
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
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              reviewController.reviewModel[index].review,
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      );
                    },
                  ),

              ]),
            ),
          );
        }
      },
    ));
  }
}
