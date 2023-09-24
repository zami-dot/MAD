import 'package:flutter/material.dart';
import 'package:project/QuestionScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
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
  String userName = "20SW122"; // Changed username to 20SW122

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => QuizScreen(userName: userName)));
          },
          child: Text("Login"),
        ),
      ),
    );
  }
}

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
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Welcome, '),
            Text(
              widget.userName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          PopupMenuButton(
            onSelected: (value) {},
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('Log Out'),
                  value: 'Logout',
                )
              ];
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
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
                _quizListView(),
                _quizListView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _quizListView() {
    return ListView.builder(
      itemCount: 3,
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
            title: Text('Quiz ${index + 1}',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Test your knowledge!"),
            trailing: Chip(
              backgroundColor: Colors.amber,
              label: Text(
                "9:00 AM",
                style: TextStyle(color: Colors.purple),
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => QuestionScreen()));
            },
          ),
        );
      },
    );
  }
}
