part of 'favorites_cubit.dart';

@immutable
abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}
class DeleteFromFavoritesState extends FavoritesState {}
class DeleteAllFavoritesState extends FavoritesState {}

class GetFavoriteLoadingState extends FavoritesState {}
class GetFavoriteSuccessState extends FavoritesState {}
class GetFavoriteErrorState extends FavoritesState {}
