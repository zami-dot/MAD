import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project/QuizScreen.dart';
import 'package:project/RegisterScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, // Set this to false

      theme: ThemeData(
        primarySwatch: Colors.purple, // Changed to purple
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _isvisible = false;

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
                    backgroundImage: NetworkImage(
                        'https://cdnl.iconscout.com/lottie/premium/preview/online-exam-4099435-3420726.png?f=webp'),
                    radius: 12,
                  ),
                ),
                color: Colors.purple[700], // Adjusted to deeper purple
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
                        "QUIZ GAME",
                        style: TextStyle(
                            fontSize: 28, // Reduced font size to 28
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // Changed color to black
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.01,
                      ),
                      Text("", style: TextStyle(color: Colors.purple[400])),
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
                              onPressed: () {},
                              child: Text(
                                " Forgot Password",
                                style: TextStyle(
                                  color: Colors
                                      .purple[300], // Adjusted to light purple
                                ),
                              ))
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        height: constraints.maxHeight * 0.12,
                        margin: EdgeInsets.only(
                          top: constraints.maxHeight * 0.05,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // Optional: Add validation logic for email and password here.
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuizScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
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
                                    Navigator.push(
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
