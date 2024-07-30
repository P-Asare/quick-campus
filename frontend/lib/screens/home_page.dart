// homepage

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickcampus/widgets/filled_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller = Completer();
  TextEditingController _pickupController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(5.7630902491463365, -0.2236314561684989),
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        GoogleMap(
          initialCameraPosition: _initialPosition,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),

        // Input
        SlidingUpPanel(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
          maxHeight: 245,
          minHeight: 50,
          panel: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 15.0),
                  // const Icon(
                  //   Icons.drag_handle,
                  //   color: Color(0xFF307A59),
                  // ),
                  Container(
                    width: 40.0,
                    height: 6.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(2.0)),
                    ),
                  ),

                  // spacing
                  const SizedBox(height: 5.0),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // pickup address
                        TextField(
                          controller: _pickupController,
                          cursorColor: const Color(0xFF307A59),
                          decoration: InputDecoration(
                            focusColor: const Color(0xFFD1E2DB),
                            labelText: 'Pickup Address',
                            prefixIcon: Theme(
                              data: ThemeData(
                                iconTheme: const IconThemeData(
                                    color: Colors.grey), // Set icon color here
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

                        // spacing
                        const SizedBox(height: 8.0),

                        // destination address
                        TextField(
                          controller: _destinationController,
                          cursorColor: const Color(0xFF307A59),
                          decoration: InputDecoration(
                            focusColor: const Color(0xFFD1E2DB),
                            labelText: 'Destination Address',
                            prefixIcon: Theme(
                              data: ThemeData(
                                iconTheme: const IconThemeData(
                                    color: Colors.grey), // Set icon color here
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

                        // spacing
                        const SizedBox(height: 16.0),
                        MyFilledButton(title: 'Confirm Order', onPressed: () {})
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
