part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class ProfileImagePickedSuccessfullyState extends ProfileState {}

class UpdateUserDataLoadingState extends ProfileState {}
class UpdateUserDataSuccessState extends ProfileState {}
class UpdateUserDataErrorState extends ProfileState {
  final String error;
  UpdateUserDataErrorState(this.error);
}

class UploadImageToFireStoreLoadingState extends ProfileState {}
class UploadImageToFireStoreSuccessState extends ProfileState {}
class UploadImageToFireStoreErrorState extends ProfileState {
  final String error;
  UploadImageToFireStoreErrorState(this.error);
}
