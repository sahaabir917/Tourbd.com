import 'dart:math';

import 'package:get/state_manager.dart';
import 'package:shopx/SharedPreference/PreferenceHelper.dart';
import 'package:shopx/models/FailedModel.dart';
import 'package:shopx/models/LoginModel.dart';
import 'package:shopx/models/TourModel.dart';
import 'package:shopx/models/product.dart';
import 'package:shopx/services/remote_services.dart';
import '../services/remote_services.dart';

class LoginController extends GetxController{
  var isLoading = false.obs;
  LoginModel loginModels = LoginModel();
  var emails = "".obs;
  var name = "".obs;
  var photo = "".obs;
  var role = "".obs;
  var msg = "".obs;

  FailedModel failedModels = FailedModel();


  @override
  void onInit() {
    // fetchLoginData();
    emails.value = null;
    isLoading(false);
    super.onInit();
  }

  void fetchLoginData(String email,String password) async{
    try{
      isLoading(true);
      var loginModel = await RemoteServices.fetchLoginData(email,password);
      if(loginModel is LoginModel){
        if(loginModel.status!=null){
          loginModels = loginModel;
          emails.value = loginModels.data.user.email;
          photo.value = loginModels.data.user.photo;
          name.value = loginModels.data.user.name;
          role.value = loginModels.data.user.role;
          msg.value = "";
        }
      }
      else if(loginModel is FailedModel){
        failedModels = loginModel;
        if(failedModels.status!=null){
          emails.value = null;
          photo.value = "";
          name.value = "";
          role.value = "";
          msg.value = failedModels.message;
        }
      }



      // if(loginModel.status == null){
      //   emails.value = null;
      //   photo.value = "";
      //   name.value = "";
      //   role.value = "";
      // }
      //  else if(loginModel == null){
      //    emails.value = null;
      //    photo.value = "";
      //    name.value = "";
      //    role.value = "";
      //  }
      //
    }
    finally{
      isLoading(false);
    }
  }

}