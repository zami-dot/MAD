import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'forgot.dart';
import 'RegisterScreen.dart';
import 'QuizScreen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _isvisible = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String name = '';
  String _error = '';
  bool _isLoading = false;
  Future<void> _login() async {
    try {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();
      setState(() {
        _isLoading = true;
        _error = ''; // Show loading indicator
      });

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = FirebaseAuth.instance.currentUser!;
      var var1 = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userCredential.user!.emailVerified) {
        if (userCredential.user != null) {
          // Navigate to the home screen on successful login
          setState(() {
            name = var1.data()?['fullName'];
            _isLoading = false; // Hide loading indicator
          });

          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => QuizScreen(
              userName: name,
            ),
          ));
        }
      } else {
        setState(() {
          _error = 'Please verify your email address';
          _isLoading = false; // Hide loading indicator
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.message ?? 'An error occurred';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: deviceHeight * 0.30,
                child: FittedBox(
                  child: CircleAvatar(
                    backgroundImage: const NetworkImage(
                        'https://cdnl.iconscout.com/lottie/premium/preview/online-exam-4099435-3420726.png?f=webp'),
                  ),
                ),
              ),
              Container(
                height: deviceHeight * 0.65,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: LayoutBuilder(builder: (ctx, constraints) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login Now",
                        style: TextStyle(
                            fontSize: 28, // Reduced font size to 28
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // Changed color to black
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.01,
                      ),
                      Text("Enter the Details",
                          style: TextStyle(color: Colors.purple[400])),
                      SizedBox(
                        height: constraints.maxHeight * 0.08,
                      ),
                      Container(
                        height: constraints.maxHeight * 0.12,
                        decoration: BoxDecoration(
                          color: Colors.purple[100]!.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.02,
                      ),
                      Container(
                        height: constraints.maxHeight * 0.12,
                        decoration: BoxDecoration(
                          color: Colors.purple[100]!.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Center(
                            child: TextField(
                              controller: _passwordController,
                              obscureText: _isvisible ? false : true,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isvisible = !_isvisible;
                                    });
                                  },
                                  icon: Icon(
                                    _isvisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                ),
                                border: InputBorder.none,
                                hintText: 'Password',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                " Forgot Password",
                                style: TextStyle(
                                  color: Colors
                                      .purple[300], // Adjusted to light purple
                                ),
                              )),
                        ],
                      ),
                      if (_isLoading) // Show loading indicator
                        CircularProgressIndicator(),
                      Text(
                        _error,
                        style: TextStyle(color: Colors.red),
                      ),
                      Container(
                        width: double.infinity,
                        height: constraints.maxHeight * 0.12,
                        margin: EdgeInsets.only(
                          top: constraints.maxHeight * 0.05,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            _isLoading ? null : _login();
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary:
                                  Colors.purple[600], // Adjusted to deep purple
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.02,
                      ),
                      RichText(
                          text: TextSpan(
                              text: 'Don\'t have an account!',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              children: [
                            TextSpan(
                                text: "Register",
                                style: TextStyle(
                                  color:
                                      Colors.purple[500], // Adjusted to purple
                                  fontSize: 18,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterScreen(),
                                      ),
                                    );
                                  })
                          ]))
                    ],
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
