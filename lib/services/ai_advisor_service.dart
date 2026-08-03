import '../models/course.dart';

class AIAdvisorService {
  static String getRecommendationResponse(String query, List<Course> availableCourses, double? cgpa) {
    final cleanQuery = query.toLowerCase().trim();
    
    if (cleanQuery.contains('python') || cleanQuery.contains('programming') || cleanQuery.contains('code') || cleanQuery.contains('tech')) {
      return '🤖 **AI Advisor Recommendation**:\n\nBased on your interest in technology, I strongly recommend **NME-CSE-101: Python Programming for Data Analysis** by Dr. R. Ramanathan. It offers 3 Credits and practical hands-on data visualization!';
    }
    
    if (cleanQuery.contains('tamil') || cleanQuery.contains('தமிழ்') || cleanQuery.contains('culture') || cleanQuery.contains('art')) {
      return '🤖 **AI Advisor Recommendation**:\n\nFor cultural heritage and classical literature, **NME-TAM-101: Applied Tamil Literature & Folk Art Heritage** is highly rated (4.9⭐). Venue: Tamil Sangam Hall.';
    }

    if (cleanQuery.contains('money') || cleanQuery.contains('finance') || cleanQuery.contains('stock') || cleanQuery.contains('investment') || cleanQuery.contains('bank')) {
      return '🤖 **AI Advisor Recommendation**:\n\nTo build long-term wealth strategies, enroll in **NME-COM-105: Financial Literacy & Mutual Fund Investment**. It fits perfectly into Tue/Thu schedule!';
    }

    if (cleanQuery.contains('marketing') || cleanQuery.contains('social media') || cleanQuery.contains('business')) {
      return '🤖 **AI Advisor Recommendation**:\n\n**NME-MGT-201: Digital Marketing & Social Media Strategy** is top choice. Note: Seats are currently filled, but you can join the auto-waitlist!';
    }

    if (cleanQuery.contains('security') || cleanQuery.contains('cyber') || cleanQuery.contains('privacy')) {
      return '🤖 **AI Advisor Recommendation**:\n\nCheck out **NME-CSE-102: Cyber Security & Personal Privacy**! Only a few seats left (Amber indicator).';
    }

    if (cgpa != null && cgpa >= 8.5) {
      return '🤖 **AI Advisor Recommendation** (Honors CGPA ${cgpa.toStringAsFixed(2)}):\n\nWith your impressive academic score, you qualify for high-credit electives like **Python Programming (NME-CSE-101)** or **Financial Literacy (NME-COM-105)**. Both will enhance your honors transcript!';
    }

    return '🤖 **Alagappa AI Advisor**:\n\nI recommend exploring **NME-CSE-101 (Python)** or **NME-COM-105 (Financial Literacy)** for high skill value this 3rd semester!';
  }
}
