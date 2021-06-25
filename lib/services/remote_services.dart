import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopx/SharedPreference/PreferenceHelper.dart';
import 'package:shopx/models/FailedModel.dart';
import 'package:shopx/models/LoginModel.dart';
import 'package:shopx/models/SearchReviewModel.dart';

import 'package:shopx/models/TourModel.dart';
import 'package:shopx/models/product.dart';

class RemoteServices {
  static var client = http.Client();
  static PreferenceHelper preferenceHelper = new PreferenceHelper();
  String jwttoken;

  RemoteServices() {
    getJwtToken().then((value) {
      jwttoken = value;
      print(jwttoken);
    });
  }

  static Future<List<Product>> fetchProducts() async {
    var response = await client.get(Uri.parse(
        'https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }

  static Future<TourModel> fetchTours() async {
    var response = await client
        .get(Uri.parse('https://tourguidebd.herokuapp.com/api/v1/tours'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return tourModelFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<dynamic> fetchLoginData(String email, String password) async {
    var body = {"email": "${email}", "password": "${password}"};
    var response = await client.post(
        Uri.parse('https://tourguidebd.herokuapp.com/api/v1/users/login'),
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      var jsonString = response.body;
      preferenceHelper.setUserData(response.body);
      LoginModel loginInfo = loginModelFromJson(response.body);
      preferenceHelper.setJwtToken(loginInfo.token);
      preferenceHelper.setIsLoggedIn(true);
      return loginModelFromJson(jsonString);
    } else {
      var jsonString = response.body;
      preferenceHelper.setJwtToken(null);
      preferenceHelper.setIsLoggedIn(false);
      return failedModelFromJson(jsonString);
    }
  }

  static Future<dynamic> getAllReview() {}

  static Future<dynamic> fetchReviews(String jwttoken, String id) async {
    var response = await client.get(
        Uri.parse('https://tourguidebd.herokuapp.com/api/v1/tours/${id}/reviews'),
        headers: {
          'Authorization': "Bearer ${jwttoken}",
        });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      SearchReviewModel searchReviewModel = searchReviewModelFromJson(jsonString);
      print(jsonString);
      return searchReviewModel;
    } else {
      print(response.statusCode);
      var jsonString = response.body;
      FailedModel failedModel = failedModelFromJson(jsonString);
      return failedModel;
    }
  }

  Future<String> getJwtToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jwttoken = sharedPreferences.getString("jwtToken");
    return jwttoken;
  }
}
