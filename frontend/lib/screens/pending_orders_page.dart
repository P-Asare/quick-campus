import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickcampus/models/pending_request.dart';
import 'package:quickcampus/models/user.dart';
import 'package:quickcampus/providers/auth_provider.dart';
import 'package:quickcampus/providers/request_provider.dart';
import 'package:quickcampus/services/maps_services.dart';
import 'package:quickcampus/widgets/rider_request_tile.dart';

class PendingOrdersPage extends StatefulWidget {
  const PendingOrdersPage({super.key});

  @override
  State<PendingOrdersPage> createState() => _PendingOrdersPageState();
}

class _PendingOrdersPageState extends State<PendingOrdersPage> {
  final MapsService _mapsService = MapsService();
  User? currentUser;

  @override
  void initState() {
    super.initState();
    // Fetch pending requests made by the current user when the page is initialized
    currentUser = Provider.of<AuthProvider>(context, listen: false).user;
    if (currentUser != null) {
      Provider.of<RequestProvider>(context, listen: false)
          .fetchPendingRequests(currentUser!.userId);
    }
  }

  Future<void> _refreshRequests() async {
    if (currentUser != null) {
      await Provider.of<RequestProvider>(context, listen: false)
          .fetchPendingRequests(currentUser!.userId);
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
              onRefresh: _refreshRequests,
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: requestProvider.userPendingRuests.length,
                itemBuilder: (context, index) {
                  if (requestProvider.userPendingRuests.isEmpty) {
                    return const Center(child: Icon(Icons.pedal_bike));
                  }

                  // Request in specific location
                  final request = requestProvider.userPendingRuests[index];

                  return FutureBuilder(
                    future: _fetchLocationDetails(request),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
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
                          RiderRequestTile(
                            from: locations['fromName'] ?? 'Unknown',
                            fromAddress: locations['fromAddress'] ?? 'Unknown',
                            to: locations['toName'] ?? 'Unknown',
                            toAddress: locations['toAddress'] ?? 'Unknown',
                            hide: true,
                          ),
                          const SizedBox(height: 15),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
    );
  }

  Future<Map<String, String>> _fetchLocationDetails(
      PendingRequest request) async {
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
