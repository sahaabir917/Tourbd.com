import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopx/models/FailedModel.dart';
import 'package:shopx/models/SearchReviewModel.dart';
import 'package:shopx/services/remote_services.dart';
import '../services/remote_services.dart';

class ReviewController extends GetxController{
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

  void fetchReviews(String id) async {
    try{
      isLoading(true);
      getJwtToken().then((value) async {
        print(value);
        print(id);
        var reviews = await RemoteServices.fetchReviews(value,id);
        if(reviews is SearchReviewModel){
          if(reviewModel!=null){
            reviewModel.value = reviews.data.data;
          }
          else{
            msg.value = "No data found";
          }
        }
        else if(reviews is FailedModel){
          failedModels = reviews;
          reviewModel.value = null;
          msg.value = failedModels.message;
        }
      });

    }
    finally{
      isLoading(false);
    }
  }

  Future<String> getJwtToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jwttoken = sharedPreferences.getString("jwtToken");
    return jwttoken;
  }


}