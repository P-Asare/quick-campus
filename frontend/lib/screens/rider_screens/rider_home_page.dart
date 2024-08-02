import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickcampus/models/pending_request.dart';
import 'package:quickcampus/models/user.dart';
import 'package:quickcampus/providers/auth_provider.dart';
import 'package:quickcampus/providers/request_provider.dart';
import 'package:quickcampus/services/maps_services.dart';
import 'package:quickcampus/widgets/rider_request_tile.dart';

class RiderHomePage extends StatefulWidget {
  const RiderHomePage({super.key});

  @override
  State<RiderHomePage> createState() => _RiderHomePageState();
}

class _RiderHomePageState extends State<RiderHomePage> {
  final MapsService _mapsService = MapsService();
  User? currentUser;

  @override
  void initState() {
    super.initState();
    // Fetch pending requests when the page is initialized
    Provider.of<RequestProvider>(context, listen: false)
        .fetchAllPendingRequests();

    currentUser = Provider.of<AuthProvider>(context, listen: false).user;
  }

  Future<void> _refreshRequests() async {
    await Provider.of<RequestProvider>(context, listen: false)
        .fetchAllPendingRequests();
  }

  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<RequestProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        title: const Text(
          "Home",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color(0xFFD1E2DB),
            height: 1.0,
          ),
        ),
      ),
      body: requestProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              color: const Color(0xFF307A59),
              onRefresh: _refreshRequests,
              child: requestProvider.pendingRequests.isEmpty
                  ? const Center(
                      child: Text(
                        "No pending requests",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: requestProvider.pendingRequests.length,
                      itemBuilder: (context, index) {
                        // Request in specific location
                        final request = requestProvider.pendingRequests[index];

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
                                GestureDetector(
                                  onTap: () {
                                    print("Accept request");
                                    requestProvider.confirmPendingRequest(
                                        request.pendingId, currentUser!.userId);
                                  },
                                  child: RiderRequestTile(
                                    from: locations['fromName'] ?? 'Unknown',
                                    fromAddress:
                                        locations['fromAddress'] ?? 'Unknown',
                                    to: locations['toName'] ?? 'Unknown',
                                    toAddress:
                                        locations['toAddress'] ?? 'Unknown',
                                    hide: false,
                                  ),
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
