import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  GameScreenState createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  int timer = 25; // Countdown timer
  late Timer _countdownTimer;
  int userPoints = 0; // Points for User
  bool showResults = false; // Whether to show correct/wrong answer highlights
  bool isFinalScore = false; // Whether to show the final score

  // Sample questions and answers
  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "What are the different types of costs in management accounting?",
      "answers": [
        {"text": "Indirect costs", "isCorrect": true},
        {"text": "Variable costs", "isCorrect": true},
        {"text": "Semi-variable costs", "isCorrect": false},
        {"text": "Performance evaluation", "isCorrect": false},
      ],
    },
    {
      "question": "What is the economic capital of Nigeria?",
      "answers": [
        {"text": "Kano", "isCorrect": false},
        {"text": "Abuja", "isCorrect": false},
        {"text": "Lagos", "isCorrect": true},
        {"text": "Oyo", "isCorrect": false},
      ],
    },
  ];

  int currentQuestionIndex = 0; // Track the current question index
  List<int> selectedAnswers = []; // Indexes of selected answers

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _countdownTimer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (this.timer > 0) {
        setState(() {
          this.timer--;
        });
      } else {
        setState(() {
          showResults = true;
          _calculatePoints();
        });
        _countdownTimer.cancel();
      }
    });
  }

  // void _onContinue() {
  //   if (!showResults) {
  //     setState(() {
  //       showResults = true; // Show correct/wrong answers
  //       _calculatePoints();
  //     });
  //     _countdownTimer.cancel();
  //   } else {
  //     // Navigate to the next screen
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => MatchPairing(),
  //       ),
  //     );
  //   }
  // }

  void _calculatePoints() {
    int correctAnswers = 0;
    int incorrectAnswers = 0;

    for (int index in selectedAnswers) {
      if (questions[currentQuestionIndex]['answers'][index]['isCorrect']) {
        correctAnswers++;
      } else {
        incorrectAnswers++;
      }
    }

    setState(() {
      userPoints += (correctAnswers * 2) -
          incorrectAnswers; // +2 for correct, -1 for wrong
    });
  }

  void _onContinue() {
    if (!showResults) {
      // Update points and show results
      setState(() {
        showResults = true; // Show correct/wrong answers
        _calculatePoints(); // Compute points
      });
      _countdownTimer.cancel();
    } else if (currentQuestionIndex < questions.length - 1) {
      // Move to the next question
      setState(() {
        currentQuestionIndex++;
        selectedAnswers.clear();
        showResults = false;
        timer = 25;
      });
      _startTimer();
    } else {
      // Show the final score
      setState(() {
        isFinalScore = true;
      });
    }
  }

  void _onAnswerTap(int index) {
    if (showResults || isFinalScore)
      return; // Disable tapping after results are shown or on final score

    setState(() {
      if (selectedAnswers.contains(index)) {
        selectedAnswers.remove(index); // Deselect if already selected
      } else {
        selectedAnswers.add(index); // Select the answer
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Top Section
            Padding(
              padding: EdgeInsets.only(right: 24.w, left: 24.w, top: 48.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildProfile(
                    "Adegoke Simisola",
                    "assets/images/theme1.png",
                    "$userPoints Pts",
                    Colors.purple,
                  ),
                  _buildTimer(),
                  _buildProfile(
                    "Omonigho Precious",
                    "assets/images/theme2.png",
                    "0 Pts",
                    Colors.blue,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),

            // Main Section
            if (!isFinalScore) ...[
              // Question Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    questions[currentQuestionIndex]['question'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // Answer Options
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.h,
                      crossAxisSpacing: 16.w,
                      childAspectRatio: 3 / 2,
                    ),
                    itemCount:
                        questions[currentQuestionIndex]['answers'].length,
                    itemBuilder: (context, index) {
                      final answer =
                          questions[currentQuestionIndex]['answers'][index];
                      return GestureDetector(
                        onTap: () => _onAnswerTap(index),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: showResults
                                ? (answer['isCorrect']
                                    ? Colors.green.withOpacity(0.5)
                                    : Colors.red.withOpacity(0.5))
                                : (selectedAnswers.contains(index)
                                    ? Colors.green.withOpacity(0.5)
                                    : Colors.grey.shade900),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: showResults
                                  ? (answer['isCorrect']
                                      ? Colors.green
                                      : Colors.red)
                                  : (selectedAnswers.contains(index)
                                      ? Colors.green
                                      : Colors.grey.shade900),
                              width: 2.w,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            answer['text'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ] else
              // Final Score Section
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(48.r),
                      topRight: Radius.circular(48.r),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 16.h),
                        child: Text(
                          "Your Final Score",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.yellow,
                            size: 16.sp,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            "$userPoints",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 48.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "Points overall",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),

            if (showResults || selectedAnswers.isNotEmpty || isFinalScore)
              // Continue Button
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                color: Colors.grey.shade900,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isFinalScore
                              ? "Congratulations Buddy! ✌️"
                              : "Keep going Buddy! ✌️",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14.sp,
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/repeatemusic.png',
                              height: 30.h,
                              width: 30.w,
                            ),
                            Image.asset(
                              'assets/images/flag.png',
                              height: 30.h,
                              width: 30.w,
                            ),
                            Image.asset(
                              'assets/images/infocircle.png',
                              height: 30.h,
                              width: 30.w,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        fixedSize: Size(double.maxFinite, 52.h),
                      ),
                      onPressed: _onContinue,
                      child: Text(
                        isFinalScore ? "VIEW LEADERBOARD" : "NEXT",
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
          ],
        ),
      ),
    );
  }

  // Timer Widget
  Widget _buildTimer() {
    final String minutes = (timer ~/ 60).toString().padLeft(2, '0'); // Minutes
    final String seconds = (timer % 60).toString().padLeft(2, '0'); // Seconds

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.orange, width: 2.w),
      ),
      child: Text(
        "$minutes:$seconds", // Format as MM:SS
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Profile Widget
  Widget _buildProfile(
      String name, String image, String points, Color barColor) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30.r,
          backgroundImage: AssetImage(image),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Icon(Icons.circle, color: Colors.yellow, size: 14.sp),
            SizedBox(width: 4.w),
            Text(
              points,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Container(
          width: 50.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: barColor,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ],
    );
  }
}
