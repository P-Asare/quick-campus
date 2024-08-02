import 'package:flutter/material.dart';
import 'package:quickcampus/models/confirmed_request.dart';
import 'package:quickcampus/models/pending_request.dart';
import 'package:quickcampus/models/user.dart';
import 'package:quickcampus/services/auth_services.dart';
import 'package:quickcampus/services/request_services.dart';

class RequestProvider with ChangeNotifier {
  final RequestService _requestService = RequestService();
  final AuthService _authService = AuthService();

  List<PendingRequest> _pendingRequests = [];
  List<PendingRequest> _userPendingRequests = [];
  List<ConfirmedRequest> _confirmedRequests = [];
  bool _isLoading = false;
  String? _errorMessage;
  Map<int, User> _confirmedRequestStudents = {};

  List<PendingRequest> get pendingRequests => _pendingRequests;
  List<PendingRequest> get userPendingRuests => _userPendingRequests;
  List<ConfirmedRequest> get confirmedRequests => _confirmedRequests;
  Map<int, User> get confirmedRequestStudents => _confirmedRequestStudents;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchAllPendingRequests() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _pendingRequests = await _requestService.getAllPendingRequests();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPendingRequests(int userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _userPendingRequests = await _requestService.getPendingRequests(userId);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchConfirmedRequests(int userRole, int userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _confirmedRequests =
          await _requestService.getConfirmedRequests(userRole, userId);
      
      final userProfiles = await Future.wait(
        _confirmedRequests.map((request) async {
          return await _authService.getProfile(request.studentId);
        }).toList(),
      );

      // Create a map with request_id as key and User as value
     _confirmedRequestStudents = {
        for (var i = 0; i < _confirmedRequests.length; i++)
          _confirmedRequests[i].requestId: userProfiles[i]!
      };

      print("Request id is: ${_confirmedRequests[0].requestId}");
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> placePendingRequest(
      int studentId, double latitude, double longitude) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _requestService.placePendingRequest(studentId, latitude, longitude);
      await fetchPendingRequests(studentId);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> confirmPendingRequest(int pendingRequestId, int riderId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _requestService.confirmPendingRequest(pendingRequestId, riderId);
      await fetchConfirmedRequests(
          1, riderId); // Assuming userRole is 1 for riders
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
