import 'package:excel_academy/presentation/home/ui/match_pairing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopicOptions extends StatefulWidget {
  const TopicOptions({super.key});

  @override
  State<TopicOptions> createState() => _TopicOptionsState();
}

class _TopicOptionsState extends State<TopicOptions> {
  // List of topics/games
  final List<Map<String, dynamic>> topics = [
    {
      'id': '1',
      'name': 'ICAN',
      'desc': 'Institute Chartered Accountants of Nigeria',
      'logo': 'assets/images/ICAN.png',
      'pre-logo': 'assets/images/icon1.png',
      'color': Colors.blue
    },
    {
      'id': '2',
      'name': 'ACCA',
      'desc': 'Association of Chartered Certified Accountants',
      'logo': 'assets/images/CIS.png',
      'pre-logo': 'assets/images/icon2.png',
      'color': Colors.orange
    },
    {
      'id': '3',
      'name': 'CITN',
      'desc': 'Chartered Institute of Taxation of Nigeria',
      'logo': 'assets/images/CITN.png',
      'pre-logo': 'assets/images/icon3.png',
      'color': Colors.green
    },
    {
      'id': '4',
      'name': 'CIMA',
      'desc': 'Chartered Institute of Management Accountants (CIMA)',
      'logo': 'assets/images/CIMA.png',
      'pre-logo': 'assets/images/icon4.png',
      'color': Colors.purple
    },
    {
      'id': '5',
      'name': 'CIBN',
      'desc': 'Chartered Institute of Bankers of Nigeria',
      'logo': 'assets/images/CIBN.png',
      'pre-logo': 'assets/images/icon2.png',
      'color': Colors.orange
    },
    {
      'id': '6',
      'name': 'ANAN',
      'desc': 'Association of National Accountants of Nigeria',
      'logo': 'assets/images/ANAN.png',
      'pre-logo': 'assets/images/icon1.png',
      'color': Colors.blue
    },
  ];

  // List to hold selected topic IDs
  List<String> selectedTopics = [];

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
                    'assets/images/game_logo.png', // Replace with actual asset
                    height: 100.h,
                    width: 100.w,
                  ),
                  Image.asset(
                    'assets/images/leaderboard.png', // Replace with actual asset
                    height: 100.h,
                    width: 100.w,
                  ),
                ],
              ),
            ),
            //SizedBox(height: 16.h),

            // Topics Grid
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.h,
                    crossAxisSpacing: 16.w,
                    childAspectRatio: 3 / 4,
                  ),
                  itemCount: topics.length,
                  itemBuilder: (context, index) {
                    final topic = topics[index];
                    final isSelected = selectedTopics.contains(topic['id']);
                    return _buildTopicCard(
                      title: topic['name']!,
                      description: topic['desc']!,
                      preLogo: topic['pre-logo']!,
                      logo: topic['logo']!,
                      color: topic['color'],
                      isSelected: isSelected,
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedTopics.remove(topic['id']);
                          } else {
                            selectedTopics.add(topic['id']!);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ),

            // Continue Button
            Padding(
              padding: EdgeInsets.only(bottom: 24.h, top: 24.h),
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
                onPressed: selectedTopics.isEmpty
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MatchPairing()),
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
          ],
        ),
      ),
    );
  }

  // Card Widget for Each Topic
  Widget _buildTopicCard({
    required String title,
    required String description,
    required String preLogo,
    required String logo,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: isSelected ? Colors.orange : Colors.grey,
                width: isSelected ? 3.w : 1.w,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Checkbox
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Topic Title
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.grey.withOpacity(0.5),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Checkbox(
                        value: isSelected,
                        onChanged: (_) => onTap(),
                        checkColor: Colors.white,
                        fillColor: WidgetStatePropertyAll(
                            Colors.grey.withOpacity(0.5)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  // Logos
                  Row(
                    children: [
                      Image.asset(
                        preLogo, // Replace with actual asset
                        height: 30.h,
                        width: 30.w,
                      ),
                      SizedBox(width: 2.h),
                      Image.asset(
                        logo, // Replace with actual asset
                        height: 30.h,
                        width: 30.w,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  // Topic Description
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Color line on the right side
          Positioned(
            right: 0,
            top: 64.h,
            bottom: 0,
            child: Container(
              width: 8.w, // Adjust thickness here
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(8.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
