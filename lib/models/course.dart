class Course {
  final String id;
  final String code;
  final String title;
  final String description;
  final String departmentId;
  final String departmentName;
  final String facultyId;
  final String facultyName;
  final int credits;
  final int semester;
  final int totalSeats;
  int filledSeats;
  final String venue;
  final String scheduleDays;
  final String scheduleTime;
  final String difficulty;
  final String prerequisites;
  final double rating;
  final String status;

  Course({
    required this.id,
    required this.code,
    required this.title,
    required this.description,
    required this.departmentId,
    required this.departmentName,
    required this.facultyId,
    required this.facultyName,
    required this.credits,
    required this.semester,
    required this.totalSeats,
    required this.filledSeats,
    required this.venue,
    required this.scheduleDays,
    required this.scheduleTime,
    required this.difficulty,
    required this.prerequisites,
    required this.rating,
    required this.status,
  });

  int get availableSeats => totalSeats - filledSeats;
  double get availabilityRatio => totalSeats > 0 ? (availableSeats / totalSeats) : 0.0;

  bool get isFull => filledSeats >= totalSeats;

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] ?? '',
      code: json['code'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      departmentId: json['departmentId'] ?? '',
      departmentName: json['departmentName'] ?? '',
      facultyId: json['facultyId'] ?? '',
      facultyName: json['facultyName'] ?? '',
      credits: json['credits'] ?? 3,
      semester: json['semester'] ?? 3,
      totalSeats: json['totalSeats'] ?? 60,
      filledSeats: json['filledSeats'] ?? 0,
      venue: json['venue'] ?? '',
      scheduleDays: json['scheduleDays'] ?? '',
      scheduleTime: json['scheduleTime'] ?? '',
      difficulty: json['difficulty'] ?? 'Beginner',
      prerequisites: json['prerequisites'] ?? 'None',
      rating: (json['rating'] != null) ? (json['rating'] as num).toDouble() : 4.5,
      status: json['status'] ?? 'APPROVED',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'title': title,
      'description': description,
      'departmentId': departmentId,
      'departmentName': departmentName,
      'facultyId': facultyId,
      'facultyName': facultyName,
      'credits': credits,
      'semester': semester,
      'totalSeats': totalSeats,
      'filledSeats': filledSeats,
      'venue': venue,
      'scheduleDays': scheduleDays,
      'scheduleTime': scheduleTime,
      'difficulty': difficulty,
      'prerequisites': prerequisites,
      'rating': rating,
      'status': status,
    };
  }
}
