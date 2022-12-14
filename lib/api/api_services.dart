//clase PostApi para obtener los datos de la API de jsonplaceholder
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prueba_tecnica/api/api_constants.dart';
import 'package:prueba_tecnica/models/comment.dart';

import 'package:prueba_tecnica/models/post.dart';

class ApiService {


 //get all posts
  Future<List<Post>> getAllPost() async {
    final response = await http
        .get(Uri.parse(ApiContants.baseUrl + ApiContants.postsEndpoint));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);            
      return jsonResponse.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts from API');
    }
  }


  //get comments by post id
  Future<List<Comment>> getCommentsByPostId(int postId) async {
    final response = await http.get(Uri.parse(
        ApiContants.baseUrl + ApiContants.commentsEndpoint + '?postId=$postId'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((comment) => Comment.fromJson(comment)).toList();
    } else {
      throw Exception('Failed to load comments from API');
    }
  }


  //create post
  Future<Post> createPost(Post post) async {
    final response = await http.post(
      Uri.parse(ApiContants.baseUrl + ApiContants.postsEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(post.toJson()),
    );
    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create post.');
    }
  }
}
