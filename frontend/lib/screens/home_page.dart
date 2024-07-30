import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickcampus/widgets/filled_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final FocusNode _pickupFocusNode = FocusNode();
  final PanelController _panelController = PanelController();
  List<String> _pickupSuggestions = [];
  List<PlaceDetails> _placeDetails = [];
  Timer? _debounce;

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(5.7630902491463365, -0.2236314561684989),
    zoom: 14,
  );

  final List<Marker> myMarker = [];
  final List<Marker> markerList = [
    const Marker(
        markerId: MarkerId('home'),
        position: LatLng(5.7630902491463365, -0.2236314561684989),
        infoWindow: InfoWindow(title: "The hill"))
  ];

  @override
  void initState() {
    super.initState();
    myMarker.addAll(markerList);
    _pickupController.addListener(_onPickupChanged);
    _pickupFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _pickupController.dispose();
    _destinationController.dispose();
    _pickupFocusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onPickupChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (_pickupController.text.isNotEmpty) {
        makeSuggestion(_pickupController.text);
      }
    });
  }

  void _onFocusChange() {
    if (_pickupFocusNode.hasFocus) {
      _panelController.open(); // Expand the sliding panel
    }
  }

  void makeSuggestion(String input) async {
    String tokenForSession = '37465';
    String apiKey = "AIzaSyDrk905BDTiFuJhQxtfXdKUPTSDPgpiSrE";
    String groundUrl =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request =
        '$groundUrl?input=$input&key=$apiKey&sessiontoken=$tokenForSession';

    var response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      List<String> suggestions = [];
      var json = jsonDecode(response.body);
      print(response.body);
      for (var prediction in json['predictions']) {
        suggestions.add(prediction['description']);
        getPlaceDetails(prediction['place_id']); // Fetch details
      }
      setState(() {
        _pickupSuggestions = suggestions;
      });
    } else {
      print('Error: ${response.reasonPhrase}');
    }
  }

  Future<void> getPlaceDetails(String placeId) async {
    String apiKey = "AIzaSyDrk905BDTiFuJhQxtfXdKUPTSDPgpiSrE";
    String groundUrl =
        "https://maps.googleapis.com/maps/api/place/details/json";
    String request = '$groundUrl?place_id=$placeId&key=$apiKey';

    var response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var result = json['result'];
      var location = result['geometry']['location'];
      var lat = location['lat'];
      var lng = location['lng'];

      setState(() {
        _placeDetails.add(PlaceDetails(
          name: result['name'],
          address: result['formatted_address'],
          lat: lat,
          lng: lng,
        ));
      });
    } else {
      print('Error: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        GoogleMap(
          initialCameraPosition: _initialPosition,
          mapType: MapType.normal,
          markers: Set<Marker>.of(myMarker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),

        // Input
        SlidingUpPanel(
          controller: _panelController,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
          minHeight: 245,
          maxHeight:
              MediaQuery.of(context).size.height * 0.75, // Adjust as needed
          panel: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                children: [
                  const SizedBox(height: 15.0),
                  Container(
                    width: 40.0,
                    height: 6.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(2.0)),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _pickupController,
                          focusNode: _pickupFocusNode,
                          cursorColor: const Color(0xFF307A59),
                          decoration: InputDecoration(
                            focusColor: const Color(0xFFD1E2DB),
                            labelText: 'Pickup Address',
                            prefixIcon: Theme(
                              data: ThemeData(
                                iconTheme:
                                    const IconThemeData(color: Colors.grey),
                              ),
                              child: const Icon(Icons.local_shipping),
                            ),
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1.0),
                              borderSide: const BorderSide(
                                color: Color(0xFFD1E2DB),
                                width: 2.0,
                              ),
                            ),
                            floatingLabelStyle:
                                const TextStyle(color: Color(0xFF307A59)),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        _pickupFocusNode.hasFocus &&
                                _pickupSuggestions.isNotEmpty
                            ? Container(
                                height: 200.0,
                                child: ListView.builder(
                                  itemCount: _pickupSuggestions.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(_pickupSuggestions[index]),
                                      onTap: () {
                                        setState(() {
                                          _pickupController.text =
                                              _pickupSuggestions[index];
                                          _pickupSuggestions.clear();
                                          _panelController
                                              .close(); // Close the panel after selection
                                        });
                                      },
                                    );
                                  },
                                ),
                              )
                            : Container(),
                        const SizedBox(height: 8.0),
                        TextField(
                          controller: _destinationController,
                          cursorColor: const Color(0xFF307A59),
                          decoration: InputDecoration(
                            focusColor: const Color(0xFFD1E2DB),
                            labelText: 'Destination Address',
                            prefixIcon: Theme(
                              data: ThemeData(
                                iconTheme:
                                    const IconThemeData(color: Colors.grey),
                              ),
                              child: const Icon(Icons.location_on_sharp),
                            ),
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1.0),
                              borderSide: const BorderSide(
                                color: Color(0xFFD1E2DB),
                                width: 2.0,
                              ),
                            ),
                            floatingLabelStyle:
                                const TextStyle(color: Color(0xFF307A59)),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        MyFilledButton(
                            title: 'Confirm Order', onPressed: () {}),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class PlaceDetails {
  final String name;
  final String address;
  final double lat;
  final double lng;

  PlaceDetails(
      {required this.name,
      required this.address,
      required this.lat,
      required this.lng});
}
