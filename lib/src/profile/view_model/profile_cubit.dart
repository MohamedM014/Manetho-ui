import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as fireStore;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mannetho/core/constants/constants.dart';
import 'package:mannetho/src/authentication/models/user_model.dart';
import 'package:mannetho/src/layout/view_model/main_cubit.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  TextEditingController emailController= TextEditingController(text: 'mohamed nasser');
  TextEditingController nameController= TextEditingController(text: 'mohamed@gmail.com');

  late UserModel currentUser;
  void getUser(UserModel user){
    currentUser= user;
    currentProfileImage= currentUser.image;
    emailController.text= currentUser.email;
    nameController.text= currentUser.name??'';
  }


  Future<void> saveChanges(BuildContext context,)async {
    if(profileImage!= null){
      // means that the user select new image, so upload it and save data.
      await uploadProfileImageToFirestore(context);

    }else{
      // image does not changed, so save data with old image path.
      await updateUserData(profileImagePath: currentProfileImage, context: context);
    }
  }


  bool loadWhileUpdating= false;
  Future<void> updateUserData({
    required BuildContext context,
    String? profileImagePath
  })async {
    loadWhileUpdating= true;
    emit(UpdateUserDataLoadingState());
    FirebaseFirestore.instance.collection(AppConstants.usersCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'name': nameController.text.trim(),
      'image': profileImagePath
    }).then((value) {
      currentUser.name= nameController.text.trim();
      context.read<MainCubit>().getCurrentUser(context);
      loadWhileUpdating= false;
      emit(UpdateUserDataSuccessState());
    }).catchError((error){
      loadWhileUpdating= false;
      emit(UpdateUserDataErrorState(AppConstants.errorMessage));
    });
  }


  File? profileImage;
  String? currentProfileImage;
  var picker = ImagePicker();

  void pickProfileImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessfullyState());
    }
  }



  // Upload category image to firebase storage.
  Future<void> uploadProfileImageToFirestore(BuildContext context) async {
    loadWhileUpdating = true;
    emit(UploadImageToFireStoreLoadingState());

    // delete old image if it exist.
    if(currentProfileImage!= null){
      await deleteImageFromStorage(currentProfileImage!);
    }

    fireStore.FirebaseStorage.instance
        .ref(AppConstants.usersCollection)
        .child(Uri.file(profileImage!.path).pathSegments.last)
        .putFile(profileImage!)
        .then((value) {

      value.ref.getDownloadURL().then((value) async {
        /// After uploading profile image, save data in fire store.
        await updateUserData(context: context, profileImagePath: value);
      }).catchError((error) {
        loadWhileUpdating = false;
        emit(UploadImageToFireStoreErrorState(AppConstants.errorMessage));
      });

    }).catchError((error) {
      loadWhileUpdating = false;
      emit(UploadImageToFireStoreErrorState(AppConstants.errorMessage));
    });
  }


  Future<void> deleteImageFromStorage(String downloadLink) async {

    // Extract the reference from the download link
    Reference storageReference = FirebaseStorage.instance.refFromURL(downloadLink);

    // Delete the file from Firebase Storage
    try {
      await storageReference.delete();
    } catch (e) {}
  }


  // Future<void> updateUserEmail(String userId, String newEmail) async {
  //   try {
  //     // Step 1: Update email in Firebase Authentication
  //     User user = FirebaseAuth.instance.currentUser!;
  //     await user.updateEmail(newEmail);
  //
  //     // Step 2: Update email in Firestore collection
  //     await FirebaseFirestore.instance.collection('users').doc(userId).update({
  //       'email': newEmail,
  //     });
  //
  //     print('User email updated successfully.');
  //   } catch (e) {
  //     print('Error updating user email: $e');
  //   }
  // }

  // Future resetEmail(String newEmail) async {
  //   var message;
  //   FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
  //   firebaseUser
  //       .updateEmail(newEmail)
  //       .then(
  //         (value) => message = 'Success',
  //   )
  //       .catchError((onError) => message = 'error');
  //   return message;
  // }

}
