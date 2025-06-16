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
  static clearPhoneNumber(){
    sharedPreferences.remove("phone number");
  }

 static setCity(String city){
    sharedPreferences.setString("City", city);
  }
  static getCity(){
    return sharedPreferences.getString("City");
  }

  static setGovernorate(String governorate) {
    sharedPreferences.setString("governorate", governorate);
  }

  static getGovernorate() {
    return sharedPreferences.getString("governorate");
  }

  static setUserId(String userId){
    sharedPreferences.setString("user id", userId);
  }
  static getUserId(){
    return sharedPreferences.getString("user id");
  }

  static clearAll() {
    sharedPreferences.remove("token");
    sharedPreferences.remove("phone number");
    sharedPreferences.remove("City");
    sharedPreferences.remove("governorate");
    sharedPreferences.remove("user id");
  }

}