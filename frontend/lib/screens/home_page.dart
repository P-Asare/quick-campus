// homepage

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  TextEditingController pickupController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    String apiKey = "AIzaSyDrk905BDTiFuJhQxtfXdKUPTSDPgpiSrE";
    googlePlace = GooglePlace(apiKey);
    pickupController.addListener(() {
      onModify();
    });
  }

  void autoCompleteSearch(
      String value, TextEditingController controller) async {
    print("inside of prediction");
    var result = await googlePlace.autocomplete.get(value);
    print("The result from the prediction is: $result");
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
        controller.text = value;
      });
    }
  }

  void makeSuggestion(String input) async {
    print("inside api call");
    String tokenForSession = '37465';
    String apiKey = "AIzaSyDrk905BDTiFuJhQxtfXdKUPTSDPgpiSrE";
    String groundUrl =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request =
        '$groundUrl?input=$input&key=$apiKey&sessiontoken=$tokenForSession';

    var response = await http.get(Uri.parse(request));

    print(response.body);
  }

  void onModify() {
    makeSuggestion(pickupController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TabBarWidget(title: 'Send', selected: true),
            SizedBox(width: 10),
            TabBarWidget(title: 'Deliver', selected: false),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.grey),
            onPressed: () {},
          )
        ],
      ),
      body: Stack(
        children: [
          // Google Map
          const GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(37.4223, -122.0848),
              zoom: 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 50),
                // Pickup Address
                TextField(
                  controller: pickupController,
                  decoration: InputDecoration(
                    labelText: 'Pickup',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: const Icon(Icons.search),
                  ),
                ),
                // Suggestions for Pickup Address
                if (pickupController.text.isNotEmpty) ...buildSuggestions(),

                const SizedBox(height: 10),
                // Destination Address
                LocationInputField(
                  label: "Destination Address",
                  controller: destinationController,
                  onChanged: (value) {
                    autoCompleteSearch(value, destinationController);
                  },
                ),
                // Suggestions for Destination Address
                if (destinationController.text.isNotEmpty)
                  ...buildSuggestions(),

                const SizedBox(height: 10),
                // Confirm Order Button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF307A59),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Confirm Order"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildSuggestions() {
    return predictions.map((prediction) {
      return ListTile(
        leading: const Icon(Icons.location_on),
        title: Text(prediction.description ?? ''),
        onTap: () {
          // Handle the selection of suggestion
        },
      );
    }).toList();
  }
}

class LocationInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Function(String) onChanged;

  const LocationInputField({
    Key? key,
    required this.label,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: const Icon(Icons.search),
      ),
    );
  }
}

class TabBarWidget extends StatelessWidget {
  final String title;
  final bool selected;

  const TabBarWidget({Key? key, required this.title, required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF307A59) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF307A59)),
      ),
      child: Text(
        title,
        style:
            TextStyle(color: selected ? Colors.white : const Color(0xFF307A59)),
      ),
    );
  }
}
