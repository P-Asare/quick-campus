import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickcampus/models/location.dart';
import 'package:quickcampus/widgets/delivery_status.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class RiderDeliveringPage extends StatefulWidget {
  final MyLocation destination;

  const RiderDeliveringPage({
    super.key,
    required this.destination,
  });

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(5.7630902491463365, -0.2236314561684989),
    zoom: 14,
  );

  @override
  State<RiderDeliveringPage> createState() => _RiderDeliveringPageState();
}

class _RiderDeliveringPageState extends State<RiderDeliveringPage> {
  final Completer<GoogleMapController> _controller = Completer();
  final PanelController _panelController = PanelController();
  List<Marker> myMarker = [];
  List<Marker> markerList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _panelController.open();
    });
    _initialiseMarkerList();
    myMarker.addAll(markerList);
  }

  // initialise markers
  void _initialiseMarkerList() {
    setState(() {
      markerList = [
        const Marker(
          markerId: MarkerId('home'),
          position: LatLng(5.7630902491463365, -0.2236314561684989),
          infoWindow: InfoWindow(title: "The hill"),
        ),
        Marker(
            markerId: MarkerId(widget.destination.name),
            position: LatLng(widget.destination.lat!, widget.destination.lng!),
            infoWindow: InfoWindow(title: widget.destination.name))
      ];
    });
  }

  // Go to previous page
  void _goBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: RiderDeliveringPage._initialPosition,
              mapType: MapType.normal,
              markers: Set<Marker>.of(myMarker),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),

            // Back button
            Positioned(
              top: 20,
              left: 10,
              child: GestureDetector(
                onTap: () => _goBack(context),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(child: Icon(Icons.arrow_back_rounded)),
                ),
              ),
            ),

            // panel
            SlidingUpPanel(
              controller: _panelController,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20.0)),
              minHeight: 50,
              maxHeight: 430,
              panel: Center(
                  child: Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      width: 50,
                      height: 4,
                      decoration: const BoxDecoration(
                          color: Color(0xFF307A59),
                          borderRadius: BorderRadius.all(Radius.circular(2.0))),
                    ),

                    // spacing
                    const SizedBox(height: 10.0),

                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                          color: Color.fromARGB(255, 209, 207, 207),
                          width: 0.5,
                        )),
                      ),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage("assets/images/car.png"),
                          radius: 25,
                        ),
                        title: const Text(
                          "Jimmy Doer",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: const Text(
                          "Driver",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Container(
                          width: 49,
                          height: 49,
                          decoration: const BoxDecoration(
                            color: Color(0xFFA8D0A7),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.phone,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),

                    // spacing
                    const SizedBox(
                      height: 20,
                    ),

                    // delivery status
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Statuses
                        Text(
                          "Delivery Status",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        DeliveryStatus(
                          status: "Picked",
                          enabler: "Jimmy Doer",
                          timeStamp: "8:28",
                          complete: true,
                        ),
                        DeliveryStatus(
                          status: "Travelling",
                          enabler: "Jimmy Doer",
                          timeStamp: "8:28",
                          complete: true,
                        ),
                        DeliveryStatus(
                          status: "Delivered",
                          enabler: "Jimmy Doer",
                          timeStamp: "8:28",
                          complete: false,
                        ),
                        DeliveryStatus(
                          status: "Confirmed",
                          enabler: "You",
                          timeStamp: "8:28",
                          complete: false,
                        )
                      ],
                    )
                  ],
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
