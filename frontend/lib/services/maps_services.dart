import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:quickcampus/models/location.dart';

class MapsService {
  final String apiKey = "AIzaSyDrk905BDTiFuJhQxtfXdKUPTSDPgpiSrE";
  final String tokenForSession = "37465";

  Future<List<MyLocation>> fetchSuggestions(String input) async {
    String groundUrl =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request =
        '$groundUrl?input=$input&key=$apiKey&sessiontoken=$tokenForSession';

    var response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      List<MyLocation> locations = (json['predictions'] as List)
          .map<MyLocation>((prediction) => MyLocation(
                name: prediction['description'] as String,
                placeId: prediction['place_id'] as String,
              ))
          .toList();
      return locations;
    } else {
      throw Exception('Failed to load suggestions');
    }
  }

  Future<MyLocation?> getAddressFromLatLng(double lat, double long) async {
    try {
      List<Placemark> placemark = await placemarkFromCoordinates(lat, long);

      return MyLocation(
        name: placemark.first.locality!,
        address: placemark.reversed.last.street!,
        lat: lat,
        lng: long,
      );
    } catch (e) {
      print('Error getting address from location: $e');
    }

    return null;
  }

  Future<MyLocation?> getLatLngFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        return MyLocation(
          name: address,
          lat: location.latitude,
          lng: location.longitude,
        );
      }
    } catch (e) {
      print('Error getting location from address: $e');
    }
    return null;
  }

  Future<LatLng> getLatLngFromPlaceId(String placeId) async {
    String placeDetailsUrl =
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=$apiKey';

    var response = await http.get(Uri.parse(placeDetailsUrl));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var location = json['result']['geometry']['location'];
      return LatLng(location['lat'], location['lng']);
    } else {
      throw Exception('Failed to load place details');
    }
  }
}
