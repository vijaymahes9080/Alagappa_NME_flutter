# 🏛️ Alagappa University Real-Time NME Mobile Application (Flutter)

[![Alagappa University](https://img.shields.io/badge/University-Alagappa%20University%2C%20Karaikudi-003366?style=for-the-badge&logo=education)](https://nme.alagappa.ac.in)
[![Flutter Version](https://img.shields.io/badge/Flutter-3.44.8-02569B?style=for-the-badge&logo=flutter)](https://flutter.dev)
[![Dart Version](https://img.shields.io/badge/Dart-3.12.2-0175C2?style=for-the-badge&logo=dart)](https://dart.dev)
[![Status](https://img.shields.io/badge/Status-Production%20Ready-10B981?style=for-the-badge)](https://nme.alagappa.ac.in)
[![License](https://img.shields.io/badge/License-MIT-D4AF37?style=for-the-badge)](LICENSE)
[![Author](https://img.shields.io/badge/Author-Vijay%20Mahes-002244?style=for-the-badge)](mailto:Vijaypradhap2004@gmail.com)

An enterprise-grade cross-platform **Flutter Mobile Application** engineered for **Alagappa University, Karaikudi** to digitize Non-Major Elective (NME) course registration. The app features sub-second live seat tracking, auto-managed waitlisting, timetable conflict detection matrix, classroom attendance QR code scanner, verifiable digital gold certificate badges, floating AI Course Advisor chatbot, and bilingual support (**English & Tamil தமிழ்**).

---

## 🎨 Official Alagappa University Theme & Branding

| Primary Brand Color | Hex Code | Role |
| :--- | :--- | :--- |
| **Royal Academic Blue** | `#003366` | Header backgrounds, primary buttons & navigation branding |
| **Deep University Navy** | `#002244` | Dark mode container fill & card backgrounds |
| **Crimson Maroon** | `#800000` | Credit chips, urgent alerts & department highlights |
| **Warm Gold** | `#D4AF37` | Text highlights, active tabs, seals, certificates & icons |

---

## ⚡ Key Application Features

- **🔴🟡🟢 Real-Time Seat Availability Badges**: Live seat counter with dynamic status indicators:
  - 🟢 **Green (>20%)**: Seats Available
  - 🟡 **Amber (≤20%)**: Few Seats Left
  - 🔴 **Red (Full)**: Auto-Join Waitlist
- **🗣️ AI Voice Search Controller**: Simulated & Web Speech API voice search supporting queries in English and Tamil.
- **📷 Faculty Classroom Attendance QR Scanner**: Built-in camera QR scanner and manual verification pass validator for instructors.
- **📅 Timetable Conflict Checker Matrix**: Visual schedule grid preventing day/time course clashes with student core lectures.
- **💳 Credit Points & Fee Waiver Ledger**: Tracks Govt. of Tamil Nadu tuition fee waiver status and 8.85 CGPA honors qualification.
- **📜 Verified NME Gold Badge Certificate Generator**: Instant verifiable digital completion certificate with official gold seal.
- **🤖 AI Course Advisor Chatbot**: Floating interactive AI chatbot providing personalized course recommendations based on department, interest, and CGPA.
- **🌐 Bilingual Support**: 1-click toggle between **English** and **Tamil (தமிழ்)**.
- **📱 Multi-Role Access**: Super Admin, Department Admin, Faculty, and Student portals with 1-tap demo sign-in.

---

## 📁 Flutter Project Architecture

```
alagappa_nme_flutter/
├── lib/
│   ├── main.dart                          # App Entrypoint, Theme & Role-Based Navigator
│   ├── constants/
│   │   ├── app_colors.dart                # Official Alagappa color palette
│   │   └── app_strings.dart               # English & Tamil translations dictionary
│   ├── models/
│   │   ├── user.dart                      # User model (SUPER_ADMIN, DEPT_ADMIN, FACULTY, STUDENT)
│   │   ├── course.dart                    # Course model with seat availability tracking
│   │   ├── registration.dart              # Registration & auto-waitlist model
│   │   └── announcement.dart              # Broadcast notification model
│   ├── services/
│   │   ├── mock_data.dart                 # Offline mock data store & backend fallback
│   │   └── ai_advisor_service.dart        # AI course recommendation logic
│   ├── providers/
│   │   ├── auth_provider.dart             # Role authentication & 1-tap demo user switcher
│   │   ├── course_provider.dart           # Reactive course catalog & seat management
│   │   ├── language_provider.dart         # Locale state provider (English/Tamil)
│   │   └── theme_provider.dart            # Light/Dark theme mode state
│   ├── widgets/
│   │   ├── seat_badge.dart                # Real-time Green/Amber/Red seat indicator chip
│   │   ├── course_card.dart               # Course card with instant registration button
│   │   ├── qr_scanner_dialog.dart         # Faculty classroom attendance scanner
│   │   ├── registration_slip_modal.dart   # QR Registration Pass slip modal
│   │   ├── certificate_modal.dart         # Gold badge digital completion certificate
│   │   ├── ai_advisor_chat.dart           # Floating AI chatbot drawer sheet
│   │   └── voice_search_bar.dart          # Voice search bar controller
│   └── screens/
│       ├── login_screen.dart              # Multi-role login screen with 1-tap demo credentials
│       ├── student/
│       │   ├── student_dashboard_screen.dart # Main student portal hub
│       │   ├── course_catalog_screen.dart    # Search & filterable course catalog
│       │   ├── timetable_screen.dart         # Conflict checker matrix
│       │   └── credit_ledger_screen.dart     # Fee waiver status & earned badges
│       ├── faculty/
│       │   └── faculty_dashboard_screen.dart # QR scanner, student roster, rubric builder
│       ├── dept_admin/
│       │   └── dept_admin_dashboard_screen.dart # Course creator & seat fill analytics
│       └── super_admin/
│           └── super_admin_dashboard_screen.dart # Health monitor & broadcast publisher
├── pubspec.yaml                           # Flutter dependencies & metadata
└── README.md                              # Master Flutter mobile documentation
```

---

## 🔐 Demo User Credentials & Role Security

The login screen features 1-tap demo buttons for instant previewing of all 4 roles:

| Role | Username / Email | Password | Accessible Dashboard |
| :--- | :--- | :--- | :--- |
| **Super Admin** | `admin@alagappa.ac.in` | `admin123` | University Analytics, Health Monitor & Broadcasts |
| **Department Admin** | `cs_admin@alagappa.ac.in` | `dept123` | Department Course Creator & Fill Ratios |
| **Faculty Instructor** | `ramanathan@alagappa.ac.in` | `faculty123` | Classroom QR Scanner, Rosters & Rubric Builder |
| **Student** | `student@alagappa.ac.in` | `student123` | Course Discovery, Digital QR Pass, Timetable & AI Advisor |

---

## 🚀 Quick Start Guide

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.22.0 or higher)
- [Dart SDK](https://dart.dev/get-dart) (v3.4.0 or higher)

### Installation Steps

1. **Navigate to the repository directory**:
   ```bash
   cd alagappa_nme_flutter
   ```

2. **Install Flutter package dependencies**:
   ```bash
   flutter pub get
   ```

3. **Verify project code quality**:
   ```bash
   flutter analyze
   ```

4. **Run application on target device / desktop**:
   - **Windows Desktop**:
     ```bash
     flutter run -d windows
     ```
   - **Chrome Web**:
     ```bash
     flutter run -d chrome
     ```
   - **Mobile Emulator / Device**:
     ```bash
     flutter run
     ```

---

## 📜 License & Copyright

Distributed under the [MIT License](LICENSE).  
Copyright © 2026 Vijay Mahes / Alagappa University, Karaikudi. All rights reserved.
