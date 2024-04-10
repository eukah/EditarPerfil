class User {
  String nome;
  String email;
  String profilePicture;
  String password;

  User({
    required this.nome,
    required this.email,
    required this.profilePicture,
    required this.password,
  });

  factory User.fromJson(formState) {
    final nome = formState.validateField('nome');
    final email = formState.validateField('email');
    final profilePicture = formState.validateField('profilePicture');
    final password = formState.validateField('password');

    return User(
      nome: nome,
      email: email,
      profilePicture: profilePicture,
      password: password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'email': email,
      'profilePicture': profilePicture,
      'password': password,
    };
  }
}