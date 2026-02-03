import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'weekly_history.dart';
import 'check_in.dart';
import '../main_root.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  AttendanceScreenState createState() => AttendanceScreenState();
}

class AttendanceScreenState extends State<AttendanceScreen> {
  bool breakSwitch = false;
  int bottomNavIndex = 1;
  int selectedTab = 0;
  bool isCheckedIn = true;
  Timer? breakTimer;
  Duration breakDuration = Duration.zero;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    breakTimer?.cancel();
    super.dispose();
  }


  void startBreakTimer() {
    breakTimer?.cancel();
    breakTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        breakDuration += const Duration(seconds: 1);
      });
    });
  }

  void stopBreakTimer() {
    breakTimer?.cancel();
  }

  void _showCheckOutDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Are you sure want to Check Out?",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 24),

                Row(
                  children: [
                    /// NO BUTTON
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.black54),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          "NO",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);

                          setState(() {
                            isCheckedIn = false;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Checked out successfully"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF26A69A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                        ),
                        child: Text(
                          "YES",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
  BoxDecoration cardDecoration() {
    return BoxDecoration(
      color: Color(0xffEFEFEF),
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 12,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final Color teal = const Color(0xFF00A79D);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00A79D),
        foregroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainRoot()),
                  (route) => false,
            );
          },
        ),
        title: Text(
          'Attendance',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              timeTrackingCard(w, h),

              SizedBox(height: h * 0.02),
              todayWorkProgressCard(w, h),

              SizedBox(height: h * 0.015),
              attendanceProgressCard(w, h, teal),

              SizedBox(height: h * 0.02),
            ],
          ),
        ),
      ),
    );
  }
  Widget todayWorkProgressCard(double w, double h) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: w * 0.04,
        vertical: h * 0.018,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffF1F1F1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xffE3F2FD),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.access_time,
                  color: Color(0xff2196F3),
                  size: 26,
                ),
              ),

              SizedBox(width: w * 0.03),

              const Text(
                "Today Work Progress Report",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),


          const Icon(
            Icons.trending_up_outlined,
            size: 22,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  Widget timeTrackingCard(double w, double h) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset("assets/time.png", width: 26, height: 26),
            SizedBox(width: w * 0.02),
            const Text("Time Tracking",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
          ],
        ),
        SizedBox(height: h * 0.02),

        if (!isCheckedIn)
          checkInOutButton(
            label: "Attendance In",
            color: Colors.green,
            borderColor: Colors.green.shade200,
            icon: Icons.login,
            w: w,
            h: h,
            onTap: () async {
              final result = await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  builder: (_) => const CheckInVerificationScreen(),
                ),
              );

              if (result == true) {
                setState(() {
                  isCheckedIn = true;
                });

                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(
                //     content: Text("Checked in successfully"),
                //     backgroundColor: Colors.green,
                //   ),
                // );
              }
            },
          ),

        if (isCheckedIn)
          checkInOutButton(
            label: "Attendance Out",
            color: Colors.red,
            borderColor: Colors.red.shade200,
            icon: Icons.logout,
            w: w,
            h: h,
            onTap:_showCheckOutDialog,
          ),


        SizedBox(height: h * 0.014),

        // checkInOutButton(
        //   label: "Attendance Out",
        //   color: Colors.red,
        //   borderColor: Colors.red.shade200,
        //   icon: Icons.login,
        //   w: w,
        //   h: h,
        //   onTap: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => CheckInVerificationScreen(),
        //       ),
        //     );
        //   },
        // ),
        // SizedBox(height: h * 0.018),

        breakButton(w, h),

        SizedBox(height: h * 0.02),

        Center(
          child: const Text(
            "Make sure your location and camera \n  permissions are enabled",
            style: TextStyle(color: Colors.grey, fontSize: 15,fontWeight: FontWeight.w500),
          ),
        ),

        SizedBox(height: h * 0.02),

        greetingCard(w, h),
      ],
    );
  }
  Widget activityCard(
      double w, double h, {
        required String day,
        required String time,
        required String status,
        required String duration,
        required Color statusColor,
      }) {
    return Container(
      padding: EdgeInsets.all(w * 0.04),
      decoration: cardDecoration(),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(day,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700)),
                SizedBox(height: h * 0.004),
                Text(time,
                    style: TextStyle(
                        color: Colors.grey.shade700, fontSize: 13)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: w * 0.03, vertical: h * 0.004),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: statusColor.withOpacity(0.3)),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: h * 0.004),
              Text(duration,
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }


  Widget checkInOutButton({
    required String label,
    required Color color,
    required Color borderColor,
    required IconData icon,
    required double w,
    required double h,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: color,
          padding: EdgeInsets.symmetric(vertical: h * 0.010),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: borderColor, width: 1),
          ),
        ),
        onPressed: onTap,
        child: Row(
          children: [
            Icon(icon, size: h * 0.028, color: color),
            SizedBox(width: w * 0.03),
            Text(label,
                style:
                const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
          ],
        ),
      ),
    );
  }

  Widget breakButton(double w, double h) {
    return SizedBox(
      height: h * 0.058,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color(0xff727272),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          setState(() {
            breakSwitch = !breakSwitch;

            if (breakSwitch) {
              startBreakTimer();
            } else {
              stopBreakTimer();
            }
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.coffee_outlined, color: Colors.white),
                const SizedBox(width: 10),
                Text(
                  "Break In (${formatDuration(breakDuration)})",
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            Switch(
              value: breakSwitch,
              activeColor: Color(0xffD9D9D9),
              activeTrackColor: Color(0xff1B2C61),
              inactiveThumbColor: Color(0xffD9D9D9),
              inactiveTrackColor: Colors.grey.shade500,
              onChanged: (value) {
                setState(() {
                  breakSwitch = value;

                  if (breakSwitch) {
                    startBreakTimer();
                  } else {
                    stopBreakTimer();
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoSmallCard(
      double w,
      double h, {
        required IconData icon,
        required String title,
        required String subtitle,
      }) {
    return Container(
      padding: EdgeInsets.all(w * 0.04),
      decoration: cardDecoration(),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(w * 0.03),
            decoration: BoxDecoration(
              color: const Color(0xffE8F0FE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xff1B4EB2)),
          ),
          SizedBox(width: w * 0.04),
          Expanded(
            child: Text(
              "$title\n$subtitle",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          Icon(Icons.trending_up_outlined, size: w * 0.06),
        ],
      ),
    );
  }

  Widget greetingCard(double w, double h) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffEFEFEF),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: EdgeInsets.all(w * 0.04),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: w * 0.08,
                backgroundImage: const AssetImage('assets/profile.png'),
              ),
              SizedBox(width: w * 0.03),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Good Morning, Akhil Mohan!",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Ready to make today productive?",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Day Shift",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),

                        const SizedBox(width: 6),

                        // Checked In text
                        const Text(
                          "Checked In",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: h * 0.02),
          shiftBreakInfo(w, h),
        ],
      ),
    );
  }


  Widget dateBox(double w, double h) {
    return Container(
      padding: EdgeInsets.all(w * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            children: [
              Icon(Icons.calendar_today, size: 18),
              SizedBox(width: 6),
              Text("Current Date",
                  style: TextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ),
          SizedBox(height: 8),
          Text(
            "Thursday,\nNov 20, 2025",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget shiftBreakInfo(double w, double h) {
    return Container(
      padding: EdgeInsets.all(w * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Current Shift",
                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: Colors.black54)),
                SizedBox(height: 4),
                Text("Day Shift",
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 2),
                Text("09:00 - 18:00",
                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: Colors.black54)),
              ],
            ),
          ),
          SizedBox(width: w * 0.10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Break Duration",
                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500, color: Colors.black54)),
                SizedBox(height: 6),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: w * 0.05, vertical: h * 0.01),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "${formatDuration(breakDuration)} / 1 hr",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget attendanceProgressCard(double w, double h, Color teal) {
    return Container(
      padding: EdgeInsets.all(w * 0.04),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Attendance Progress",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          SizedBox(height: h * 0.015),

          // TABS
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              )
            ),


            child: Row(
              children: [
                Expanded(child: tabButton("Weekly", 0)),
                const SizedBox(width: 10),
                Expanded(child: tabButton("Monthly", 1)),
              ],
            ),
          ),

          SizedBox(height: h * 0.02),

          Row(
            children: const [
              Icon(Icons.trending_up_outlined),
              SizedBox(width: 8),
              Text("This Week's Progress",
                  style: TextStyle(fontWeight: FontWeight.w700)),
            ],
          ),


          SizedBox(height: h * 0.02),

          if (selectedTab == 0)
            Row(
              children: [
                Expanded(child: statsBox("Total Hours", "38h 30m",valueColor: Colors.black)),
                SizedBox(width: w * 0.03),
                Expanded(child: statsBox("Overtime", "2h 15m",valueColor: Colors.red)),
              ],
            )
          else
            Column(
              children: [
                Row(
                  children: [
                    Expanded(child: monthlyStatBox("Day Worked", "22")),
                    SizedBox(width: w * 0.03),
                    Expanded(child: monthlyStatBox("Leave Taken", "2", highlight: true)),
                  ],
                ),
                SizedBox(height: h * 0.02),
                Row(
                  children: [
                    Expanded(child: monthlyStatBox("LOP", "2")),
                    SizedBox(width: w * 0.03),
                    Expanded(child: monthlyStatBox("Overtime", "2h 15m", highlight: true)),
                  ],
                ),
              ],
            ),

          SizedBox(height: h * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Attendance Progress",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "4/6 days",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          SizedBox(height: h * 0.01),
          LinearProgressIndicator(
            value: 0.66,
            minHeight: 8,
            color: Colors.black,
            backgroundColor: Colors.grey.shade300,
          ),
          SizedBox(height: h * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "This week",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "80%",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          SizedBox(height: h * 0.02),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: teal,
                padding: EdgeInsets.symmetric(vertical: h * 0.014),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceHistoryScreen()));
              },
              child: const Text("Attendance History",
                  style: TextStyle(fontSize:16,fontWeight:FontWeight.w700,color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget monthlyStatBox(String title, String value, {bool highlight = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xffEFEFEF),width: 2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: highlight ? Colors.deepOrange : Colors.black,
            ),
          ),
        ],
      ),
    );
  }


  Widget tabButton(String text, int index) {
    return GestureDetector(
      onTap: () => setState(() => selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selectedTab == index
              ? const Color(0xff26A69A)
              : const Color(0xffC9C9C9),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: selectedTab == index ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget statsBox(
      String title,
      String value, {
        Color valueColor = Colors.black,
      }) {
    final bool isOvertime = title.toLowerCase().contains("overtime");

    final Color finalColor = isOvertime ? Colors.red : valueColor;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xffEFEFEF), width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 6),

          Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: value.split(' ')[0],
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: finalColor,
                    ),
                  ),
                  if (value.contains(' '))
                    TextSpan(
                      text: " ${value.split(' ')[1]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: finalColor.withOpacity(0.85),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
