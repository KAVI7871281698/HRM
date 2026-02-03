import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrm/views/home/security.dart';
import 'package:hrm/views/widgets/profile_card.dart';
import '../main_root.dart';
import 'account_setting.dart';
import 'expense.dart';
import 'feedback.dart';
import 'notification_alert.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF26A69A),
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
          'Settings',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xff465583), // Your dark blue background
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Profile Image
                    const CircleAvatar(
                      radius: 34,
                      backgroundImage: AssetImage('assets/profile.png'),
                    ),
                    const SizedBox(width: 16),

                    // Name + ID + View Profile
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name with Edit Icon
                          Row(
                            children: [
                              Text(
                                'Harish',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Edit',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Icon(
                                    Icons.edit_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),

                          Text(
                            '1122334455',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 4),

                          Text(
                            'View Full Profile',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white,
                              // decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 3),

                    Container(
                      margin: EdgeInsets.only(top: 50, right: 80),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xff30AC4B),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Active',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Account Setting Section
              _buildAccountSettingSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountSettingSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 3),
        // Settings Options with Dividers
        _buildSettingOption(
          context,
          "Account Setting",
          "assets/account.png",
          false,
        ),
        const Divider(height: 1, color: Colors.grey),

        _buildSettingOption(
          context,
          "Notification & Alerts",
          "assets/notification.png",
          false,
        ),
        const Divider(height: 1, color: Colors.grey),

        _buildSettingOptionWithToggle(
          context,
          "Allow Location",
          "assets/location.png",
          true,
        ),
        const Divider(height: 1, color: Colors.grey),

        _buildSettingOption(context, "Feedback", "assets/feedback.png", false),
        const Divider(height: 1, color: Colors.grey),

        _buildSettingOption(context, "Expense", "assets/expense.png", false),
        const Divider(height: 1, color: Colors.grey),

        _buildSettingOption(context, "Security", "assets/security.png", false),
        const Divider(height: 1, color: Colors.grey),

        _buildSettingOption(
          context,
          "Logout",
          "assets/logout.png",
          false,
          isLogout: true,
        ),
        const Divider(height: 1, color: Colors.grey),
      ],
    );
  }

  Widget _buildSettingOption(
    BuildContext context,
    String title,
    String iconPath,
    bool isEnabled, {
    bool isLogout = false,
  }) {
    return Container(
      color: Colors.white,
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          child: Center(child: Image.asset(iconPath, width: 24, height: 24)),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isLogout ? Colors.red : Colors.black87,
          ),
        ),
        trailing: isLogout
            ? null
            : const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {
          if (isLogout) {
            _showLogoutConfirmation(context);
          } else if (title == "Expense") {
            // Navigate to Expense Management Screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ExpenseManagementScreen(),
              ),
            );
          } else if (title == "Notification & Alerts") {
            // Navigate to Expense Management Screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationSettingsScreen(),
              ),
            );
          } else if (title == "Account Setting") {
            // Navigate to Expense Management Screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AccountSettingsApp(),
              ),
            );
          }
          else if (title == "Feedback") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FeedbackSupportScreen(),
              ),
            );
          }
          else if (title == "Security") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SecuritySettingsApp(),
              ),
            );
          }
          },
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
      ),
    );
  }

  Widget _buildSettingOptionWithToggle(
    BuildContext context,
    String title,
    String iconPath,
    bool isEnabled,
  ) {
    return Container(
      color: Colors.white,
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          child: Center(child: Image.asset(iconPath, width: 24, height: 24)),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        trailing: Switch(
          value: isEnabled,
          onChanged: (value) {},
          activeColor: const Color(0xff465583),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Are you sure want to Logout?",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // NO BUTTON
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.black54),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "NO",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    // YES BUTTON
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            // Add your logout logic here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff233E94),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "YES",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }}
