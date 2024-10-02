import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'post_screen.dart';

class PostsScreen extends StatelessWidget {
  final String baseUrl =
      'https://nagpur.wordcamp.org/2024/wp-json/wp/v2/posts'; // Modify this URL
  final int category; // New parameter for category

  PostsScreen({Key? key, required this.category})
      : super(key: key); // Constructor update

  Future<List<dynamic>> fetchPosts() async {
    final response = await http.get(Uri.parse(
        '$baseUrl?per_page=10${category > 0 ? '&categories=$category' : ''}')); // Add category if greater than 0
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Latest Posts'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(posts[index]['title']['rendered']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PostScreen(postId: posts[index]['id']),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
