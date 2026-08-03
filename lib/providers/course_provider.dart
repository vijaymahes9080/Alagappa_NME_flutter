import 'package:flutter/material.dart';
import '../models/course.dart';
import '../models/registration.dart';
import '../models/announcement.dart';
import '../services/mock_data.dart';

class CourseProvider extends ChangeNotifier {
  List<Course> _courses = [];
  List<Registration> _registrations = [];
  List<Announcement> _announcements = [];
  
  String _searchQuery = '';
  String _selectedDepartmentId = 'ALL';
  int _selectedSemester = 3;

  CourseProvider() {
    _courses = List.from(MockData.initialCourses);
    _registrations = List.from(MockData.initialRegistrations);
    _announcements = List.from(MockData.initialAnnouncements);
  }

  List<Course> get courses => _courses;
  List<Registration> get registrations => _registrations;
  List<Announcement> get announcements => _announcements;

  String get searchQuery => _searchQuery;
  String get selectedDepartmentId => _selectedDepartmentId;
  int get selectedSemester => _selectedSemester;

  List<Course> get filteredCourses {
    return _courses.where((course) {
      final matchesDept = _selectedDepartmentId == 'ALL' || course.departmentId == _selectedDepartmentId;
      final matchesSem = course.semester == _selectedSemester;
      final matchesSearch = _searchQuery.isEmpty ||
          course.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          course.code.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          course.departmentName.toLowerCase().contains(_searchQuery.toLowerCase());

      return matchesDept && matchesSem && matchesSearch;
    }).toList();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSelectedDepartment(String deptId) {
    _selectedDepartmentId = deptId;
    notifyListeners();
  }

  void setSelectedSemester(int sem) {
    _selectedSemester = sem;
    notifyListeners();
  }

  bool isStudentRegistered(String studentId, String courseId) {
    return _registrations.any((r) => r.studentId == studentId && r.courseId == courseId && r.status == 'CONFIRMED');
  }

  bool isStudentWaitlisted(String studentId, String courseId) {
    return _registrations.any((r) => r.studentId == studentId && r.courseId == courseId && r.status == 'WAITLISTED');
  }

  Registration? getStudentRegistration(String studentId) {
    try {
      return _registrations.firstWhere((r) => r.studentId == studentId);
    } catch (_) {
      return null;
    }
  }

  // Registration & Waitlist Logic
  String registerCourse(String studentId, Course course) {
    if (isStudentRegistered(studentId, course.id)) {
      return 'ALREADY_REGISTERED';
    }

    // Timetable Conflict Check
    final existingReg = getStudentRegistration(studentId);
    if (existingReg != null && existingReg.status == 'CONFIRMED') {
      final existingCourse = _courses.firstWhere((c) => c.id == existingReg.courseId);
      if (existingCourse.scheduleDays == course.scheduleDays && existingCourse.scheduleTime == course.scheduleTime) {
        return 'TIMETABLE_CONFLICT';
      }
    }

    if (course.isFull) {
      // Add to waitlist
      final newWaitlistReg = Registration(
        id: 'reg-${DateTime.now().millisecondsSinceEpoch}',
        registrationNo: 'NME-WL-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
        studentId: studentId,
        courseId: course.id,
        status: 'WAITLISTED',
        registeredAt: DateTime.now().toIso8601String(),
        qrCodeUrl: 'https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=NME-WL-WAITLIST',
      );
      _registrations.add(newWaitlistReg);
      notifyListeners();
      return 'WAITLISTED';
    } else {
      // Confirm registration & update seat count
      course.filledSeats += 1;
      final newReg = Registration(
        id: 'reg-${DateTime.now().millisecondsSinceEpoch}',
        registrationNo: 'NME-2026-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
        studentId: studentId,
        courseId: course.id,
        status: 'CONFIRMED',
        registeredAt: DateTime.now().toIso8601String(),
        qrCodeUrl: 'https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=NME-2026-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      );
      _registrations.add(newReg);
      notifyListeners();
      return 'SUCCESS';
    }
  }

  // Add course (Dept Admin feature)
  void addCourse(Course course) {
    _courses.add(course);
    notifyListeners();
  }

  // Add announcement (Super Admin feature)
  void addAnnouncement(String title, String content, String sender) {
    _announcements.insert(
      0,
      Announcement(
        id: 'ann-${DateTime.now().millisecondsSinceEpoch}',
        title: title,
        content: content,
        sender: sender,
        timestamp: 'Just now',
        category: 'IMPORTANT',
      ),
    );
    notifyListeners();
  }

  // Analytics helper stats
  int get totalSeats => _courses.fold(0, (sum, c) => sum + c.totalSeats);
  int get totalFilledSeats => _courses.fold(0, (sum, c) => sum + c.filledSeats);
  double get overallFillPercentage => totalSeats > 0 ? (totalFilledSeats / totalSeats * 100) : 0.0;
}
