import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickcampus/models/confirmed_request.dart';
import 'package:quickcampus/providers/auth_provider.dart';
import 'package:quickcampus/providers/request_provider.dart';
import 'package:quickcampus/services/maps_services.dart';
import 'package:quickcampus/widgets/rider_order_tile.dart';
import 'package:intl/intl.dart';

class RiderOrdersPage extends StatefulWidget {
  const RiderOrdersPage({super.key});

  @override
  State<RiderOrdersPage> createState() => _RiderOrdersPageState();
}

class _RiderOrdersPageState extends State<RiderOrdersPage> {
  final MapsService _mapsService = MapsService();

  @override
  void initState() {
    super.initState();
    // Fetch confirmed requests for the current user when the page is initialized
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    Provider.of<RequestProvider>(context, listen: false).fetchConfirmedRequests(
        authProvider.user!.role, authProvider.user!.userId);
  }

  Future<void> _refreshRequests() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await Provider.of<RequestProvider>(context, listen: false)
        .fetchConfirmedRequests(
            authProvider.user!.role, authProvider.user!.userId);
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
          "Requests",
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
              onRefresh: _refreshRequests,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: requestProvider.confirmedRequests.isEmpty
                        ? [
                            const Center(
                                child: Text("No requests found",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey)))
                          ]
                        : requestProvider.confirmedRequests.map((request) {
                            return FutureBuilder<Map<String, String>>(
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
                                    RiderOrderTile(
                                      from: locations['fromName'] ?? 'Unknown',
                                      fromAddress:
                                          locations['fromAddress'] ?? 'Unknown',
                                      to: locations['toName'] ?? 'Unknown',
                                      toAddress:
                                          locations['toAddress'] ?? 'Unknown',
                                      student: "Palal",
                                      date: DateFormat('yyyy-MM-dd')
                                          .format(request.createdAt),
                                    ),
                                    const SizedBox(height: 15),
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
        request.dropoffLatitude, request.dropoffLongitude);

    return {
      'fromName': fromLocation?.name ?? 'Unknown',
      'fromAddress': fromLocation?.address ?? 'Unknown',
      'toName': toLocation?.name ?? 'Unknown',
      'toAddress': toLocation?.address ?? 'Unknown',
    };
  }
}
