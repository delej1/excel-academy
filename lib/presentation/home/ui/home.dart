import 'package:excel_academy/presentation/home/ui/game_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int percentage = 1;
  bool showContinueButton = false;

  @override
  void initState() {
    super.initState();
    _startPercentageAnimation();
  }

  void _startPercentageAnimation() async {
    for (int i = 1; i <= 100; i++) {
      await Future.delayed(Duration(milliseconds: 30));
      setState(() {
        percentage = i;
      });
    }
    setState(() {
      showContinueButton = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Leaderboard Section
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 24.h, right: 24.w),
                    child: Image.asset(
                      'assets/images/leaderboard.png',
                      height: 100.h,
                      width: 100.w,
                    ),
                  ),
                ),
                Spacer(),
                // Center Image and Text
                Image.asset(
                  'assets/images/game_logo.png',
                  height: 150.h,
                  width: 150.w,
                ),
                Spacer(),
                // Percentage or Continue Button
                if (!showContinueButton) _buildPercentage(),
                if (showContinueButton) _buildContinueButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPercentage() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: EdgeInsets.only(bottom: 40.h),
        child: Container(
          width: 200.w,
          color: Colors.white,
          padding: EdgeInsets.only(left: 32.w, top: 16.h, bottom: 16.h),
          child: Text(
            '$percentage%',
            style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 40.h),
        child: ElevatedButton(
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
              MaterialPageRoute(builder: (context) => GameOptions()),
            );
          },
          child: Text(
            'CONTINUE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
            ),
          ),
        ),
      ),
    );
  }
}
