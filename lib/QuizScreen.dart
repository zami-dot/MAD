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
        title: Text('GameName'),
        backgroundColor: Colors.purple, 
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Add your search logic here
            },
          ),
          PopupMenuButton(
            onSelected: (value) {
              // Add logic based on menu item selection
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('Quiz 1'),
                  value: 'Quiz1',
                ),
                PopupMenuItem(
                  child: Text('Quiz 2'),
                  value: 'Quiz 2',
                ),
                PopupMenuItem(
                  child: Text('Quiz 3'),
                  value: 'Quiz 3',
                )

                // Add more menu options as needed...
              ];
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Basic Quiz'),
            Tab(text: 'Medium Quiz'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
            itemCount: 3,
            itemBuilder: (ctx, index) {
              return ListTile(
                leading: Icon(Icons.quiz), // icon for leading
                title: Text('Quiz ${index + 1}'),
                subtitle: Text("This is a basic quiz"),
                trailing: Text("9:00 AM"), // Time is set as trailing
              );
            },
          ),
          ListView.builder(
            itemCount: 3,
            itemBuilder: (ctx, index) {
              return ListTile(
                leading: Icon(Icons.quiz), //  icon for leading
                title: Text('Medium Quiz ${index + 1}'),
                subtitle: Text("This is a medium difficulty quiz"),
                trailing: Text("10:00 AM"), // Time is set as trailing
              );
            },
          ),
        ],
      ),
    );
  }
}
