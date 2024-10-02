import 'package:flutter/material.dart';
import 'pages/categories_screen.dart';
import 'pages/homescreen.dart'; // Import HomeScreen
import 'pages/posts_screen.dart'; // Import PostsScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Builder(
        builder: (context) => Scaffold(
          // Added Scaffold to support Drawer
          appBar: AppBar(
            title: Text('My App'),
          ),
          drawer: Drawer(
            // Added Drawer for sidebar
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const DrawerHeader(
                  child: Text('Menu'),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  title: Text('Posts'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostsScreen(
                              category: 0)), // Navigate to PostsScreen
                    );
                  },
                ),
                ListTile(
                  title: Text('Categories'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CategoriesScreen()), // Navigate to CategoriesScreen
                    );
                  },
                ),
              ],
            ),
          ),
          body: HomeScreen(), // Set HomeScreen as the body widget
        ),
      ),
    );
  }
}
