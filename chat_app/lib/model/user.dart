class User {
  final String uid;
  final String email;
  final String name;


  User(this.uid, this.email, this.name);

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
    };
  }
}