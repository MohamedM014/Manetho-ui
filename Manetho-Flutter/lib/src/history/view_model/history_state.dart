part of 'history_cubit.dart';

@immutable
abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class DeleteHistoryItemSuccessState extends HistoryState {}
class DeleteHistoryItemErrorState extends HistoryState {}

class DeleteAllHistorySuccessState extends HistoryState {}
class DeleteAllHistoryErrorState extends HistoryState {}