part of 'events_bloc_bloc.dart';

@immutable
sealed class EventsBlocEvent {}

class EventsInitialFetchEvent extends EventsBlocEvent {}
