import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  final TextEditingController _mailcontroller = TextEditingController();

  final TextEditingController _passwordcontroller = TextEditingController();

  bool _passVisible = false;
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Short Password .Enter a valid password !';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailPattern = r'^[^@]+@[^@]+\.[^@]+';
    final regex = RegExp(emailPattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email !';
    }
    return null;
  }

  Future<void> SignIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _mailcontroller.text.trim(),
              password: _passwordcontroller.text.trim());
      if (userCredential.user != null) {
        print("Signed in:${userCredential.user?.email}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Sign-in successfull")),
        );
        Navigator.pushReplacementNamed(context, '/home');
      }
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = "No user found for that email";
          break;
        case 'wrong-password':
          message = "Wrong password provided";
          break;
        case 'invalid-email':
          message = "the email address is invalid";
          break;
        case 'user-disabled':
          message = "this user account has been disabled";
          break;
        case 'too-many-requests':
          message = "Too many attempts.Please try again later";
          break;
        default:
          message = "An error occured ...";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
      print("FirebaseAuthException:$message");
    } on SocketException catch (e) {
      String message = "Network error:Please check your connection";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
      print("SocketException:$e");
    } catch (e) {
      String message = "autre";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
      print("UnknownException:$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 196, 152, 207),
        title: Text(
          'Login Page',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  "images/logo2.png",
                  width: 100,
                  height: 100,
                ),
                Text(
                  "Welcome Back !",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _mailcontroller,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                SizedBox(height: 30),
                TextFormField(
                  obscureText: !_passVisible,
                  controller: _passwordcontroller,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passVisible = !_passVisible;
                            });
                          },
                          icon: Icon(_passVisible
                              ? Icons.visibility
                              : Icons.visibility_off))),
                  validator: _validatePassword,
                ),
                SizedBox(height: 30),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 196, 152, 207)),
                    onPressed: () {
                      SignIn();
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text(
                      'Don\t have an account yet ? Register here',
                      style: TextStyle(color: Color.fromARGB(255, 95, 45, 64)),
                    )),
              ],
            ),
          )),
    );
  }
}
