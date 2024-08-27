import 'package:shared_preferences/shared_preferences.dart';

class Usersharedpreferences
{
  static SharedPreferences? mypre;

  static void init() async
  {
   mypre= await SharedPreferences.getInstance();
  }

  static void setFirstTime(bool status) async
  {
   await  mypre!.setBool("firsttime", status);
  }
  static bool? getFirstTime()
  {
   return  mypre!.getBool("firsttime");
  }

  static void setLogin(bool status) async
  {
    await mypre!.setBool("login", status);

  }
  static bool? getLogin()
  {
    return mypre!.getBool("login");
  }

  static void setUserName(String userName)async
  {
    await mypre!.setString("userName", userName);
  }
  static String? getUserName()
  {
    return mypre!.getString("userName");
  }





}