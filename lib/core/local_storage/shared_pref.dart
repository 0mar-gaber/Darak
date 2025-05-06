import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper{
  static late SharedPreferences sharedPreferences;
  static Future<void> init()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static setToken(String token){
    sharedPreferences.setString("token", token);
  }
  static String getToken(){
    return sharedPreferences.getString("token")??"omar";
  }
  static clearToken(){
    sharedPreferences.remove("token");
  }

  static setPhoneNumber(String phoneNumber){
    sharedPreferences.setString("phone number", phoneNumber);
  }
  static getPhoneNumber(){
    return sharedPreferences.getString("phone number");
  }


  static setUserId(String userId){
    sharedPreferences.setString("user id", userId);
  }
  static getUserId(){
    return sharedPreferences.getString("user id");
  }
}