import 'package:cloud_firestore/cloud_firestore.dart';

class TranslationModel{
  String? text;
  String translation;
  String translateFrom;
  String translateTo;
  String uid;
  String userId;
  String? imagePath;
  Timestamp createdAt;


  TranslationModel({
    this.text,
    this.imagePath,
    required this.translation,
    required this.uid,
    required this.userId,
    required this.createdAt,
    required this.translateFrom,
    required this.translateTo,
  });


  factory TranslationModel.fromJson(Map<String, dynamic> json)
  => TranslationModel(
      translation: json['translation'],
      uid: json['uid'],
      userId: json['userId'],
      createdAt: json['createdAt'],
      translateFrom: json['translateFrom'],
      text: json['text'],
      imagePath: json['imagePath'],
      translateTo: json['translateTo']);

  Map<String, dynamic> toMap()=> {
    'text': text,
    'uid': uid,
    'userId': userId,
    'translation': translation,
    'createdAt': createdAt,
    'translateFrom': translateFrom,
    'translateTo': translateTo,
    'imagePath': imagePath,
  };
}