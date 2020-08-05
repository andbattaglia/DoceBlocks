
class User {

  String uid;
  String email;
  String name;
  String lastName;
  bool isAdmin;

  User(this.uid, {this.email = '', this.name = '', this.lastName = '', this.isAdmin = false});

  User.fromMap(dynamic data) :
        uid = data['uid'],
        email = data['email'],
        name = data['name'],
        lastName = data['last_name'],
        isAdmin = data['is_admin'];
}