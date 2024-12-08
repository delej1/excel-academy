import 'package:excel_academy/presentation/home/ui/topic_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameOptions extends StatefulWidget {
  const GameOptions({super.key});

  @override
  State<GameOptions> createState() => _GameOptionsState();
}

class _GameOptionsState extends State<GameOptions> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Top Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/game_logo.png',
                    height: 100.h,
                    width: 100.w,
                  ),
                  Image.asset(
                    'assets/images/leaderboard.png',
                    height: 100.h,
                    width: 100.w,
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),

            // Options
            Expanded(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                children: [
                  _buildOptionCard(
                    title: 'Play with Zaraline (bot)',
                    description:
                        'Quiz with a bot real-time and get scored to beat the highest scores',
                    note:
                        'This is not available at the moment as we are currently fixing it. We will be back shortly',
                    imagePath: 'assets/images/person_image.png',
                    isSelected: selectedOption == 'bot',
                    onTap: () {
                      setState(() {
                        selectedOption = 'bot';
                      });
                    },
                  ),
                  SizedBox(height: 16.h),
                  _buildOptionCard(
                    title: 'Play with someone on the app',
                    description:
                        'Quiz with someone real-time and get scored to beat the highest scores',
                    imagePath: 'assets/images/person_image.png',
                    isSelected: selectedOption == 'user',
                    onTap: () {
                      setState(() {
                        selectedOption = 'user';
                      });
                    },
                  ),
                ],
              ),
            ),

            // Continue Button
            Padding(
              padding: EdgeInsets.only(bottom: 24.h),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color>(
                    (states) {
                      if (states.contains(WidgetState.disabled)) {
                        return Colors.grey.withOpacity(0.5);
                      }
                      return Colors.orange;
                    },
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  fixedSize: WidgetStateProperty.all(Size(300.w, 52.h)),
                ),
                onPressed: selectedOption == null
                    ? null
                    : () {
                        if (selectedOption == 'user') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TopicOptions()),
                          );
                        }
                      },
                child: Text(
                  'CONTINUE',
                  style: TextStyle(
                    color: selectedOption == null
                        ? Colors.white.withOpacity(0.5)
                        : Colors.white,
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Option Card Widget
  Widget _buildOptionCard({
    required String title,
    required String description,
    String? note,
    required String imagePath,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange.withOpacity(0.5) : Colors.black,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.grey,
            width: isSelected ? 3.w : 1.w,
          ),
        ),
        padding: EdgeInsets.all(16.h),
        child: Row(
          children: [
            // Image
            Image.asset(
              'assets/images/theme3.png',
              height: 60.h,
              width: 60.w,
            ),
            SizedBox(width: 16.w),
            // Texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isSelected ? Colors.orange : Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    description,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.orange.withOpacity(0.7)
                          : Colors.white70,
                      fontSize: 14.sp,
                    ),
                  ),
                  if (note != null) ...[
                    SizedBox(height: 8.h),
                    Text(
                      note,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.orange.withOpacity(0.7)
                            : Colors.white38,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
