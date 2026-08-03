enum UserRole {
  SUPER_ADMIN,
  DEPT_ADMIN,
  FACULTY,
  STUDENT,
}

class User {
  final String id;
  final String email;
  final String name;
  final UserRole role;
  final String departmentId;
  final String? registerNumber;
  final String phone;
  final double? cgpa;
  final String avatar;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.departmentId,
    this.registerNumber,
    required this.phone,
    this.cgpa,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      role: _parseRole(json['role']),
      departmentId: json['departmentId'] ?? '',
      registerNumber: json['registerNumber'],
      phone: json['phone'] ?? '',
      cgpa: json['cgpa'] != null ? (json['cgpa'] as num).toDouble() : null,
      avatar: json['avatar'] ?? 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=250&q=80',
    );
  }

  static UserRole _parseRole(String? roleStr) {
    switch (roleStr) {
      case 'SUPER_ADMIN':
        return UserRole.SUPER_ADMIN;
      case 'DEPT_ADMIN':
        return UserRole.DEPT_ADMIN;
      case 'FACULTY':
        return UserRole.FACULTY;
      case 'STUDENT':
      default:
        return UserRole.STUDENT;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role.name,
      'departmentId': departmentId,
      'registerNumber': registerNumber,
      'phone': phone,
      'cgpa': cgpa,
      'avatar': avatar,
    };
  }
}
