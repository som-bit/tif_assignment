import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tif_assignment/features/events/UI/details_screen.dart';
import 'package:tif_assignment/features/search/bloc/search_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchBloc searchBloc = SearchBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      // ignore: avoid_unnecessary_containers
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Type event name',
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xFF5669FF),
                ),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                // Implement your search logic here
                searchBloc.add(SearchInitialEvent(value));
                // print('Search query: ');
              },
            ),
          ),
          BlocConsumer<SearchBloc, SearchState>(
            bloc: searchBloc,
            listenWhen: (previous, current) => current is SearchActionState,
            buildWhen: (previous, current) => current is! SearchActionState,
            listener: (context, state) {},
            builder: (context, state) {
              switch (state.runtimeType) {
                case SearchLoadingState:
                  return (const Center(
                    child: CircularProgressIndicator(),
                  ));
                // ignore: type_literal_in_constant_pattern
                case SearchSuccessefull:
                  final successState = state as SearchSuccessefull;
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the second screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                                  bannerImage: successState.event.bannerImage,
                                  dateTime: successState.event.dateTime,
                                  description: successState.event.description,
                                  organiserIcon:
                                      successState.event.organiserIcon,
                                  organiserName:
                                      successState.event.organiserName,
                                  title: successState.event.title,
                                  venueCity: successState.event.venueCity,
                                  venueCountry: successState.event.venueCountry,
                                  venueName: successState.event.venueName,
                                )),
                      );
                    },
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors
                                .white, // Set your desired background color
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF747688)
                                    .withOpacity(0.5), // Set the shadow color
                                spreadRadius: 5, // Set the spread radius
                                blurRadius: 7, // Set the blur radius
                                offset:
                                    const Offset(0, 3), // Set the shadow offset
                              ),
                            ], // Adjust the radius as needed
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    15.0), // Adjust the radius as needed
                                child: Image.network(
                                  successState.event.bannerImage,
                                  width: 95.0, // Adjust the width as needed
                                  height: 110, // Adjust the height as needed
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7),
                                    child: Text(
                                      DateFormat("EEE, MMM d '•'h:mm a")
                                          .format(successState.event.dateTime),
                                      style: const TextStyle(
                                        color: Color(
                                            0xFF5669FF), // Set your desired text color
                                        // Optional: Set the font weight
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7.0),
                                    child: Text(successState.event.title),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      const Icon(Icons.location_on),
                                      SizedBox(
                                        width: 190,
                                        child: Wrap(
                                          children: [
                                            Text(
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              '${successState.event.venueName} ${successState.event.venueCity} ${successState.event.venueCountry}',
                                              style: const TextStyle(
                                                color: Color(
                                                    0xFF747688), // Set your desired text color
                                                // Optional: Set the font weight
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ]),
                          ),
                        ),
                      ),
                    ]),
                  );

                default:
                  return (Container());
              }
            },
          ),
        ],
      ),
    );
  }
}
