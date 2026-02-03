import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:hrm/views/widgets/profile_card.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _clientNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  String? _selectedPurpose;

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
          "Marketing",
          style: GoogleFonts.poppins(
            fontSize: isTablet ? 22 : 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            // ProfileInfoCard(
            //   name: "Harish",
            //   employeeId: "1023",
            //   designation: "Supervisor",
            //   profileImagePath: "assets/profile.png",
            // ),

            // SizedBox(height: isTablet ? 30 : 20),

            _buildLabeledField(
              context: context,
              label: "Date",
              hint: "Date",
              controller: _dateController,
              isTablet: isTablet,
              prefixIcon: Icons.calendar_today_outlined,
              isDateField: true,
            ),

            SizedBox(height: isTablet ? 20 : 16),

            _buildLabeledField(
              context: context,
              label: "Client Name",
              hint: "Client Name",
              controller: _clientNameController,
              isTablet: isTablet,
              prefixIcon: Icons.person_outline,
            ),

            SizedBox(height: isTablet ? 20 : 16),

            _buildLabeledField(
              context: context,
              label: "Location",
              hint: "Location",
              controller: _locationController,
              isTablet: isTablet,
              prefixIcon: Icons.my_location,
            ),

            SizedBox(height: isTablet ? 20 : 16),

            _buildDropdownField(
              context: context,
              label: "Purpose Of Visit",
              hint: "Select Purpose of Visit",
              value: _selectedPurpose,
              isTablet: isTablet,
              items: const [
                'New Lead',
                'Close',
                'New Business Pitch',
                'Meeting',
              ],
              onChanged: (value) {
                setState(() => _selectedPurpose = value);
              },
            ),

            SizedBox(height: isTablet ? 20 : 16),

            _buildLabeledField(
              context: context,
              label: "Remarks",
              hint: "Remarks",
              controller: _remarksController,
              isTablet: isTablet,
              maxLines: 4,
            ),

            SizedBox(height: isTablet ? 20 : 16),


                Text(
                  "Attachments",
                  style: GoogleFonts.poppins(
                    fontSize: isTablet ? 16 : 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),


                Column(
                  children: [
                    DottedBorder(
                      color: Colors.grey.shade400,
                      strokeWidth: 1.5,
                      dashPattern: const [6, 4],
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(8),
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              size: 50,
                              color: Colors.grey.shade500,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Add Attachments",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),


            SizedBox(height: isTablet ? 40 : 30),

            SizedBox(
              width:350,
              height: 55,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF26A69A),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  elevation: 3,
                ),
                child: Text(
                  "Submit",
                  style: GoogleFonts.poppins(
                    fontSize: isTablet ? 18 : 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildLabeledField({
    required BuildContext context,
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool isTablet,
    IconData? prefixIcon,
    bool isDateField = false,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: isTablet ? 16 : 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          readOnly: isDateField,
          onTap: isDateField ? () => _selectDate(context) : null,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
              color: Colors.grey.shade500,
              fontSize: isTablet ? 14 : 13,
            ),
            prefixIcon: prefixIcon != null
                ? Icon(
              prefixIcon,
              color: const Color(0xFF26A69A),
              size: isTablet ? 22 : 20,
            )
                : null,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: isTablet ? 16 : 14,
            ),
          ),
          style: GoogleFonts.poppins(
            fontSize: isTablet ? 14 : 13,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required BuildContext context,
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
            fontSize: isTablet ? 16 : 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              hint: Text(
                hint,
                style: GoogleFonts.poppins(color: Colors.grey.shade500),
              ),
              items: items
                  .map(
                    (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: GoogleFonts.poppins()),
                ),
              )
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF26A69A),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _submitForm() {
    if (_dateController.text.isEmpty ||
        _clientNameController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _selectedPurpose == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all required fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Checkout submitted successfully!"),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _clientNameController.dispose();
    _locationController.dispose();
    _remarksController.dispose();
    super.dispose();
  }
}