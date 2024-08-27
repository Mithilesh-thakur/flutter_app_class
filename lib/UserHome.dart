
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workspace/LoginScreen.dart';
import 'package:workspace/model/UserSharedPreferences.dart';


class UserHome extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    Usersharedpreferences.init();
    String userName=Usersharedpreferences.getUserName() ?? "N/A";

   return Scaffold(
     appBar: AppBar(
       title: Text("Welcome"),
       backgroundColor: Colors.blue,
     ),
     body: Container(
       child:ListView(
         children: [

           Text(" Hello "+userName),
           ElevatedButton( child: Text("Logout"),onPressed: (){

             Usersharedpreferences.mypre!.clear();

             Navigator.pop(context);
             Navigator.push(context, MaterialPageRoute(builder: (context)=>Loginscreen()));
           },)
         ],
       )

     ),

   );
  }
}