import 'package:excel_academy/presentation/home/ui/game_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MatchPairing extends StatelessWidget {
  const MatchPairing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              children: [
                // Top Section
                Row(
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
                SizedBox(height: 24.h),

                // Match Pairing Section
                Column(
                  children: [
                    // User Profile
                    _buildProfileCard(
                      name: 'Adegoke Simisola',
                      points: '1,162 Pts',
                      profileImage: 'assets/images/theme1.png',
                      barColor: Colors.purple,
                    ),
                    SizedBox(height: 24.h),
                    // VS Divider
                    Image.asset(
                      'assets/images/vs.png',
                      height: 150.h, // Adjust for smaller screens
                      width: 150.w,
                    ),
                    SizedBox(height: 24.h),
                    // Opponent Profile
                    _buildProfileCard(
                      name: 'Omonigho Precious',
                      points: '10,233 Pts',
                      profileImage: 'assets/images/theme2.png',
                      barColor: Colors.pink,
                    ),
                  ],
                ),
                SizedBox(height: 56.h),

                // Start Game Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    fixedSize: Size(300.w, 52.h),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GameScreen()),
                    );
                  },
                  child: Text(
                    'START GAME',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Profile Card Widget
  Widget _buildProfileCard({
    required String name,
    required String points,
    required String profileImage,
    required Color barColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Profile Image
        CircleAvatar(
          radius: 40.r,
          backgroundImage: AssetImage(profileImage),
        ),
        SizedBox(width: 8.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Name
            Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            // Points
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.circle,
                  color: Colors.yellow,
                  size: 16.sp,
                ),
                SizedBox(width: 4.w),
                Text(
                  points,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            // Progress Bar
            Container(
              width: 100.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: barColor,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
