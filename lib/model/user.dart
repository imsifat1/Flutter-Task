class User {
  int? id;
  String? name, email, token, profilepicture, location, createdat;

  User(
      {this.id,
      this.name,
      this.email,
      this.token,
      this.profilepicture,
      this.location,
      this.createdat});

  User.fromJson(Map<String, dynamic> json) {
    id = json['Id'] ?? json['id'] ?? 0;
    name = json['Name'] ?? json['name'] ?? '';
    email = json['Email'] ?? json['email'] ?? '';
    token = json['Token'] ?? json['token'] ?? '';
    profilepicture = json['profilepicture'] ?? '';
    location = json['location'] ?? '';
    createdat = json['createdat'] ?? '';
  }

  toJson() {
    return {
      'Id': id ?? 0,
      'Name': name ?? '',
      'Email': email ?? '',
      'Token': token ?? ''
    };
  }
}
