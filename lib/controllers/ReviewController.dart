import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopx/models/CreateReviewModel.dart';
import 'package:shopx/models/FailedModel.dart';
import 'package:shopx/models/SearchReviewModel.dart';
import 'package:shopx/services/remote_services.dart';
import '../services/remote_services.dart';

class ReviewController extends GetxController {
  var isLoading = false.obs;
  var reviewModel = List<Datum>().obs;
  FailedModel failedModels = FailedModel();
  var msg = "".obs;

  String jwttoken;

  @override
  void onInit() {
    // getJwtToken();
    isLoading(false);
  }

  void createReview(String comment, String tour_id, int rating) {
    var userId = "";
    var token = "";
    try {
      isLoading(true);
      getUserID().then((value) async {
        userId = value;
      });

      getJwtToken().then((value) async {
        token = value;
        var createReview = await RemoteServices.createReview(
            token, tour_id, rating, userId, comment);
        if (createReview is CreateReviewModel) {
          fetchReviews(tour_id);
        } else if (createReview is FailedModel) {
          failedModels = createReview;
          reviewModel.value = [];
          msg.value = failedModels.message;
        }
      });
    } finally {
      isLoading(false);
    }
  }

  void fetchReviews(String id) async {
    try {
      isLoading(true);
      // reviewModel.value = [];
      getJwtToken().then((value) async {
        print(value);
        print(id);
        var reviews = await RemoteServices.fetchReviews(value, id);
        if (reviews is SearchReviewModel) {
          if (reviewModel != null) {
            reviewModel.value = reviews.data.data;
            print("reviews ${reviewModel.value}");
          } else {
            msg.value = "No data found";
          }
        } else if (reviews is FailedModel) {
          failedModels = reviews;
          reviewModel.value = null;
          msg.value = failedModels.message;
        }
      });
    } finally {
      isLoading(false);
    }
  }

  Future<String> getJwtToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jwttoken = sharedPreferences.getString("jwtToken");
    return jwttoken;
  }

  Future<String> getUserID() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString("user_id");
    return userId;
  }
}
