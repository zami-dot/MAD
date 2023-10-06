import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Login.dart';
import 'package:flutter/gestures.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  String _error = '';
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  void _signup() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          _isLoading = true;
          _error = ''; // Clear any previous errors
        });
        await _auth.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);

        User? user = _auth.currentUser;
        await user?.sendEmailVerification();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .set({
          'fullName': _fullNameController.text,
          'username': _usernameController.text,
          'email': _emailController.text,
        });

        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Login(),
        ));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'A verification email has been sent to ${_emailController.text}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            duration: const Duration(seconds: 10),
          ),
        );
        setState(() {
          _isLoading = false;
          _error = ''; // Clear any previous errors
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          _isLoading = false;
          _error = e.message ?? 'An error occurred';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.purple[700],
      ),
      body: DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(color: Colors.purple[100]),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Expanded(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    _customTextField(
                        hint: "Full Name",
                        icon: Icons.person,
                        controller: _fullNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        }),
                    SizedBox(height: 15),
                    _customTextField(
                        hint: "Username",
                        icon: Icons.person_outline,
                        controller: _usernameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        }),
                    SizedBox(height: 15),
                    _customTextField(
                        hint: "Email",
                        icon: Icons.email,
                        controller: _emailController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains('@')) {
                            return 'Please enter a valid Email';
                          }
                          return null;
                        }),
                    SizedBox(height: 15),
                    _customTextField(
                        hint: "Password",
                        icon: Icons.lock,
                        obscureText: true,
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 6) {
                            return 'Password should be at least 6 characters long';
                          }
                          return null;
                        }),
                    SizedBox(height: 15),
                    _customTextField(
                        hint: "Confirm Password",
                        icon: Icons.lock_outline,
                        obscureText: true,
                        controller: _confirmPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        }),
                    SizedBox(height: 25), const SizedBox(height: 20),
                    if (_isLoading) const CircularProgressIndicator(),
                    if (_error.isNotEmpty)
                      Text(
                        _error,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                        ),
                      ),
                    // Register Button
                    ElevatedButton(
                      onPressed: () {
                        _isLoading ? null : _signup();
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple[600],
                        shadowColor: Colors.purple[200],
                        elevation: 5,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    RichText(
                        text: TextSpan(
                            text: 'already have an account!',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            children: [
                          TextSpan(
                              text: "Login",
                              style: TextStyle(
                                color: Colors.purple[500], // Adjusted to purple
                                fontSize: 18,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Login(),
                                    ),
                                  );
                                })
                        ])),
                    SizedBox(
                      height: 140,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _customTextField({
    required String hint,
    required IconData icon,
    TextEditingController? controller,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.purple[400]),
        filled: true,
        fillColor: Colors.purple[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.purple[400]!),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
