part of 'main_cubit.dart';

@immutable
abstract class MainAppStates {}

class MainInitialState extends MainAppStates {}
class ChangeBottomNavBarIndexState extends MainAppStates {}
class ChangeFavoriteState extends MainAppStates {}

class GetUserDataLoadingState extends MainAppStates {}
class GetUserDataSuccessState extends MainAppStates {}
class GetUserDataErrorState extends MainAppStates {}

class UploadImageToFireStoreLoadingState extends MainAppStates {}
class UploadImageToFireStoreSuccessState extends MainAppStates {}
class UploadImageToFireStoreErrorState extends MainAppStates {}

class StoreInHistoryLoadingState extends MainAppStates {}
class StoreInHistorySuccessState extends MainAppStates {}
class StoreInHistoryErrorState extends MainAppStates {}
