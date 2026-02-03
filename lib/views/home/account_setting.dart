import 'package:flutter/material.dart';
import 'package:hrm/views/home/settings.dart';

import '../main_root.dart';

class AccountSettingsApp extends StatelessWidget {
  const AccountSettingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AccountSettingsScreen(),
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.teal,
      ),
    );
  }
}

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsive values
    final size = MediaQuery.of(context).size;
    final double horizontalPadding = size.width * 0.05;

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
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
                  (route) => false,
            );
          },
        ),
        title: const Text(
          "Account Settings",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),

            // Profile Information Title
            const Text(
              "Profile Information",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            // Card
            Card(
              elevation: 0,
              color: Color(0xffFFFFFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: Color(0xffC4C4C4),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Profile Photo
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage(
                            "assets/profile.png",
                          ),
                          backgroundColor: Colors.grey[300],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      "Change Photo",
                      style: TextStyle(
                        color: Color(0xff26A69A),
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Basic Details Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Basic Details",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Edit Profile Clicked"),
                              ),
                            );
                          },
                          icon: Image.asset(
                            "assets/edit.png",
                            width: 20,
                            height: 20,
                          ),
                          label: const Text(
                            "Edit",
                            style: TextStyle(
                              color: Color(0xff19893F),
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Detail Rows
                    _buildDetailRow("Name", "Harish"),
                    _buildDetailRow("Mail Id", "hariharanss@app.in"),
                    _buildDetailRow("Mobile Number", "+91 98765 43210"),
                    _buildDetailRow("Address", "Coimbatore"),

                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),

            SizedBox(height: size.height * 0.1),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xff414141),
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
