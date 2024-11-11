import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:laboratorio_prueba/models/autor.dart';
import 'dart:convert';
import 'package:laboratorio_prueba/models/post.dart';


class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  late Future<List<Post>> _futurePosts;

  @override
  void initState() {
    super.initState();
    //_futurePosts = fetchPosts();
    _futurePosts = fetchPostsWithUsers();
  }

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<List<Autor>> fetchAuthors() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((autor) => Autor.fromJSON(autor)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

Future<List<Post>> fetchPostsWithUsers() async {
  List<Post> posts = await fetchPosts();
  List<Autor> users = await fetchAuthors();

  Map<int, Autor> userMap = { for (var user in users) user.id : user };

  for (var post in posts) {
    post.user = userMap[post.userId];
  }

  return posts;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: FutureBuilder<List<Post>>(
  future: _futurePosts,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return Center(child: Text('No posts found'));
    } else {
      return ListView.builder(
  itemCount: snapshot.data!.length,
  itemBuilder: (context, index) {
    Post post = snapshot.data![index];
    return InkWell(
      onTap: () {
        // Handle the click event here
        // For example, navigate to a detail page or show a dialog
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetailScreen(post: post),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(10.0),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.body,
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    post.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Author: ${post.user?.name ?? 'Unknown'}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  },
);
    }
  },
),
    );
  }
}

class PostDetailScreen extends StatelessWidget {
  final Post post;

  PostDetailScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.body,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Author: ${post.user?.name ?? 'Unknown'}',
              style: TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}