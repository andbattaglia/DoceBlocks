
class User {

  String uid;
  String email;
  String name;
  String lastName;
  bool isAdmin;

  User(this.uid, {this.email = '', this.name = '', this.lastName = '', this.isAdmin = false});

  String getInitials(){
    return '${this.name[0]}${this.lastName[0]}';
  }

  User.fromMap(String uid, dynamic data) :
        uid = uid,
        email = data['email'],
        name = data['name'],
        lastName = data['last_name'],
        isAdmin = data['is_admin'];
}