import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickcampus/models/confirmed_request.dart';
import 'package:quickcampus/models/user.dart';
import 'package:quickcampus/providers/auth_provider.dart';
import 'package:quickcampus/providers/request_provider.dart';
import 'package:quickcampus/services/maps_services.dart';
import 'package:quickcampus/widgets/order_tile.dart';

class SendingPage extends StatefulWidget {
  const SendingPage({super.key});

  @override
  _SendingPageState createState() => _SendingPageState();
}

class _SendingPageState extends State<SendingPage> {
  User? currentUser;
  final MapsService _mapsService = MapsService();

  @override
  void initState() {
    super.initState();
    // Fetch confirmed requests when the page is initialized
    currentUser = Provider.of<AuthProvider>(context, listen: false).user;
    if (currentUser != null) {
      Provider.of<RequestProvider>(context, listen: false)
          .fetchConfirmedRequests(
              1, currentUser!.userId); // Assuming userRole is 1 for riders
    }
  }

  Future<void> _refreshConfirmedRequests() async {
    if (currentUser != null) {
      await Provider.of<RequestProvider>(context, listen: false)
          .fetchConfirmedRequests(1, currentUser!.userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<RequestProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: requestProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              color: const Color(0xFF307A59),
              onRefresh: _refreshConfirmedRequests,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: requestProvider.confirmedRequests.map((request) {
                      return FutureBuilder(
                        future: _fetchLocationDetails(request),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError || !snapshot.hasData) {
                            return ListTile(
                              title: const Text("Error loading location"),
                              subtitle: Text(snapshot.error.toString()),
                            );
                          }

                          final locations = snapshot.data!;
                          return Column(
                            children: [
                              OrderTile(
                                from: locations['fromName'] ?? 'Unknown',
                                fromAddress:
                                    locations['fromAddress'] ?? 'Unknown',
                                to: locations['toName'] ?? 'Unknown',
                                toAddress: locations['toAddress'] ?? 'Unknown',
                                driver: "Palal",
                                onGoing: (request.status == 'begin'),
                                date: (request.createdAt).toString(),
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
    );
  }

  Future<Map<String, String>> _fetchLocationDetails(
      ConfirmedRequest request) async {
    final fromLocation = await _mapsService.getAddressFromLatLng(
        request.dropoffLatitude, request.dropoffLongitude);
    final toLocation = await _mapsService.getAddressFromLatLng(
        5.7630902491463365, -0.2236314561684989);

    return {
      'fromName': fromLocation?.name ?? 'Unknown',
      'fromAddress': fromLocation?.address ?? 'Unknown',
      'toName': toLocation?.name ?? 'Unknown',
      'toAddress': toLocation?.address ?? 'Unknown',
    };
  }
}
