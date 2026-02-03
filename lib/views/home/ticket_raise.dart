import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrm/views/widgets/profile_card.dart';

class TicketRaise extends StatefulWidget {
  const TicketRaise({super.key});

  @override
  State<TicketRaise> createState() => _TicketRaiseState();
}

class _TicketRaiseState extends State<TicketRaise> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _selectedDepartment;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isTablet = width > 600;
    final horizontalPadding = isTablet ? 24.0 : 16.0;

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
          "Ticket Raise",
          style: GoogleFonts.poppins(
            fontSize: isTablet ? 22 : 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // Profile Card
            ProfileInfoCard(
              name: "Harish",
              employeeId: "1023",
              designation: "Supervisor",
              profileImagePath: "assets/profile.png",
            ),

            SizedBox(height: isTablet ? 32 : 24),

            // Subject Field
            _buildLabeledField(
              label: "Subject",
              hint: "Enter ticket subject",
              controller: _subjectController,
              isTablet: isTablet,
            ),

            SizedBox(height: isTablet ? 24 : 20),

            // Department Dropdown
            _buildDropdownField(
              label: "Department",
              hint: "Select Department",
              value: _selectedDepartment,
              isTablet: isTablet,
              items: const [
                'App Developer',
                'Frontend Developer',
                'Backend Developer',
                'UI/UX',
                'Testing',
                'Attendance',
                'HR',
                'Customer Support',
                'Finance',
                'Others',
              ],
              onChanged: (value) {
                setState(() => _selectedDepartment = value);
              },
            ),

            SizedBox(height: isTablet ? 24 : 20),

            // Description
            _buildLabeledField(
              label: "Description",
              hint: "Describe your issue in detail",
              controller: _descriptionController,
              isTablet: isTablet,
              maxLines: 6,
            ),

            SizedBox(height: isTablet ? 100 : 120),

            // Submit Button
            Center(
              child: SizedBox(
                width: 220,
                height: 56,
                child: ElevatedButton(
                  onPressed: _submitTicket,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF26A69A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 6,
                  ),
                  child: Text(
                    "Submit Ticket",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // Reusable Text Field
  Widget _buildLabeledField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool isTablet,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: isTablet ? 17 : 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
              color: Colors.grey.shade500,
              fontSize: isTablet ? 15 : 14,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            contentPadding: EdgeInsets.all(isTablet ? 20 : 16),
          ),
          style: GoogleFonts.poppins(fontSize: isTablet ? 15 : 14),
        ),
      ],
    );
  }

  // Reusable Dropdown
  Widget _buildDropdownField({
    required String label,
    required String hint,
    required String? value,
    required bool isTablet,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: isTablet ? 17 : 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              hint: Text(hint, style: GoogleFonts.poppins(color: Colors.grey.shade500)),
              items: items
                  .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e, style: GoogleFonts.poppins()),
              ))
                  .toList(),
              onChanged: onChanged,
              dropdownColor: Colors.white,
              icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey.shade600),
            ),
          ),
        ),
      ],
    );
  }

  // Submit Logic with Success Dialog
  void _submitTicket() {
    if (_subjectController.text.trim().isEmpty ||
        _selectedDepartment == null ||
        _descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => SuccessTicketDialog(
        subject: _subjectController.text.trim(),
        department: _selectedDepartment!,
      ),
    );

    // Auto close + go back
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pop(context); // Close dialog
        Navigator.pop(context); // Back to previous screen
      }
    });
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}

// SUCCESS DIALOG – Beautiful & Dynamic
class SuccessTicketDialog extends StatelessWidget {
  final String subject;
  final String department;

  const SuccessTicketDialog({
    super.key,
    required this.subject,
    required this.department,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      elevation: 20,
      child: Container(
        padding: EdgeInsets.all(isTablet ? 40 : 32),
        constraints: const BoxConstraints(maxWidth: 380),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Green Checkmark
            Container(
              width: 75,
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xff34C759),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 52),
            ),

            const SizedBox(height: 28),

            Text(
              "Ticket Raised Successfully!",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: isTablet ? 22 : 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              "Subject: $subject",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: isTablet ? 17 : 15,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Department: $department",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: isTablet ? 17 : 15,
                color: const Color(0xFF26A69A),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}