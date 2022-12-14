import 'package:flutter/material.dart';
import 'package:prueba_tecnica/api/api_services.dart';
import 'package:prueba_tecnica/screens/comment_screen.dart';
import 'package:prueba_tecnica/widget/create_post.dart';

class HomeScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de posts'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: apiService.getAllPost(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              reverse: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return _itemList(snapshot, index, context);
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => const CreatePost(),
          );
          Navigator.push(context, route);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Container _itemList(
      AsyncSnapshot<dynamic> snapshot, int index, BuildContext context) {
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
        child: _postItem(snapshot, index, context));
  }

  ListTile _postItem(
      AsyncSnapshot<dynamic> snapshot, int index, BuildContext context) {
    return ListTile(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => CommentScreen(postId: snapshot.data[index].id),
        );
        Navigator.push(context, route);
      },
      leading: CircleAvatar(
        child: Text(snapshot.data[index].id.toString()),
      ),
      title: Text(snapshot.data[index].title.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      subtitle: Text(snapshot.data[index].body),
    );
  }
}
