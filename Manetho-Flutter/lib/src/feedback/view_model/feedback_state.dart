part of 'feedback_cubit.dart';

@immutable
abstract class FeedbackState {}

class FeedbackInitial extends FeedbackState {}
class GetImageState extends FeedbackState {}

class UploadImageToFireStoreLoadingState extends FeedbackState {}
class UploadImageToFireStoreSuccessState extends FeedbackState {}
class UploadImageToFireStoreErrorState extends FeedbackState {}

class StoreFeedBackLoadingState extends FeedbackState {}
class StoreFeedBackSuccessState extends FeedbackState {}
class StoreFeedBackErrorState extends FeedbackState {}
