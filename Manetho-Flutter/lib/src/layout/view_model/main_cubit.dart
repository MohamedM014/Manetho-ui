import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as fireStore;
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mannetho/src/favorites/models/translation_model.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/constants.dart';
import '../view/camera.dart';
import '../view/upload.dart';
import '../../authentication/models/user_model.dart';
import '../../favorites/view/favorite_screen.dart';
import '../../history/view/history.dart';
import '../view/home_screen.dart';
part 'main_states.dart';

class MainCubit extends Cubit<MainAppStates> {
  MainCubit() : super(MainInitialState());


  // Current registered user
  late UserModel currentUser;
  bool loadWhileGetUser= false;
  Future<void> getCurrentUser(BuildContext context) async {
    loadWhileGetUser= true;
    emit(GetUserDataLoadingState());
    await FirebaseFirestore.instance.collection(AppConstants.usersCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      currentUser = UserModel.fromJson(value.data() as Map<String, dynamic>);
      loadWhileGetUser= false;
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      loadWhileGetUser= false;
      emit(GetUserDataErrorState());
    });
  }


  final List<Widget> screens = [
    FavoritesScreen(),
    const Upload(),
    HomePage(),
    CameraScreen(),
    History(),
  ];

  int bottomNavBarIndex = 2;
  void changeBottomNavBarIndex(int index) {
    bottomNavBarIndex = index;
    emit(ChangeBottomNavBarIndexState());
  }


  // bool _pictureTaken = false;
  File? uploadedImageFile;

  /// Upload picture from gallery.
  Future<void> uploadPicture(ImageSource imageSource) async {
    // if (_pictureTaken) {
    //   return; // Don't allow taking another picture if one has already been taken
    // }

    final imageFile = await ImagePicker().pickImage(source: imageSource);
    if (imageFile != null) {
      final croppedImage = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [CropAspectRatioPreset.square],
      );

      if (croppedImage != null) {
          uploadedImageFile = File(croppedImage.path);
          // _pictureTaken = true;

          /// return to home screen.
        changeBottomNavBarIndex(2);
      }else {
        /// return to home screen.
        changeBottomNavBarIndex(2);//no croped
      }
    } else {
      /// return to home screen.
      changeBottomNavBarIndex(2);// If no picture is taken, return to the home page
    }
  }



  bool loadWhileUpload= false;
  // Upload category image to firebase storage.
  Future<void> uploadImageToFirestore(BuildContext context) async {
    loadWhileUpload = true;
    emit(UploadImageToFireStoreLoadingState());

    fireStore.FirebaseStorage.instance
        .ref(AppConstants.usersCollection)
        .child(Uri.file(uploadedImageFile!.path).pathSegments.last)
        .putFile(uploadedImageFile!)
        .then((value) {

      value.ref.getDownloadURL().then((value) async {
        /// After uploading image, save data in fire store.
        await storeInHistory(value);
      }).catchError((error) {
        loadWhileUpload = false;
        emit(UploadImageToFireStoreErrorState());
      });

    }).catchError((error) {
      loadWhileUpload = false;
      emit(UploadImageToFireStoreErrorState());
    });
  }


  Future<void> storeInHistory(String? imagePath)async {

    if(imagePath==null){
      loadWhileUpload= true;
      emit(StoreInHistoryLoadingState());
    }
    String id= const Uuid().v4();

    FirebaseFirestore.instance.collection(AppConstants.historyCollection)
        .doc(id)
        .set(TranslationModel(
      uid: id,
        translateFrom: 'Fr',
        translateTo: 'En',
        translation: 'This is fake translation',
        imagePath: imagePath,
        userId: FirebaseAuth.instance.currentUser!.uid,
        createdAt: Timestamp.now(),
    ).toMap()).then((value)async {

      uploadedImageFile= null;
      loadWhileUpload = false;
      if(inFavorite){
        await putItemInFavorite(id);
      }
      inFavorite= false;
      emit(StoreInHistorySuccessState());
    }).catchError((error){
      loadWhileUpload = false;
      emit(StoreInHistoryErrorState());
    });
  }


  Future<void> putItemInFavorite(String itemId)async {

    currentUser.favoritesIds.add(itemId);

    FirebaseFirestore.instance.collection(AppConstants.usersCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'favoritesIds': currentUser.favoritesIds}).catchError((error){});
  }


  bool inFavorite= false;
  void changeFavorite(){
    if(uploadedImageFile!= null){
      inFavorite= !inFavorite;
      emit(ChangeFavoriteState());
    }
  }

// String? googleLink;
  // String? appleLink;
  // /// Get setting data
  // Future<void> getSettingData()async {
  //   FirebaseFirestore.instance.collection('Settings')
  //       .doc('3whlNO0o61DXOXkJx9Xi').get().then((value){
  //         googleLink= value.data()?['googleLink'];
  //         appleLink= value.data()?['appleLink'];
  //   }).catchError((error){});
  // }


}
