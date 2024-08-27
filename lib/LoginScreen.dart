import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workspace/dashboard.dart'; // Dashboard screen
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:workspace/userSignUp.dart'; // Signup screen

class Loginscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      var reqBody = {
        "email": email,
        "password": password,
      };

      try {
        var response = await http.post(
          Uri.parse("http://localhost:3000/users/login"),
          body: jsonEncode(reqBody),
          headers: {"Content-Type": "application/json"},
        );

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);

          if (jsonResponse['message'] == 'Login successful') {
            String token = jsonResponse['token'];
            var userData = jsonResponse['user'];

            // Store token and user data in shared preferences
            prefs.setString('token', token);
            prefs.setString('name', userData['name']);
            prefs.setString('email', userData['email']);
            prefs.setString('phone', userData['phone']);

            // Navigate to Dashboard
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Dashboard(
                  token: token,
                  name: userData['name'],
                  email: userData['email'],
                  phone: userData['phone'],
                ),
              ),
            );
          } else {
            _showErrorDialog("Login failed: ${jsonResponse['message']}");
          }
        } else {
          _showErrorDialog("Server error: ${response.statusCode}");
        }
      } catch (e) {
        _showErrorDialog("An error occurred: $e");
      }
    } else {
      _showErrorDialog("Please fill in all fields");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Login Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login"),
      ),
      drawer: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final SharedPreferences prefs = snapshot.data as SharedPreferences;
            final token = prefs.getString('token');
            final name = prefs.getString('name');
            final email = prefs.getString('email');
            final phone = prefs.getString('phone');

            return Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Container(
                      height: 100.0,
                      width: double.infinity,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          'https://images.bewakoof.com/t320/women-s-white-blue-vibes-graphic-printed-t-shirt-621362-1721651327-1.jpg',
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Text("signup Page"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => userSignUp(),
                        ),
                      );
                    },
                  ),
                  if (token != null && name != null && email != null && phone != null)
                    ListTile(
                      leading:Text("DashBoard Page"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Dashboard(
                              token: token,
                              name: name,
                              email: email,
                              phone: phone,
                            ),
                          ),
                        );
                      },
                    ),
                  ListTile(
                    leading: Text("Signup Page"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => userSignUp(),

                        ),


                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.account_circle_outlined),
                    title: Text('S60'),
                  ),
                ],
              ),
            );
          } else {
            return Drawer(child: Center(child: CircularProgressIndicator()));
          }
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 110.0),
              child: Center(
                child: Container(
                  width: 200,
                  height: 100,
                  child: Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4AgM3fmStK1-lxV48twfFrZH7kHbY1LWWlA&s",
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter valid email id as abc@gmail.com',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter secure password',
                ),
              ),
            ),
            SizedBox(
              height: 65,
              width: 360,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                    child: Text(
                      'Log in',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    onPressed: loginUser,
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account? '),
                    InkWell(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => userSignUp(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
