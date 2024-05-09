import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackModel {
  String? issue;
  String id;
  String userId;
  String? image;
  Timestamp? createdAt;



  FeedbackModel({
    this.issue,
    required this.id,
    required this.userId,
    this.createdAt,
    this.image,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      issue: json['issue'],
      id: json['id'],
      userId: json['userId'],
      createdAt: json['createdAt'],
      image: json['image'],
    );
  }


  Map<String, dynamic> toJson() {

    return {
      'issue': issue,
      'id': id,
      'userId': userId,
      'createdAt': createdAt,
      'image': image,
    };
  }
}