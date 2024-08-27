import 'package:flutter/material.dart';
import 'package:workspace/LoginScreen.dart';
import 'package:workspace/userSignUp.dart';

class Dashboard extends StatelessWidget {
  final String token;
  final String name;
  final String email;
  final String phone;

  Dashboard({required this.token, required this.name, required this.email, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      drawer: Drawer(
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
              leading:Text("Login Page"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Loginscreen(),

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
              leading: Icon(Icons.add_card),
              title: Text('CSE'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle_outlined),
              title: Text('S60'),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 8, // Adds shadow to the card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Rounded corners
            ),
            color: Colors.white, // Card background color
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Wraps the card tightly around its content
                children: [
                  Text(
                    'Welcome, $name',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800], // Text color
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.email, color: Colors.blueGrey), // Email icon
                      SizedBox(width: 10),
                      Text(
                        email,
                        style: TextStyle(fontSize: 18, color: Colors.blueGrey[700]),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.blueGrey), // Phone icon
                      SizedBox(width: 10),
                      Text(
                        phone,
                        style: TextStyle(fontSize: 18, color: Colors.blueGrey[700]),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Define action on button press
                      },
                      style: ElevatedButton.styleFrom(
                        // primary: Colors.blue, // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // Rounded button corners
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text('Take Action', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
