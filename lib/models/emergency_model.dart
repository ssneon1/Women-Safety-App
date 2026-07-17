class EmergencyModel {
  final String id;
  final String userId;
  final double latitude;
  final double longitude;
  final DateTime timestamp;
  final String status;
  final String emergencyType;

  EmergencyModel({
    required this.id,
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    required this.status,
    required this.emergencyType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp,
      'status': status,
      'emergencyType': emergencyType,
    };
  }

  factory EmergencyModel.fromMap(String id, Map<String, dynamic> map) {
    return EmergencyModel(
      id: id,
      userId: map['userId'] ?? '',
      latitude: map['latitude'] ?? 0.0,
      longitude: map['longitude'] ?? 0.0,
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      status: map['status'] ?? 'active',
      emergencyType: map['emergencyType'] ?? 'general',
    );
  }
}