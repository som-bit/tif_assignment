// ignore_for_file: avoid_print

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:tif_assignment/features/events/models/events_data_ui_model.dart';

part 'events_bloc_event.dart';
part 'events_bloc_state.dart';

class EventsBlocBloc extends Bloc<EventsBlocEvent, EventsBlocState> {
  EventsBlocBloc() : super(EventsBlocInitial()) {
    on<EventsInitialFetchEvent>(eventsInitialFetchEvent);
  }

  FutureOr<void> eventsInitialFetchEvent(
      EventsInitialFetchEvent event, Emitter<EventsBlocState> emit) async {
    emit(EventsloadingState());
    final dio = Dio();
    List<EventsDataUiModel> events = [];
    try {
      final response = await dio.get(
          'https://sde-007.api.assignment.theinternetfolks.works/v1/event');

      for (int i = 0; i < response.data['content']['data'].length; i++) {
        EventsDataUiModel event =
            EventsDataUiModel.fromJson(response.data['content']['data'][i]);
        events.add(event);
      }
      emit(EventFetchingSuccessfullState(events: events));
    } catch (e) {
      // emit(EventsErrorState());
      print(e);
    }
  }
}
