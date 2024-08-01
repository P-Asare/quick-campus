import 'package:flutter/material.dart';
import 'package:quickcampus/models/confirmed_request.dart';
import 'package:quickcampus/models/pending_request.dart';
import 'package:quickcampus/services/request_services.dart';

class RequestProvider with ChangeNotifier {
  final RequestService _requestService = RequestService();

  List<PendingRequest> _pendingRequests = [];
  List<PendingRequest> _userPendingRequests = [];
  List<ConfirmedRequest> _confirmedRequests = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<PendingRequest> get pendingRequests => _pendingRequests;
  List<PendingRequest> get userPendingRuests => _userPendingRequests;
  List<ConfirmedRequest> get confirmedRequests => _confirmedRequests;
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
      print(_confirmedRequests);
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
