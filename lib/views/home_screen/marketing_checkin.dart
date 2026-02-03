import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrm/views/widgets/profile_card.dart';

import 'marketing_checkout.dart';

class MarketingScreen extends StatefulWidget {
  const MarketingScreen({super.key});

  @override
  State<MarketingScreen> createState() => _MarketingScreenState();
}

class _MarketingScreenState extends State<MarketingScreen> {

  bool isCheckedIn = false;
  void _showCheckInDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
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
                  "Are you sure want to Check in?",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 24),

                Row(
                  children: [
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
                            isCheckedIn = true;
                          });
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isTablet = width > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF26A69A),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Marketing",
          style: GoogleFonts.poppins(
            fontSize: isTablet ? 22 : 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(isTablet ? 24 : 16),
        child: Column(
          children: [
            if (isCheckedIn)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF9AD9D0),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    "Check in Successfully",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

            SizedBox(height: isTablet ? 30 : 20),

            Row(
              children: [
                Expanded(
                  child: _buildTimeCard(
                    context: context,
                    title: "Check In",
                    time: "00.00.00",
                    bgColor: const Color(0xFF34C759),
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(width: isTablet ? 20 : 12),
                Expanded(
                  child: _buildTimeCard(
                    context: context,
                    title: "Check Out",
                    time: "00.00.00",
                    bgColor: const Color(0xffD9D9D9),
                    textColor: const Color(0xff1B2C61),
                  ),
                ),
              ],
            ),

            SizedBox(height: isTablet ? 30 : 20),
            _buildHistorySection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeCard({
    required BuildContext context,
    required String title,
    required String time,
    required Color bgColor,
    required Color textColor,
  }) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return GestureDetector(
      onTap: title == "Check In"
          ? _showCheckInDialog
          : title == "Check Out"
          ? () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CheckoutScreen(),
          ),
        );
      }
          : null,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 16 : 10,
          vertical: isTablet ? 12 : 6,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: isTablet ? 14 : 16,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            SizedBox(height: isTablet ? 7 : 6),
            Text(
              time,
              style: GoogleFonts.poppins(
                fontSize: isTablet ? 18 : 16,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistorySection(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: isTablet ? 18 : 14),
          child: Text(
            "History",
            style: GoogleFonts.poppins(
              fontSize: isTablet ? 20 : 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        _historyCard(
          context,
          company: "Smart Global Solution",
          time: "10:45AM",
          status: "In Progress",
          statusColor: Colors.redAccent,
        ),

        _historyCard(
          context,
          company: "Smart Global Solution",
          time: "8:00AM – 10:30AM",
          status: "Completed",
          statusColor: const Color(0xff3CA80A),
        ),
      ],
    );
  }

  Widget _historyCard(
      BuildContext context, {
        required String company,
        required String time,
        required String status,
        required Color statusColor,
      }) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isTablet ? 18 : 14),
      margin: EdgeInsets.only(bottom: isTablet ? 18 : 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 3),
            blurRadius: 8,
          ),
        ],
      ),
      child: _buildHistoryItem(
        context: context,
        company: company,
        time: time,
        status: status,
        statusColor: statusColor,
      ),
    );
  }

  Widget _buildHistoryItem({
    required BuildContext context,
    required String company,
    required String time,
    required String status,
    required Color statusColor,
  }) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    String assetPath =
    status == "Completed" ? "assets/completed.png" : "assets/progress.png";

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: isTablet ? 24 : 20,
          height: isTablet ? 24 : 20,
          margin: EdgeInsets.only(top: isTablet ? 4 : 2, right: isTablet ? 16 : 12),
          child: Image.asset(assetPath),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                company,
                style: GoogleFonts.poppins(
                  fontSize: isTablet ? 16 : 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: isTablet ? 6 : 4),
              Text(
                time,
                style: GoogleFonts.poppins(
                  fontSize: isTablet ? 14 : 12,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: isTablet ? 8 : 6),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 12 : 8,
                  vertical: isTablet ? 4 : 2,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: statusColor.withOpacity(0.4)),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.poppins(
                    fontSize: isTablet ? 12 : 10,
                    fontWeight: FontWeight.w500,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
