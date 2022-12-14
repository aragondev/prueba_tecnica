import 'package:flutter/material.dart';
import 'package:prueba_tecnica/api/api_services.dart';
import 'package:prueba_tecnica/models/post.dart';

//Widget con formulario para crear un post con validaciones
class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final _userIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[            
              _formTitle(),
              _formBody(),
              _formUserId(),
              SizedBox(height: 20),
              _formButton(context),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _formTitle() {
    return TextFormField(
      controller: _titleController,
      decoration: _decoration(Icons.title, 'Title', 'Enter a title'),
      //validar que value solo contenga letras
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter some text';
        }
        //validar que solo acepte palabras sin numeros ni caracteres especiales
        if (value.contains(RegExp(r'^[a-zA-Z\s]+$'))) {
          return null;
        }
        return 'Please enter only letters';
      },
    );
  }

  TextFormField _formBody() {
    return TextFormField(
      controller: _bodyController,
      decoration: _decoration( Icons.text_fields, 'Description', 'Enter a description'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }

  TextFormField _formUserId() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _userIdController,
      decoration: _decoration( Icons.pin, 'User Id', 'Enter a number'),
      //valida que value solo contenga numeros y que no sea vacio
      validator: (value) {
        if (value!.isEmpty) {
          return 'This field is required';
        } else {
          if (value.contains(RegExp(r'^[0-9]+$'))) {
            return null;
          }
        }
        return 'Please enter only numbers';
        // return null;
      },
    );
  }

  InputDecoration _decoration(IconData icon, String label, String hint) {
    return InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.purple),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.purple, width: 2.0),
        ),
        hintText: hint,
        labelText:label,
        labelStyle: const TextStyle(
          color: Colors.grey,
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.purple,
        ));
  }

  ElevatedButton _formButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.purple,
        onPrimary: Colors.white,
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Processing Data')),
          );
          //si el formulario es valido, se envian los datos a la api y se redirecciona a la pantalla de posts
          ApiService().createPost(Post(
            id: 0,
            title: _titleController.text,
            body: _bodyController.text,
            userId: int.parse(_userIdController.text),
          ));
          Navigator.pop(context);
        }
      },
      child: const Text('Submit'),
    );
  }
}
