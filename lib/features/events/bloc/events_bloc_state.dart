part of 'events_bloc_bloc.dart';

@immutable
sealed class EventsBlocState {}

abstract class EventsActionState extends EventsBlocState{}

class EventsloadingState extends EventsBlocState{}
class EventsErrorState extends EventsBlocState{}



final class EventsBlocInitial extends EventsBlocState {}

class EventFetchingSuccessfullState extends EventsBlocState {
  final List<EventsDataUiModel> events;

  EventFetchingSuccessfullState({required this.events});
}
