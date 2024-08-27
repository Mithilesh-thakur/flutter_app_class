import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workspace/LoginScreen.dart';
import 'package:workspace/interoslider/Intro3.dart';
import 'package:workspace/model/UserSharedPreferences.dart';

class Intro2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Usersharedpreferences.init();
    return Scaffold(

      body: Column(
        children: [
          Container(
            child: Icon(Icons.accessibility, size: 300),
          ),
          Text("We provide quality flowers starting from 99/-"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distributes space evenly between buttons
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Intro3()),
                  );
                },
                child: Text("Next"),
              ),
              ElevatedButton(
                onPressed: () {
                  bool? status= Usersharedpreferences.getFirstTime() ?? false;
                  if(status==false)
                  {
                    Usersharedpreferences.setFirstTime(true);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Loginscreen()));

                  }
                },
                child: Text("Skip"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
