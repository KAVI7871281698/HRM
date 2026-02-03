import 'package:flutter/material.dart';
import 'package:hrm/views/main_root.dart';
import 'package:intl/intl.dart';


class NotificationApp extends StatelessWidget {
  const NotificationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NotificationScreen(),
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Roboto',
      ),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  // Sample data
  final List<NotificationItem> notifications = const [
    // Today
    NotificationItem(
      title: "Leave Request Approved",
      subtitle: "Your Leave request for Nov 8-9 Has been Approved By HR",
      icon: (Icons.logout),
      iconColor: Color(0xffF87000),
      time: "Today",
    ),
    NotificationItem(
      title: "Performance Target Reached",
      subtitle: "Congrats! You Achieved 100% of Your Month Target",
      icon: Icons.trending_up,
      iconColor: Color(0xff34C759),
      time: "Today",
    ),
    // Yesterday
    NotificationItem(
      title: "Leave Request Approved",
      subtitle: "Your Leave request for Nov 8-9 Has been Approved By HR",
      icon: Icons.logout,
      iconColor: Colors.orange,
      time: "Yesterday",
    ),
    NotificationItem(
      title: "Performance Target Reached",
      subtitle: "Congrats! You Achieved 100% of Your Month Target",
      icon: Icons.trending_up,
      iconColor: Color(0xff34C759),
      time: "Yesterday",
    ),
    NotificationItem(
      title: "Expense Reimbursement Processed",
      subtitle: "Your On duty Expense claim for ₹2500 has been Approved",
      icon: Icons.currency_rupee,
      iconColor: Color(0xffCA0000),
      time: "Yesterday",
    ),
    NotificationItem(
      title: "New Task Assigned",
      subtitle: "A new client meeting Task has been Assigned by your manager",
      icon: Icons.trending_up,
      iconColor: Color(0xff34C759),
      time: "Yesterday",
    ),
    NotificationItem(
      title: "Ticket Raised",
      subtitle: "Your raised ticket has been Resolved",
      icon: Icons.trending_up,
      iconColor: Color(0xff34C759),
      time: "Yesterday",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double horizontalPadding = size.width * 0.05;

    // Group notifications by "Today" and "Yesterday"
    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));
    final Map<String, List<NotificationItem>> grouped = {
      "Today": notifications.where((n) => n.time == "Today").toList(),
      "Yesterday": notifications.where((n) => n.time == "Yesterday").toList(),
    };

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Color(0xff26A69A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainRoot()),
                  (route) => false,
            );
          },
        ),
        title: const Text(
          "Notification",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        actions: const [
          Icon(Icons.more_vert, color: Colors.white),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              // border: Border.all(color: Colors.black),
            ),
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
            child: Row(
              children: [
                const Text(
                  "Latest Notification",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                const Text(
                  "Sort By Date",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Colors.black),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                  },
                  icon: const Icon(Icons.calendar_month, size: 18, weight: 500, color: Colors.white),
                  label: const Text("Pick Date"),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Color(0xff26A69A),
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.teal.shade700),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),


          // Notification List
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 12),
              children: [
                // Today Section
                if (grouped["Today"]!.isNotEmpty) ...[
                  _buildDateHeader("Today"),
                  const SizedBox(height: 8),
                  ...grouped["Today"]!.map((n) => _buildNotificationCard(n)),
                ],

                const SizedBox(height: 20),

                // Yesterday Section
                if (grouped["Yesterday"]!.isNotEmpty) ...[
                  _buildDateHeader("Yesterday"),
                  const SizedBox(height: 8),
                  ...grouped["Yesterday"]!.map((n) => _buildNotificationCard(n)),
                ],

                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildNotificationCard(NotificationItem item) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.black, width: 0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: item.iconColor.withOpacity(0.15),
          child: Icon(item.icon, color: item.iconColor, size: 28),
        ),
        title: Text(
          item.title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            item.subtitle,
            style: const TextStyle(fontSize: 13.5, color: Colors.black, height: 1.4),
          ),
        ),
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final String time; // "Today" or "Yesterday"

  const NotificationItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.time,
  });
}