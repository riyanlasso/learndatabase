class userModel {
  int? id;
  String? name, password, createdAt, updatedAt;
  userModel(
      {this.id, this.name, this.password, this.createdAt, this.updatedAt});
  factory userModel.fromJson(Map<String, dynamic> json) {
    return userModel(
        id: json['id'],
        name: json['nama'],
        password: json['password'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
}
