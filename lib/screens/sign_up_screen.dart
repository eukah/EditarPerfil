import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'services/user_service.dart';
import 'user.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late User _user;

  @override
  void initState() {
    super.initState();
    _user = User(
      nome: '',
      email: '',
      profilePicture: '',
      password: '',
    );
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
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final user = User.fromJson(_formKey.currentState!);
      UserService.saveUser(user);
      Navigator.pushReplacementNamed(context, '/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
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
                child: const Text('Coloque sua foto'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor coloque seu nome';
                  }
                  return null;
                },
                onSaved: (value) => _user = User(
                  nome: value!,
                  email: _user.email,
                  profilePicture: _user.profilePicture,
                  password: _user.password,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor coloque seu email';
                  }
                  return null;
                },
                onSaved: (value) => _user = User(
                  nome: _user.nome,
                  email: value!,
                  profilePicture: _user.profilePicture,
                  password: _user.password,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor coloque sua senha';
                  }
                  if (value.length < 6) {
                    return 'A senha precisa ter mais de 6 caracteres';
                  }
                  return null;
                },
                onSaved: (value) => _user = User(
                  nome: _user.nome,
                  email: _user.email,
                  profilePicture: _user.profilePicture,
                  password: value!,
                ),
              ),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
