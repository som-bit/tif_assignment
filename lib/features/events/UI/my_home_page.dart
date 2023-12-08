import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tif_assignment/features/events/UI/details_screen.dart';
import 'package:tif_assignment/features/events/bloc/events_bloc_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tif_assignment/features/search/Ui/search_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final EventsBlocBloc eventsBlocBloc = EventsBlocBloc();

  @override
  void initState() {
    eventsBlocBloc.add(EventsInitialFetchEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(widget.title),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
              child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.search,
                    color: Color(0xFF5669FF),
                  )
                  // ImageIcon(AssetImage('assets/icons/search.png'),size: 24,),
                  ),
            ),
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.more_vert),
                )),
          ]),
      body: BlocConsumer<EventsBlocBloc, EventsBlocState>(
        bloc: eventsBlocBloc,
        listenWhen: (previous, current) => current is EventsActionState,
        buildWhen: (previous, current) => current is! EventsActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            // ignore: type_literal_in_constant_pattern
            case EventsloadingState:
              return (const Center(
                child: CircularProgressIndicator(),
              ));

            // ignore: type_literal_in_constant_pattern
            case EventFetchingSuccessfullState:
              final successState = state as EventFetchingSuccessfullState;

              return ListView.builder(
                itemCount: successState.events.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the second screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                                  bannerImage:
                                      successState.events[index].bannerImage,
                                  dateTime: successState.events[index].dateTime,
                                  description:
                                      successState.events[index].description,
                                  organiserIcon:
                                      successState.events[index].organiserIcon,
                                  organiserName:
                                      successState.events[index].organiserName,
                                  title: successState.events[index].title,
                                  venueCity:
                                      successState.events[index].venueCity,
                                  venueCountry:
                                      successState.events[index].venueCountry,
                                  venueName:
                                      successState.events[index].venueName,
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
                                  successState.events[index].bannerImage,
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
                                      DateFormat("EEE, MMM d '•'h:mm a").format(
                                          successState.events[index].dateTime),
                                      style: const TextStyle(
                                        color: Color(
                                            0xFF5669FF), // Set your desired text color
                                        // Optional: Set the font weight
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7.0),
                                    child:
                                        Text(successState.events[index].title),
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
                                              '${successState.events[index].venueName} ${successState.events[index].venueCity} ${successState.events[index].venueCountry}',
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
                },
              );

            default:
              return (const SizedBox());
          }
        },
      ),
    );
  }
}
