import 'package:quickcampus/models/confirmed_request.dart';
import 'package:quickcampus/models/pending_request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestService {
  final String _baseUrl = "http://16.171.150.101/quick-campus/backend";

  Future<List<PendingRequest>> getAllPendingRequests() async {
    final response = await http.get(Uri.parse("$_baseUrl/pending_requests"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        return (data['data'] as List)
            .map((requestJson) => PendingRequest.fromJson(requestJson))
            .toList();
      } else {
        throw Exception('Failed to load pending requests');
      }
    } else {
      throw Exception('Failed to load pending requests');
    }
  }

  // Get requests not taken up by riders yet by a specific user
  Future<List<PendingRequest>> getPendingRequests(int userId) async {
    final response = await http.get(Uri.parse("$_baseUrl/pending_requests/$userId"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        return (data['data'] as List)
            .map((requestJson) => PendingRequest.fromJson(requestJson))
            .toList();
      } else {
        throw Exception('Failed to load pending requests');
      }
    } else {
      throw Exception('Failed to load pending requests');
    }
  }

  //Get requests that have been taken up by riders
  Future<List<ConfirmedRequest>> getConfirmedRequests(int userRole, int userId) async {
    final response = await http.get(Uri.parse("$_baseUrl/requests/$userRole/$userId"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        return (data['data'] as List)
            .map((requestJson) => ConfirmedRequest.fromJson(requestJson))
            .toList();
      } else {
        throw Exception('Failed to load confirmed requests');
      }
    } else {
      throw Exception('Failed to load confirmed requests');
    }
  }

  // Place the pending requests
  Future<PendingRequest> placePendingRequest(int studentId, double latitude, double longitude) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/requests"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'student_id': studentId,
        'dropoff_latitude': latitude,
        'dropoff_longitude': longitude,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        return PendingRequest(
          pendingId: int.parse(data['pending_id']),
          studentId: studentId,
          dropoffLatitude: latitude,
          dropoffLongitude: longitude,
          createdAt: DateTime.now(),
        );
      } else {
        throw Exception('Failed to place request');
      }
    } else {
      throw Exception('Failed to place request');
    }
  }

  // Confirm a pending request
  Future<ConfirmedRequest> confirmPendingRequest(int pendingRequestId, int riderId) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/confirm_requests"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'pending_id': pendingRequestId,
        'rider_id': riderId,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        final requestData = data['data'];
        return ConfirmedRequest(
          requestId: requestData['request_id'],
          studentId: requestData['student_id'],
          riderId: requestData['rider_id'],
          dropoffLatitude: double.parse(requestData['dropoff_latitude']),
          dropoffLongitude: double.parse(requestData['dropoff_longitude']),
          createdAt: DateTime.parse(requestData['created_at']),
          status: requestData['status'],
        );
      } else {
        throw Exception('Failed to confirm request');
      }
    } else {
      throw Exception('Failed to confirm request');
    }
  }
}
