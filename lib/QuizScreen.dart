import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Quiz/Login.dart';
import 'package:Quiz/QuestionScreen.dart';

class QuizScreen extends StatefulWidget {
  final String userName;

  QuizScreen({required this.userName});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    _data();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  var data;
  var data2;
  FirebaseAuth _auth = FirebaseAuth.instance;
  void _data() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference quizDocument = firestore.doc('/quizes/my');
    DocumentSnapshot snapshot = await quizDocument.get();
    setState(() {
      if (snapshot.exists) {
        data =
            (snapshot.data() as Map<String, dynamic>)['quizes'][0]['quizzes'];
        data2 =
            (snapshot.data() as Map<String, dynamic>)['quizes'][1]['quizzes'];
      } else {
        data = 'No Data';
      }
    });
  }

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      // User is signed out.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      ); // Close the logout screen or navigate to another screen.
    } catch (e) {
      print("Error during logout: $e");
      // Handle error, if any.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              'Welcome, ',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              widget.userName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.purple,
        actions: [
          PopupMenuButton(
            color: Colors.white,
            onSelected: (value) {},
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child:
                      Text('Log Out', style: TextStyle(color: Colors.purple)),
                  value: 'Logout',
                  onTap: () {
                    _signOut();
                  },
                )
              ];
            },
          ),
        ],
        bottom: TabBar(
          labelColor: Colors.white,
          controller: _tabController,
          tabs: const [
            Tab(text: 'Level 1'),
            Tab(text: 'Level 2'),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Background Image with Gradient Overlay
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.purple.withOpacity(0.6),
                    Colors.purple.withOpacity(0.3),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.3), BlendMode.lighten),
                child: Image.network(
                  'https://media.istockphoto.com/id/937025360/photo/abstract-soft-purple-background.webp?b=1&s=170667a&w=0&k=20&c=6tuPIWg9E-0q7th-TDn72BrK5DoFCaP2pE3A-drhS1A=',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Content: TabBarView
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TabBarView(
              controller: _tabController,
              children: [
                _quizListView1(),
                _quizListView2(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  var a;
  Widget _quizListView1() {
    if (data == null) {
      return Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (ctx, index) {
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: CircleAvatar(
              backgroundColor: Colors.purple,
              child: Icon(Icons.quiz, color: Colors.white),
            ),
            title: Text('${data[index]['name']}',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Test your knowledge!"),
            trailing: Chip(
              backgroundColor: Colors.amber,
              label: Text(
                "5 minutes",
                style: TextStyle(color: Colors.purple),
              ),
            ),
            onTap: () {
              if (data[index]['name'] == 'English') {
                setState(() {
                  a = 0;
                });
              } else if (data[index]['name'] == 'Maths') {
                setState(() {
                  a = 2;
                });
              } else if (data[index]['name'] == 'Science') {
                setState(() {
                  a = 1;
                });
              }
              setState(() {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => QuestionScreen(
                          player: widget.userName,
                          num: 0,
                          name: a,
                        )));
              });
            },
          ),
        );
      },
    );
  }

  Widget _quizListView2() {
    if (data2 == null) {
      return Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      itemCount: data2.length,
      itemBuilder: (ctx, index) {
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: CircleAvatar(
              backgroundColor: Colors.purple,
              child: Icon(Icons.quiz, color: Colors.white),
            ),
            title: Text('${data2[index]['name']}',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Test your knowledge!"),
            trailing: Chip(
              backgroundColor: Colors.amber,
              label: Text(
                "5 minutes",
                style: TextStyle(color: Colors.purple),
              ),
            ),
            onTap: () {
              if (data2[index]['name'] == 'Flutter') {
                setState(() {
                  a = 0;
                });
              } else if (data2[index]['name'] == 'Programming') {
                setState(() {
                  a = 1;
                });
              } else if (data2[index]['name'] == 'Technology') {
                setState(() {
                  a = 2;
                });
              }
              setState(() {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => QuestionScreen(
                          player: widget.userName,
                          num: 1,
                          name: a,
                        )));
              });
            },
          ),
        );
      },
    );
  }
}
