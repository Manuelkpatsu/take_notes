class User {
  final String id;
  final String username;
  final String email;
  final bool active;
  final String createdAt;
  final String updatedAt;

  User({
    this.id,
    this.username,
    this.email,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  User.fromData(Map<String, dynamic> data)
      : id = data['_id'],
        username = data['username'],
        email = data['email'],
        active = data['active'],
        createdAt = data['createdAt'],
        updatedAt = data['updatedAt'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'active': active,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
