
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  String uid;
  String email;
  String? image;
  Timestamp? createdAt;
  List<String> favoritesIds;



  UserModel({
    this.name,
    required this.uid,
    required this.email,
    this.createdAt,
    this.image,
    this.favoritesIds= const[],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      uid: json['uid'],
      email: json['email']??'',
      createdAt: json['createdAt'],
      image: json['image'],
      favoritesIds: json['favoritesIds']== null ?[] : (json['favoritesIds'] as List<dynamic>).map((name) => name.toString()).toList(),
    );
  }


  Map<String, dynamic> toJson() {

    return {
      'name': name,
      'uid': uid,
      'email': email,
      'createdAt': createdAt,
      'image': image,
      'favoritesIds': favoritesIds,
    };
  }
}