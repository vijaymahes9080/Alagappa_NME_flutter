import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/course.dart';

class SeatBadge extends StatelessWidget {
  final Course course;

  const SeatBadge({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    Color badgeColor;
    String statusText;
    IconData iconData;

    final ratio = course.availabilityRatio;

    if (course.isFull) {
      badgeColor = AppColors.seatRed;
      statusText = 'FULL (Waitlist)';
      iconData = Icons.warning_amber_rounded;
    } else if (ratio <= 0.20) {
      badgeColor = AppColors.seatAmber;
      statusText = '${course.availableSeats} Seats Left';
      iconData = Icons.access_time_filled_rounded;
    } else {
      badgeColor = AppColors.seatGreen;
      statusText = '${course.availableSeats}/${course.totalSeats} Seats';
      iconData = Icons.check_circle_rounded;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: badgeColor, width: 1.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData, size: 14, color: badgeColor),
          const SizedBox(width: 5),
          Text(
            statusText,
            style: TextStyle(
              color: badgeColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
