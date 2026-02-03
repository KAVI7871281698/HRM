import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main_root.dart';

class CheckInVerificationScreen extends StatefulWidget {
  const CheckInVerificationScreen({super.key});

  @override
  State<CheckInVerificationScreen> createState() =>
      _CheckInVerificationScreenState();
}

class _CheckInVerificationScreenState
    extends State<CheckInVerificationScreen> {
  final TextEditingController inTimeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  String selectedMode = 'Mode of work';
  bool isCheckedIn = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F7),
      appBar: AppBar(
        backgroundColor: Color(0xFF26A69A),
        foregroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Check in Verification',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.06,
            vertical: size.height * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Page Title
              const Text(
                'Check in Verification',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),

              /// In Time
              _label('In Time'),
              _textField(
                controller: inTimeController,
                hint: 'Tap to select time',
                readOnly: true,
                onTap: _pickTime,
                prefixIcon: Icons.access_time_outlined,

              ),
              const SizedBox(height: 14),

              /// Location
              _label('Location'),
              _textField(
                controller: locationController,
                hint: '',
                prefixIcon: Icons.my_location,
              ),
              const SizedBox(height: 14),

              /// Mode of Work
              _label('Work Mode'),
              _dropdownField(),
              const SizedBox(height: 18),

              /// Selfie Verification
              _selfieCard(size),
              SizedBox(height: size.height * 0.1),

              /// Submit Button
              Center(
                child: SizedBox(
                  width: size.width * 0.55,
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2AA89A),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      if (inTimeController.text.isEmpty ||
                          locationController.text.isEmpty ||
                          selectedMode == 'Mode of work') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all details'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Check-in submitted successfully'),
                          backgroundColor: Color(0xFF2AA89A),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Future.delayed(const Duration(milliseconds: 500), () {
                        Navigator.pop(context, true);
                      });

                    },

                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    bool readOnly = false,
    VoidCallback? onTap,
    IconData? prefixIcon,
  }) {
    return SizedBox(
      height: 44,
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: prefixIcon != null
              ? Icon(
            prefixIcon,
            color: const Color(0xFF26A69A),
            size: 22,
          )
              : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xFF2AA89A)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xFF2AA89A)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xFF2AA89A)),
          ),
        ),
      ),
    );
  }

  Widget _dropdownField() {
    return SizedBox(
      height: 44,
      child: DropdownButtonFormField<String>(
        value: selectedMode,
        items: const [
          DropdownMenuItem(
            value: 'Mode of work',
            child: Text('Mode of work'),
          ),
          DropdownMenuItem(
            value: 'Office',
            child: Text('Office'),
          ),
          DropdownMenuItem(
            value: 'Work From Home',
            child: Text('Work From Home'),
          ),
        ],
        onChanged: (value) {
          setState(() {
            selectedMode = value!;
          });
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFD7FFFA),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none,
          ),
        ),
        icon: const Icon(Icons.keyboard_arrow_down),
      ),
    );
  }

  Widget _selfieCard(Size size) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selfie Verification',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          /// Dashed Border Placeholder
          Center(
            child: Container(
              height: size.height * 0.10,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: Colors.grey.shade400,
                  style: BorderStyle.solid,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 34,
                  color: Color(0xFF2AA89A),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),

          /// Take Selfie Button
          Center(
            child: SizedBox(
              height: 38,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2AA89A),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () {},
                icon: const Icon(Icons.camera_alt, size: 16),
                label: const Text(
                  'Take Selfie',
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        inTimeController.text = picked.format(context);
      });
    }
  }
}
