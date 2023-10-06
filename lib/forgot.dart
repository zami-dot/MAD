import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _fstate createState() => _fstate();
}

class _fstate extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;
  String _error = '';

  void _resetPassword(BuildContext context) async {
    final String email = _emailController.text.trim();
    if (email.isNotEmpty) {
      try {
        setState(() {
          _isLoading = true;
          _error = ''; // Show loading indicator
        });
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Check your email for a password reset link',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white),
            ),
          ),
        );
        // ignore: use_build_context_synchronously
        setState(() {
          _isLoading = false;
          _error = ''; // Show loading indicator
        });
        Navigator.of(context).pop(); // Close the "Forgot Password" screen
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
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: 120,
              child: Image.network(
                'https://t3.ftcdn.net/jpg/04/65/91/56/360_F_465915651_QA8Uc5dOKXpM1aWLTxPO8QaNcIcIXAN4.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 18),
            Text(
              "Reset Password",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Enter your registered email and we'll send you a link to reset your password.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 18),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email, color: Colors.purple[400]),
              ),
            ),
            SizedBox(height: 18),
            ElevatedButton(
              onPressed: () {
                _resetPassword(context);
              },
              child: Text('Send Reset Link'),
              style: ElevatedButton.styleFrom(
                primary: Colors.purple[600],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                foregroundColor: Colors.white,
              ),
            ),
            if (_isLoading) // Show loading indicator
              const CircularProgressIndicator(),
            if (_error.isNotEmpty) // Show error message
              Text(_error,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ))
          ],
        ),
      ),
    );
  }
}
