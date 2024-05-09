
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mannetho/core/constants/constants.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart' as fireStore;

import '../model/feedback_model.dart';
part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit() : super(FeedbackInitial());

  TextEditingController feedbackController= TextEditingController();




  File? image;
  String? currentProfileImage;
  var picker = ImagePicker();

  void pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(GetImageState());
    }
  }




  bool loadWhileUpload= false;
  Future<void> storeFeedback(String? imagePath)async {

    if(imagePath==null){
      loadWhileUpload= true;
      emit(StoreFeedBackLoadingState());
    }
    String id= const Uuid().v4();
    FirebaseFirestore.instance.collection(AppConstants.feedbackCollection)
        .doc(id)
        .set(FeedbackModel(
        id: id,
      image:imagePath,
      userId: FirebaseAuth.instance.currentUser!.uid,
      createdAt: Timestamp.now(),
      issue: feedbackController.text.trim()
    ).toJson()).then((value) {
      removeControllers();
      loadWhileUpload = false;
      emit(StoreFeedBackSuccessState());
    }).catchError((error){
      loadWhileUpload = false;
      emit(StoreFeedBackErrorState());
    });
  }


  // Upload category image to firebase storage.
  Future<void> uploadImageToFirestore(BuildContext context) async {
    loadWhileUpload = true;
    emit(UploadImageToFireStoreLoadingState());

    fireStore.FirebaseStorage.instance
        .ref(AppConstants.usersCollection)
        .child(Uri.file(image!.path).pathSegments.last)
        .putFile(image!)
        .then((value) {

      value.ref.getDownloadURL().then((value) async {
        /// After uploading image, save data in fire store.
        await storeFeedback(value);
      }).catchError((error) {
        loadWhileUpload = false;
        emit(UploadImageToFireStoreErrorState());
      });

    }).catchError((error) {
      loadWhileUpload = false;
      emit(UploadImageToFireStoreErrorState());
    });
  }

  void removeControllers(){
    feedbackController.clear();
    image= null;
  }

}
