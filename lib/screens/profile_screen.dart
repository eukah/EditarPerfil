import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'services/user_service.dart';
import 'sign_up_screen.dart';
import 'user.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User _user;

  @override
  void initState() {
    super.initState();
    _user = UserService.getUser() as User;
  }

  void _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _user = User(
          nome: _user.nome,
          email: _user.email,
          profilePicture: pickedFile.path,
          password: _user.password,
        );
        UserService.saveUser(_user);
      });
    }
  }

  void _editProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpScreen(),
      ),
    );
  }

  void _logout() {
    UserService.clearUser();
    Navigator.pushReplacementNamed(context, '/signup');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: _user.profilePicture.isEmpty
                  ? null
                  : FileImage(File(_user.profilePicture)),
              child: _user.profilePicture.isEmpty
                  ? const Icon(Icons.person, size: 50)
                  : Container(),
            ),
            ElevatedButton(
              onPressed: () {
                _pickImage(ImageSource.camera);
              },
              child: const Text('Escolha uma foto'),
            ),
            Text('Nome: ${_user.nome}'),
            Text('Email: ${_user.email}'),
            ElevatedButton(
              onPressed: _editProfile,
              child: const Text('Edite o Perfil'),
            ),
          ],
        ),
      ),
    );
  }
}