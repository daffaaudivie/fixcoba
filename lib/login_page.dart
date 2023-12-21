import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fixcoba/home_page.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
  try {
    final response = await http.post(
      Uri.parse('http://192.168.18.6:8000/api/login'),
      body: {
        'username': usernameController.text,
        'password': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      print('Login successful!');
      print('Token: ${response.body}');
      // Proses lain setelah login berhasil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      print('Login failed. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Error during HTTP request: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 32, 234, 99),
                      Color.fromARGB(255, 50, 238, 110),
                      Color.fromARGB(255, 26, 221, 65),
                      Color.fromARGB(255, 184, 212, 183),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Welcome Back',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Username',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 25, 141, 62),
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(31, 191, 59, 59),
                                  blurRadius: 6.0,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            height: 60.0,
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                hintText: 'Enter your Username',
                                hintStyle: TextStyle(
                                  color: Colors.white54,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                              controller: usernameController,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Password',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 25, 141, 62),
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(31, 191, 59, 59),
                                  blurRadius: 6.0,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            height: 60.0,
                            child: TextField(
                              obscureText: true,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                hintText: 'Enter your Password',
                                hintStyle: TextStyle(
                                  color: Colors.white54,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                              controller: passwordController,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => print('Forgot Password Button Pressed'),
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 25.0),
                        width: double.infinity,
                        child: TextButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            elevation: 5.0,
                            padding: EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            primary: Colors.white,
                          ),
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              color: Color(0xFF527DAA),
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            '- OR -',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () => print('Admin Login'),
                              child: Text(
                                'Anda Admin?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Page'),
      ),
      body: Center(
        child: Text('Welcome to Order Page!'),
      ),
    );
  }
}
