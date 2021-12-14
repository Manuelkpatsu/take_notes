class User {
  bool? active;
  String? id;
  String? email;
  String? username;
  String? createdAt;
  String? updatedAt;

  User({
    this.active,
    this.id,
    this.email,
    this.username,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    id = json['_id'];
    email = json['email'];
    username = json['username'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['active'] = this.active;
    data['email'] = this.email;
    data['username'] = this.username;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    
    return data;
  }
}
