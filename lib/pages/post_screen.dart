import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostScreen extends StatelessWidget {
  final int postId;

  PostScreen({required this.postId});

  Future<Map<String, dynamic>> fetchPost() async {
    final response = await http.get(Uri.parse(
        'https://nagpur.wordcamp.org/2024/wp-json/wp/v2/posts/$postId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Map<String, dynamic>> fetchFeaturedImage(int mediaId) async {
    final response = await http.get(Uri.parse(
        'https://nagpur.wordcamp.org/2024/wp-json/wp/v2/media/$mediaId'));
    if (response.statusCode == 200) {
      print('image found image filename');
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load featured image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchPost(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final post = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                // {{ edit_1 }}
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post['title']['rendered'],
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    Text(post['content']['rendered'],
                        style: TextStyle(fontSize: 16)),
                    // New code to display the featured image
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
