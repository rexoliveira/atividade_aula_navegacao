import '../model/user.dart';

class AccountUser {
  Map<String, User> users = {};
  User? user;

  login(String email, String password) {
    if (users.isEmpty) {
      return null;
    }

    if (users['user']!.email != email || users['user']!.password != password) {
      return null;
    }

    return users['user'];
  }

  cadastrar({
    required String name,
    required String email,
    required String password,
  }) {
    user = User(name: name, email: email, password: password);

    users['user'] = user!;
    return true;
  }
}
