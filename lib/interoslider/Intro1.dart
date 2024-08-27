
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workspace/LoginScreen.dart';
import 'package:workspace/interoslider/Intro2.dart';
import 'package:workspace/model/UserSharedPreferences.dart';


class Intro1 extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    Usersharedpreferences.init();
    return Scaffold(

      body: Column(


        children: [


          Container(
            child: Icon(Icons.accessibility, size: 200),




          ),
          Text("A Flower Shop with Verieties of Flowers"),



          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Intro2()));

              }, child: Text("Next")),
              ElevatedButton(onPressed: (){
               bool? status= Usersharedpreferences.getFirstTime() ?? false;
               if(status==false)
                 {
                   Usersharedpreferences.setFirstTime(true);
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Loginscreen()));

                 }

              }, child: Text("Skip" ),


              )

            ],
          )
        ],
      ),
    );
  }
}