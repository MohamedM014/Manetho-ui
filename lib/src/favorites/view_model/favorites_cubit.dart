import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mannetho/src/favorites/models/translation_model.dart';
import 'package:mannetho/src/layout/view_model/main_cubit.dart';
import '../../../core/constants/constants.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());


  bool loadWhileGetFav= false;
  List<TranslationModel> favorites= [];
  Future<void> getFavorites({required List<String> ids})async {

    if(ids.isEmpty){
      return;
    }
    loadWhileGetFav= true;
    emit(GetFavoriteLoadingState());

    FirebaseFirestore.instance
        .collection(AppConstants.historyCollection)
        .where(FieldPath.documentId, whereIn: ids).get()
        .then((value) {
        value.docs.forEach((element) {
          favorites.add(TranslationModel.fromJson(element.data()));
        });
          loadWhileGetFav= false;
          emit(GetFavoriteSuccessState());
    }).catchError((error){
      loadWhileGetFav= false;
      emit(GetFavoriteErrorState());
    });
  }

  Query favoritesQuery(List<String> ids) => FirebaseFirestore.instance
      .collection(AppConstants.historyCollection)
      .where(FieldPath.documentId, whereIn: ids);

  /// Delete item from user favorites list in firebase.
  /// Delete it from current user data.
  /// Rebuild the screen to get the list.
  Future<void> deleteFromFavorites(
      {required String itemId, required BuildContext context}) async {
    List<String> favIds = context.read<MainCubit>().currentUser.favoritesIds;
    int index= favIds.indexOf(itemId);
    favIds.removeAt(index);

    await FirebaseFirestore.instance
        .collection(AppConstants.usersCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'favoritesIds': favIds}).then((value) {
      favorites.removeAt(index);
      context.read<MainCubit>().currentUser.favoritesIds = favIds;
      emit(DeleteFromFavoritesState());
    }).catchError((error) {});
  }


  bool loadWhileDeleting= false;
  Future<void> deleteAllFavorites(BuildContext context)async {
    await FirebaseFirestore.instance
        .collection(AppConstants.usersCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'favoritesIds': []}).then((value) {
      favorites.clear();
      context.read<MainCubit>().currentUser.favoritesIds = [];
      emit(DeleteAllFavoritesState());
    }).catchError((error) {
      /// TODO : Tell the user
    });
    }
}
