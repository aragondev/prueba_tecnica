import 'package:flutter/material.dart';
import 'package:prueba_tecnica/api/api_services.dart';

class CommentScreen extends StatelessWidget {
  final int postId;

  CommentScreen({Key? key, required this.postId}) : super(key: key);

  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Comments on post $postId'),
      ),
      body: FutureBuilder(
        future: apiService.getCommentsByPostId(postId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: _commentItem(snapshot, index));
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  ListTile _commentItem(AsyncSnapshot<dynamic> snapshot, int index) {
    return ListTile(
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text(snapshot.data[index].name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            
          )),
      ),
      subtitle: Text(snapshot.data[index].body),
    );
  }
}
