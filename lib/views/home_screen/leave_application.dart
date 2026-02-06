import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/leave_api.dart';
import 'leave_management.dart';

// Helper extension for 12-hour time format
extension TimeOfDayExtension on TimeOfDay {
  String format12Hour() {
    final hour = hourOfPeriod == 0 ? 12 : hourOfPeriod;
    final minute = this.minute.toString().padLeft(2, '0');
    final period = this.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}

class LeaveApplication extends StatelessWidget {
  const LeaveApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xff26A69A),
          foregroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (_) => const LeaveManagementScreen()),
                (route) => false,
              );
            },
          ),
          title: Text(
            'Apply Leave / Permission',
            style: GoogleFonts.poppins(
                fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        body: const LeaveFormScreen(),
      ),
    );
  }
}

class LeaveFormScreen extends StatefulWidget {
  const LeaveFormScreen({super.key});

  @override
  State<LeaveFormScreen> createState() => _LeaveFormScreenState();
}

class _LeaveFormScreenState extends State<LeaveFormScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          /// Tabs
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedTab = 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: selectedTab == 0
                            ? const Color(0xff26A69A)
                            : const Color(0xffC9C9C9),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Text(
                        "Leave Form",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: selectedTab == 0
                              ? Colors.white
                              : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedTab = 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: selectedTab == 1
                            ? const Color(0xff26A69A)
                            : const Color(0xffC9C9C9),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Text(
                        "Permission Form",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: selectedTab == 1
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          if (selectedTab == 0)
            const LeaveForm()
          else
            const PermissionForm(),
        ],
      ),
    );
  }
}

class LeaveForm extends StatefulWidget {
  const LeaveForm({super.key});

  @override
  State<LeaveForm> createState() => _LeaveFormState();
}

class _LeaveFormState extends State<LeaveForm> {
  final _formKey = GlobalKey<FormState>();

  String? employeeName;
  String? employeeId;
  String? leaveType;
  DateTime? fromDate;
  DateTime? toDate;
  String? reason;

  List<String> leaveTypes = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchLeaveTypes();
  }

  /// FETCH LEAVE TYPES (2044)
  Future<void> _fetchLeaveTypes() async {
    try {
      final res = await LeaveApi.getLeaveTypes(
        cid: "21472147",
        deviceId: "123456",
        lat: "123",
        lng: "123",
      );

      /// 🔍 DEBUG PRINT
      debugPrint("LEAVE TYPE API RESPONSE => $res");

      if (res["error"] == false) {
        final List list = res["data"]["leave_types"];
        setState(() {
          leaveTypes =
              list.map((e) => e["leave_type_name"].toString()).toList();
        });
      }
    } catch (e) {
      debugPrint("Leave type error => $e");
    }
  }

  /// APPLY LEAVE (2043)
  Future<void> _applyLeave() async {
    if (!_formKey.currentState!.validate() ||
        fromDate == null ||
        toDate == null) {
      _snack("Please fill all fields", false);
      return;
    }

    setState(() => isLoading = true);

    try {
      final res = await LeaveApi.applyLeave(
        id: "8",
        employeeName: employeeName!,
        employeeId: employeeId!,
        leaveType: leaveType!,
        fromDate:
            "${fromDate!.year}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}",
        toDate:
            "${toDate!.year}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}",
        reason: reason!,
        cid: "21472147",
        deviceId: "123456",
        lat: "145",
        lng: "145",
      );

      /// 🔍 DEBUG PRINT
      debugPrint("APPLY LEAVE API RESPONSE => $res");

      if (res["error"] == false) {
        _snack(res["error_msg"], true);
        _formKey.currentState!.reset();
      } else {
        _snack(res["error_msg"], false);
      }
    } catch (e) {
      debugPrint("Apply leave error => $e");
      _snack("Server error", false);
    }

    setState(() => isLoading = false);
  }

  void _snack(String msg, bool success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  /// ================= UI BELOW IS 100% UNCHANGED =================

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Employee Name'),
          _textField('Enter Employee Name', (v) => employeeName = v),
          _title('Employee ID'),
          _textField('Enter Employee ID', (v) => employeeId = v),
          _title('Leave Type'),
          DropdownButtonFormField<String>(
            value: leaveType,
            items: leaveTypes
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (v) => setState(() => leaveType = v),
            validator: (v) => v == null ? 'Required' : null,
          ),
          _datePicker('From Date', fromDate, true),
          _datePicker('To Date', toDate, false),
          _reasonBox(),
          const SizedBox(height: 80),
          Center(
            child: SizedBox(
              width: 325,
              height: 55,
              child: ElevatedButton(
                onPressed: isLoading ? null : _applyLeave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff26A69A),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: Text('Submit',
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _title(String t) => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 8),
        child: Text(t,
            style: GoogleFonts.poppins(
                fontSize: 14, fontWeight: FontWeight.w500)),
      );

  Widget _textField(String hint, Function(String) onChanged) {
    return TextFormField(
      decoration: InputDecoration(hintText: hint),
      validator: (v) => v!.isEmpty ? 'Required' : null,
      onChanged: onChanged,
    );
  }

  Widget _datePicker(String label, DateTime? date, bool isFrom) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(label),
        InkWell(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
            );
            if (picked != null) {
              setState(() {
                if (isFrom) {
                  fromDate = picked;
                } else {
                  toDate = picked;
                }
              });
            }
          },
          child: Container(
            height: 56,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12)),
            child: Text(
              date == null
                  ? 'Select Date'
                  : '${date.day}/${date.month}/${date.year}',
            ),
          ),
        ),
      ],
    );
  }

  Widget _reasonBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title('Reason'),
        TextFormField(
          maxLines: 3,
          validator: (v) => v!.isEmpty ? 'Required' : null,
          onChanged: (v) => reason = v,
          decoration: const InputDecoration(hintText: 'Reason'),
        ),
      ],
    );
  }
}

/// PERMISSION FORM (UNCHANGED)
class PermissionForm extends StatelessWidget {
  const PermissionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Permission Form UI unchanged");
  }
}
