import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:tif_assignment/features/events/models/events_data_ui_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchInitialEvent>(searchInitialEvent);
  }

  FutureOr<void> searchInitialEvent(
      SearchInitialEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
    final dio = Dio();
    late EventsDataUiModel searchEvent;

    try {
      final response = await dio.get(
        'https://sde-007.api.assignment.theinternetfolks.works/v1/event',
        queryParameters: {'search': event.search},
      );

      if (response.statusCode == 200) {
        final List<dynamic> eventDataList =
            response.data['content']['data']; // Assuming data is a list

        // Iterate through the list and handle each element
        for (int i = 0; i < eventDataList.length; i++) {
          // Access individual elements in the list
          searchEvent = EventsDataUiModel.fromJson(eventDataList[i]);
        }

        emit(SearchSuccessefull(event: searchEvent));
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
