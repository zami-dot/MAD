import 'package:flutter/material.dart';

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
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
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
        title: Text('Quiz Test'),
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
                  value: 'Quiz1',
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
          // Background Image
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.3), BlendMode.lighten),
              child: Image.network(
                'https://static.vecteezy.com/system/resources/thumbnails/001/991/202/small/realistic-isolated-neon-sign-of-question-template-decoration-and-covering-on-the-wall-background-vector.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content: TabBarView
          TabBarView(
            controller: _tabController,
            children: [
              ListView.builder(
                itemCount: 3,
                itemBuilder: (ctx, index) {
                  return ListTile(
                    leading: Icon(Icons.quiz),
                    title: Text('Quiz ${index + 1}'),
                    subtitle: Text("This is a basic quiz"),
                    trailing: Text("9:00 AM"),
                  );
                },
              ),
              ListView.builder(
                itemCount: 3,
                itemBuilder: (ctx, index) {
                  return ListTile(
                    leading: Icon(Icons.quiz),
                    title: Text('Medium Quiz ${index + 1}'),
                    subtitle: Text("This is a medium difficulty quiz"),
                    trailing: Text("10:00 AM"),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
