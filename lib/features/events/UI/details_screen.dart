import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen(
      {super.key,
      required this.title,
      required this.bannerImage,
      required this.dateTime,
      required this.description,
      required this.organiserIcon,
      required this.organiserName,
      required this.venueCity,
      required this.venueCountry,
      required this.venueName});

  final String title;
  final String description;
  final String bannerImage;
  final DateTime dateTime;
  final String organiserName;
  final String organiserIcon;
  final String venueName;
  final String venueCity;
  final String venueCountry;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: AppBar(
          title: const Text(
            'Event Details',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors
                .white, // Set the color of the back button for this screen
          ),
          flexibleSpace: Image(
            image: NetworkImage(
                widget.bannerImage), // Replace with your image path
            fit: BoxFit.cover,
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                  color: Colors.white
                      .withOpacity(0.5), // Set your desired background color
                  borderRadius: BorderRadius.circular(15.0),
                  // Adjust the radius as needed
                ),
                child: const Icon(
                  Icons.bookmark,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.title,
              style: const TextStyle(fontSize: 38),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      height: 51,
                      width: 54,
                      child: Image(
                        image: NetworkImage(widget.organiserIcon),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.organiserName,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const Text(
                        "Organizer",
                        style: TextStyle(
                          color: Color(0xFF747688),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: 51,
                      width: 54,
                      decoration: BoxDecoration(
                        color: const Color(
                            0xFFEAEDFF), // Set your desired background color
                        borderRadius: BorderRadius.circular(15.0),
                        // Adjust the radius as needed
                      ),
                      child: const Icon(
                        Icons.calendar_month,
                        color: Color(0xFF5669FF),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                        DateFormat("d MMMM, yyyy").format(widget.dateTime),
                      ),
                      Text(
                        style: const TextStyle(
                          color: Color(0xFF747688),
                        ),
                        DateFormat("EEEE, h:mm a").format(widget.dateTime),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: 51,
                      width: 54,
                      decoration: BoxDecoration(
                        color: const Color(
                            0xFFEAEDFF), // Set your desired background color
                        borderRadius: BorderRadius.circular(15.0),
                        // Adjust the radius as needed
                      ),
                      child: const Icon(
                        Icons.location_on,
                        color: Color(0xFF5669FF),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 250,
                        child: Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                // softWrap: false,
                                widget.venueName,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        style: const TextStyle(
                          color: Color(0xFF747688),
                        ),
                        '${widget.venueCity} , ${widget.venueCountry}',
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 26.0, top: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'About Event',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 350,
                        child: Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Text(
                                overflow: TextOverflow.fade,
                                maxLines: 4,
                                // softWrap: false,
                                widget.description,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(
                                      0xFF747688), // Set your desired text color
                                  // Optional: Set the font weight
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5669FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80.0, vertical: 15.0),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Book Now',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      SizedBox(width: 8.0), // Add space between text and icon
                      CircleAvatar(
                        backgroundColor: Color(
                            0xFF3D56F0), // Set the circle background color
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white, // Set the arrow color
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
