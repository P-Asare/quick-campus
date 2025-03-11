class PendingRequest {
  final int pendingId;
  final int studentId;
  final double dropoffLatitude;
  final double dropoffLongitude;
  final DateTime createdAt;

  PendingRequest({
    required this.pendingId,
    required this.studentId,
    required this.dropoffLatitude,
    required this.dropoffLongitude,
    required this.createdAt,
  });

  factory PendingRequest.fromJson(Map<String, dynamic> json) {
    return PendingRequest(
      pendingId: json['pending_id'],
      studentId: json['student_id'],
      dropoffLatitude: double.parse(json['dropoff_latitude']),
      dropoffLongitude: double.parse(json['dropoff_longitude']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pending_id': pendingId,
      'student_id': studentId,
      'dropoff_latitude': dropoffLatitude,
      'dropoff_longitude': dropoffLongitude,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
