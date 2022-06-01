
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_login_ui/common/theme_helper.dart';
import 'package:pacman/common/theme_helper.dart';
import 'package:pacman/services/auth_services.dart';
import 'package:provider/provider.dart';

import '../adminscreen.dart';
import '../homepage.dart';
import 'forgot_password_page.dart';
import 'profile_page.dart';
import 'registration_page.dart';
import 'widgets/header_widget.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}): super(key:key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  String role = 'user';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true,
                  Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  // This will be the login form
                  child: Column(
                    children: [
                      Text(
                        'Welcome',
                        style: TextStyle(
                            fontSize: 60, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Sign in into your account',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 30.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                child: TextField(
                                  controller: emailController,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'User Name', 'Enter your user name'),
                                ),
                                decoration: ThemeHelper()
                                    .inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 30.0),
                              Container(
                                child: TextField(
                                  controller: passwordController,

                                  obscureText: true,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Password', 'Enter your password'),
                                ),
                                decoration: ThemeHelper()
                                    .inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 15.0),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPasswordPage()),);
                                  },
                                  child: Text("Forgot your password?",
                                    style: TextStyle(color: Colors.grey,),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: ThemeHelper().buttonBoxDecoration(
                                    context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: Text('Sign In'.toUpperCase(),
                                      style: TextStyle(fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),),
                                  ),
                                  onPressed: () {
                                    final String email = emailController.text
                                        .trim();
                                    final String password = passwordController
                                        .text.trim();

                                    if (email.isEmpty) {
                                      print("Email is Empty");
                                    } else {
                                      if (password.isEmpty) {
                                        print("Password is Empty");
                                      } else {
                                        context.read<AuthService>().login(
                                          email,
                                          password,
                                        );
                                      }
                                    }
                                    //_checkRole();
                                    //After successful login we will redirect to profile page. Let's create profile page now
                                    if (email == 'test@gmail.com') {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) =>
                                              AdminScreen()));
                                    } else  {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) =>
                                              ProfilePage()));
                                    }


                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                //child: Text('Don\'t have an account? Create'),
                                child: Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(
                                              text: "Don\'t have an account? "),
                                          TextSpan(
                                            text: 'Create',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RegistrationPage()));
                                              },
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Theme
                                                    .of(context)
                                                    .accentColor),
                                          ),
                                        ]
                                    )
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }



}