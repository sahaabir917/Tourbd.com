import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static SharedPreferences pref;

  void clearData() async {
    pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  void setUserData(String userData) async {
    pref = await SharedPreferences.getInstance();
    pref.setString("userData", userData);
  }

  void setIsLoggedIn(bool isLogin) async {
    pref = await SharedPreferences.getInstance();
    pref.setBool("isLogin", isLogin);
    pref.commit();
  }

  void setJwtToken(String token) async{
    pref = await SharedPreferences.getInstance();
    pref.setString("jwtToken", token);
    pref.commit();
  }

}