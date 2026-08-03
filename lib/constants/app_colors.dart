import 'package:flutter/material.dart';

class AppColors {
  // Official Alagappa University Theme Colors
  static const Color royalBlue = Color(0xFF003366);      // Header & Primary Buttons
  static const Color deepNavy = Color(0xFF002244);       // Dark Mode Background & Footers
  static const Color crimsonMaroon = Color(0xFF800000);  // Accent Stripes & Badges
  static const Color warmGold = Color(0xFFD4AF37);       // Text Highlights, Seals & Active Icons
  
  // Seat Indicator Colors
  static const Color seatGreen = Color(0xFF10B981);      // > 20% seats available
  static const Color seatAmber = Color(0xFFF59E0B);      // <= 20% seats remaining
  static const Color seatRed = Color(0xFFEF4444);        // Full / Waitlist only

  // Utility Colors
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color cardLight = Colors.white;
  static const Color textDark = Color(0xFF0F172A);
  static const Color textMuted = Color(0xFF64748B);
  
  static const Color backgroundDark = Color(0xFF0B132B);
  static const Color cardDark = Color(0xFF1C2541);
  static const Color textLight = Color(0xFFF1F5F9);
}
