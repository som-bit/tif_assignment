part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

class SearchInitial extends SearchState {}

abstract class SearchActionState extends SearchState{}
 class SearchLoadingState extends SearchState{}

class SearchSuccessefull extends SearchState {
  final EventsDataUiModel event;

  SearchSuccessefull({required this.event});
}
