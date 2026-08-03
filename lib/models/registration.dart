class Registration {
  final String id;
  final String registrationNo;
  final String studentId;
  final String courseId;
  final String status; // CONFIRMED, WAITLISTED
  final String registeredAt;
  final String qrCodeUrl;

  Registration({
    required this.id,
    required this.registrationNo,
    required this.studentId,
    required this.courseId,
    required this.status,
    required this.registeredAt,
    required this.qrCodeUrl,
  });

  factory Registration.fromJson(Map<String, dynamic> json) {
    return Registration(
      id: json['id'] ?? '',
      registrationNo: json['registrationNo'] ?? '',
      studentId: json['studentId'] ?? '',
      courseId: json['courseId'] ?? '',
      status: json['status'] ?? 'CONFIRMED',
      registeredAt: json['registeredAt'] ?? DateTime.now().toIso8601String(),
      qrCodeUrl: json['qrCodeUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'registrationNo': registrationNo,
      'studentId': studentId,
      'courseId': courseId,
      'status': status,
      'registeredAt': registeredAt,
      'qrCodeUrl': qrCodeUrl,
    };
  }
}
