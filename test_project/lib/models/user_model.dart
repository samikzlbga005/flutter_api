// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class userModel {
  String? id;
  String name;
  String age;
  String email;
  String image;
  userModel({
    this.id,
    required this.name,
    required this.age,
    required this.email,
    required this.image,
  });

  

  userModel copyWith({
    String? id,
    String? name,
    String? age,
    String? email,
    String? image,
  }) {
    return userModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      email: email ?? this.email,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'age': age,
      'email': email,
      'image': image,
    };
  }

  factory userModel.fromMap(Map<String, dynamic> map) {
    return userModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      age: map['age'] as String,
      email: map['email'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory userModel.fromJson(String source) => userModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'userModel(id: $id, name: $name, age: $age, email: $email, image: $image)';
  }

  @override
  bool operator ==(covariant userModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.age == age &&
      other.email == email &&
      other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      age.hashCode ^
      email.hashCode ^
      image.hashCode;
  }
}
