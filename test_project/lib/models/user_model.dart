// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class userModel {
  String? id;
  String name;
  String email;
  String image;
  userModel({
    this.id,
    required this.name,
    required this.email,
    required this.image,
  });

  userModel copyWith({
    String? id,
    String? name,
    String? email,
    String? image,
  }) {
    return userModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'image': image,
    };
  }

  factory userModel.fromMap(Map<String, dynamic> map) {
    return userModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      email: map['email'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory userModel.fromJson(String source) =>
      userModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'userModel(id: $id, name: $name, email: $email, image: $image)';
  }

  @override
  bool operator ==(covariant userModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ email.hashCode ^ image.hashCode;
  }
}
