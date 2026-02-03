
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrm/views/widgets/profile_card.dart';


class PerformanceScreen extends StatelessWidget {
  const PerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double horizontalPadding = size.width * 0.04;
    final double cardPadding = size.width * 0.05;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF26A69A),
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: Text(
          'Performance',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.calendar_month, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const SizedBox(height: 20),
            _buildSummaryCard(cardPadding),
            const SizedBox(height: 20),
            _buildTaskCompletionCard(cardPadding),
            const SizedBox(height: 20),
            _buildStatisticsCard(cardPadding),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(double padding) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12,width: 2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance Summary',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Per Month Target- October',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 16),

          LinearProgressIndicator(
            value: 0.80,
            backgroundColor: Colors.grey.shade300,
            valueColor:
            const AlwaysStoppedAnimation<Color>(Colors.green),
            minHeight: 10,
            borderRadius: BorderRadius.circular(10),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              const Icon(
                Icons.thumb_up,
                color: Colors.green,
                size: 22,
              ),
              const SizedBox(width: 6),
              Text(
                'Excellent',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
              const Spacer(),
              Text(
                '80% Completed',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildTaskCompletionCard(double padding) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12,width: 2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Task Completion',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Per Day Task-5/11/2025',
            style: GoogleFonts.poppins(fontSize: 15, color: Colors.black,fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),

          LinearProgressIndicator(
            value: 0.60,
            backgroundColor: Colors.grey.shade300,
            valueColor:
            const AlwaysStoppedAnimation<Color>(Colors.orange),
            minHeight: 12,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 12), Row(
            children: [
              Text(
                '60% Progress',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.orange[700],
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    'Pending : 40%',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTaskStatusBox('Completed'),
              _buildTaskStatusBox('60/100',),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTaskStatusBox(String label,) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticsCard(double padding) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12,width: 2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Statistics',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          _buildStatRow('Completed', '60', Colors.green),
          const SizedBox(height: 16),
          _buildStatRow('Pending', '40', Colors.red),
          const SizedBox(height: 12),
          const Divider(
            thickness: 2,
            color: Colors.black12,
          ),
          const SizedBox(height: 12),
          _buildStatRow('Total Task', '100', Colors.blue),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}