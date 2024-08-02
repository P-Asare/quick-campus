class ConfirmedRequest {
  final int requestId;
  final int studentId;
  final int riderId;
  final double dropoffLatitude;
  final double dropoffLongitude;
  final DateTime createdAt;
  final String status;

  ConfirmedRequest({
    required this.requestId,
    required this.studentId,
    required this.riderId,
    required this.dropoffLatitude,
    required this.dropoffLongitude,
    required this.createdAt,
    required this.status,
  });

  factory ConfirmedRequest.fromJson(Map<String, dynamic> json) {
    return ConfirmedRequest(
      requestId: json['request_id'],
      studentId: json['student_id'],
      riderId: json['rider_id'],
      dropoffLatitude: double.parse(json['dropoff_latitude']),
      dropoffLongitude: double.parse(json['dropoff_longitude']),
      createdAt: DateTime.parse(json['created_at']),
      status: json['status'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'request_id': requestId,
      'student_id': studentId,
      'rider_id': riderId,
      'dropoff_latitude': dropoffLatitude,
      'dropoff_longitude': dropoffLongitude,
      'created_at': createdAt.year.toString(),
      'status': status,
    };
  }
}
