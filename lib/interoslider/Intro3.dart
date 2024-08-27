
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workspace/LoginScreen.dart';
import 'package:workspace/model/UserSharedPreferences.dart';


class Intro3 extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    Usersharedpreferences.init();
    return Scaffold(

      body: Column(

        children: [

          Container(


            child:

            Icon(Icons.accessibility,size: 300,),

          ),
          Text("Flower Delivery is Free in Tri-city"),


          Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){

                bool? status= Usersharedpreferences.getFirstTime() ?? false;
                if(status==false)
                {
                  Usersharedpreferences.setFirstTime(true);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Loginscreen()));

                }
              }, child: Text("Finish")),
            ]
          )
        ],
      ),
    );
  }
}