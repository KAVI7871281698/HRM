// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'leave_management.dart';
//
// class LeaveApplication extends StatelessWidget {
//   const LeaveApplication({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: const Color(0xff26A69A),
//           foregroundColor: Colors.white,
//           elevation: 1,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(builder: (context) => const LeaveManagementScreen()),
//                     (route) => false,
//               );
//             },
//           ),
//           title: Text(
//             'Apply Leave / Permission',
//             style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
//           ),
//         ),
//         body: const LeaveFormScreen(),
//       ),
//     );
//   }
// }
//
// class LeaveFormScreen extends StatefulWidget {
//   const LeaveFormScreen({super.key});
//
//   @override
//   State<LeaveFormScreen> createState() => _LeaveFormScreenState();
// }
//
// class _LeaveFormScreenState extends State<LeaveFormScreen> {
//   int selectedTab = 0; // 0 for Leave Form, 1 for Permission Form
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.symmetric(horizontal: 24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 20),
//
//           // Tabs (Leave Form / Permission Form)
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () => setState(() => selectedTab = 0),
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       decoration: BoxDecoration(
//                         color: selectedTab == 0 ? const Color(0xff26A69A) : Color(0xffC9C9C9),
//                         borderRadius: BorderRadius.circular(40),
//                       ),
//                       child: Text(
//                         "Leave Form",
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: selectedTab == 0 ? Colors.white : Colors.grey.shade700,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () => setState(() => selectedTab = 1),
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       decoration: BoxDecoration(
//                         color: selectedTab == 1 ? const Color(0xff26A69A) : Color(0xffC9C9C9),
//                         borderRadius: BorderRadius.circular(40),
//                       ),
//                       child: Text(
//                         "Permission Form",
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: selectedTab == 1 ? Colors.white : Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           const SizedBox(height: 30),
//
//           // Show different forms based on selected tab
//           if (selectedTab == 0)
//             const LeaveFormContent()
//           else
//             const PermissionFormContent(),
//         ],
//       ),
//     );
//   }
// }
//
// class LeaveFormContent extends StatefulWidget {
//   const LeaveFormContent({super.key});
//
//   @override
//   State<LeaveFormContent> createState() => _LeaveFormContentState();
// }
//
// class _LeaveFormContentState extends State<LeaveFormContent> {
//   final _formKey = GlobalKey<FormState>();
//   String? employeeName;
//   String? employeeId;
//   String? leaveType;
//   DateTime? fromDate;
//   DateTime? toDate;
//   String? reason;
//
//   final List<String> leaveTypes = [
//     'Select Leave Type',
//     'Annual Leave',
//     'Sick Leave',
//     'Casual Leave',
//     'Maternity Leave',
//     'Permission (Short Leave)',
//     'Others'
//   ];
//
//   Future<void> _selectDate(BuildContext context, bool isFrom) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2020),
//       lastDate: DateTime(2030),
//       builder: (context, child) {
//         return Theme(
//           data: ThemeData.light().copyWith(
//             colorScheme: const ColorScheme.light(primary: Colors.teal),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (picked != null) {
//       setState(() {
//         if (isFrom) {
//           fromDate = picked;
//         } else {
//           toDate = picked;
//         }
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Employee Name Section
//           _buildSectionTitle('Employee Name'),
//           const SizedBox(height: 8),
//           _buildTextField('Enter Employee Name', (val) => employeeName = val),
//           const SizedBox(height: 20),
//
//           // Employee ID Section
//           _buildSectionTitle('Employee ID'),
//           const SizedBox(height: 8),
//           _buildTextField('Enter Employee ID', (val) => employeeId = val),
//           const SizedBox(height: 20),
//
//           // Leave Type Section
//           _buildSectionTitle('Leave Type'),
//           const SizedBox(height: 8),
//           DropdownButtonFormField<String>(
//             value: leaveType,
//             decoration: InputDecoration(
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide(color: Colors.grey.shade400),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide(color: Colors.grey.shade400),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: const BorderSide(color: Color(0xff26A69A), width: 2),
//               ),
//               contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//               filled: true,
//               fillColor: Colors.white,
//             ),
//             hint: Text(
//               'Select Leave Type',
//               style: GoogleFonts.poppins(
//                 fontSize: 16,
//                 color: Colors.grey.shade600,
//               ),
//             ),
//             items: leaveTypes.map((type) {
//               return DropdownMenuItem(
//                 value: type,
//                 child: Text(
//                   type,
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     color: type == 'Select Leave Type' ? Colors.grey.shade600 : Colors.black87,
//                   ),
//                 ),
//               );
//             }).toList(),
//             onChanged: (value) {
//               setState(() => leaveType = value);
//             },
//             validator: (value) => value == null || value == 'Select Leave Type' ? 'Required' : null,
//           ),
//           const SizedBox(height: 20),
//
//           // From Date Section
//           _buildSectionTitle('From Date'),
//           const SizedBox(height: 8),
//           InkWell(
//             onTap: () => _selectDate(context, true),
//             child: Container(
//               height: 56,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade400),
//                 borderRadius: BorderRadius.circular(12),
//                 color: Colors.white,
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 children: [
//                   const Icon(Icons.calendar_month_outlined),
//                   const SizedBox(width: 12),
//                   Text(
//                     fromDate == null
//                         ? 'Select Date'
//                         : '${fromDate!.day}/${fromDate!.month}/${fromDate!.year}',
//                     style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       color: fromDate == null ? Colors.grey.shade600 : Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//
//           // To Date Section
//           _buildSectionTitle('To Date'),
//           const SizedBox(height: 8),
//           InkWell(
//             onTap: () => _selectDate(context, false),
//             child: Container(
//               height: 56,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade400),
//                 borderRadius: BorderRadius.circular(12),
//                 color: Colors.white,
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 children: [
//                   const Icon(Icons.calendar_month_outlined),
//                   const SizedBox(width: 12),
//                   Text(
//                     toDate == null
//                         ? 'Select Date'
//                         : '${toDate!.day}/${toDate!.month}/${toDate!.year}',
//                     style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       color: toDate == null ? Colors.grey.shade600 : Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//
//           // Reason Section
//           _buildSectionTitle('Reason'),
//           const SizedBox(height: 8),
//           Container(
//             height: 80,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey.shade400),
//               borderRadius: BorderRadius.circular(12),
//               color: Colors.white,
//             ),
//             child: TextFormField(
//               maxLines: null,
//               expands: true,
//               decoration: InputDecoration(
//                 hintText: 'Reason',
//                 hintStyle: GoogleFonts.poppins(
//                   fontSize: 16,
//                   color: Colors.grey.shade600,
//                 ),
//                 border: InputBorder.none,
//                 contentPadding: const EdgeInsets.all(16),
//               ),
//               style: GoogleFonts.poppins(fontSize: 16),
//               onChanged: (val) => reason = val,
//               validator: (val) => val!.isEmpty ? 'Reason is required' : null,
//             ),
//           ),
//
//           const SizedBox(height: 40),
//
//           // Submit Button
//           Center(
//             child: SizedBox(
//               width: 325,
//               height: 55,
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate() && fromDate != null && toDate != null) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Leave Applied Successfully!')),
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xff26A69A),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                   elevation: 2,
//                 ),
//                 child: Text(
//                   'Submit',
//                   style: GoogleFonts.poppins(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//
//           const SizedBox(height: 30),
//         ],
//       ),
//     );
//   }
//
//   // Section Title Widget
//   Widget _buildSectionTitle(String title) {
//     return Text(
//       title,
//       style: GoogleFonts.poppins(
//         fontSize: 14,
//         fontWeight: FontWeight.w500,
//         color: Colors.black87,
//       ),
//     );
//   }
//
//   // Text Field Widget
//   Widget _buildTextField(String hint, Function(String) onChanged) {
//     return Container(
//       height: 56,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade400),
//         borderRadius: BorderRadius.circular(12),
//         color: Colors.white,
//       ),
//       child: TextFormField(
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: GoogleFonts.poppins(
//             fontSize: 16,
//             color: Colors.grey.shade600,
//           ),
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//         ),
//         style: GoogleFonts.poppins(fontSize: 16),
//         onChanged: onChanged,
//         validator: (val) => val!.isEmpty ? 'Required' : null,
//       ),
//     );
//   }
// }
//
// class PermissionFormContent extends StatefulWidget {
//   const PermissionFormContent({super.key});
//
//   @override
//   State<PermissionFormContent> createState() => _PermissionFormContentState();
// }
//
// class _PermissionFormContentState extends State<PermissionFormContent> {
//   final _formKey = GlobalKey<FormState>();
//   String? permissionType;
//   DateTime? selectedDate;
//   TimeOfDay? fromTime;
//   TimeOfDay? toTime;
//   String? reason;
//
//   final List<String> permissionTypes = [
//     'Select Permission Type',
//     'Medical Appointment',
//     'Personal Work',
//     'Family Emergency',
//     'Official Work',
//     'Others'
//   ];
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2020),
//       lastDate: DateTime(2030),
//       builder: (context, child) {
//         return Theme(
//           data: ThemeData.light().copyWith(
//             colorScheme: const ColorScheme.light(primary: Colors.teal),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (picked != null) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }
//
//   Future<void> _selectTime(BuildContext context, bool isFrom) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//       builder: (context, child) {
//         return Theme(
//           data: ThemeData.light().copyWith(
//             colorScheme: const ColorScheme.light(primary: Colors.teal),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (picked != null) {
//       setState(() {
//         if (isFrom) {
//           fromTime = picked;
//         } else {
//           toTime = picked;
//         }
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Request Permission Title
//           Center(
//             child: Text(
//               'Request Permission',
//               style: GoogleFonts.poppins(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black87,
//               ),
//             ),
//           ),
//           const SizedBox(height: 30),
//
//           // Permission Type Section
//           _buildSectionTitle('Permission type'),
//           const SizedBox(height: 8),
//           DropdownButtonFormField<String>(
//             value: permissionType,
//             decoration: InputDecoration(
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide(color: Colors.grey.shade400),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide(color: Colors.grey.shade400),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: const BorderSide(color: Color(0xff26A69A), width: 2),
//               ),
//               contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//               filled: true,
//               fillColor: Colors.white,
//             ),
//             hint: Text(
//               'Select Permission Type',
//               style: GoogleFonts.poppins(
//                 fontSize: 16,
//                 color: Colors.grey.shade600,
//               ),
//             ),
//             items: permissionTypes.map((type) {
//               return DropdownMenuItem(
//                 value: type,
//                 child: Text(
//                   type,
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     color: type == 'Select Permission Type' ? Colors.grey.shade600 : Colors.black87,
//                   ),
//                 ),
//               );
//             }).toList(),
//             onChanged: (value) {
//               setState(() => permissionType = value);
//             },
//             validator: (value) => value == null || value == 'Select Permission Type' ? 'Required' : null,
//           ),
//           const SizedBox(height: 20),
//
//           // Date Section
//           _buildSectionTitle('Date'),
//           const SizedBox(height: 8),
//           InkWell(
//             onTap: () => _selectDate(context),
//             child: Container(
//               height: 56,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade400),
//                 borderRadius: BorderRadius.circular(12),
//                 color: Colors.white,
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 children: [
//                   const Icon(Icons.calendar_month_outlined),
//                   const SizedBox(width: 12),
//                   Text(
//                     selectedDate == null
//                         ? 'Select Date'
//                         : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
//                     style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       color: selectedDate == null ? Colors.grey.shade600 : Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//
//           // From Time Section
//           _buildSectionTitle('From Time'),
//           const SizedBox(height: 8),
//           InkWell(
//             onTap: () => _selectTime(context, true),
//             child: Container(
//               height: 56,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade400),
//                 borderRadius: BorderRadius.circular(12),
//                 color: Colors.white,
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 children: [
//                   const Icon(Icons.access_time),
//                   const SizedBox(width: 12),
//                   Text(
//                     fromTime == null
//                         ? 'Select Time'
//                         : '${fromTime!.hour}:${fromTime!.minute.toString().padLeft(2, '0')}',
//                     style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       color: fromTime == null ? Colors.grey.shade600 : Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//
//           // To Time Section
//           _buildSectionTitle('To Time'),
//           const SizedBox(height: 8),
//           InkWell(
//             onTap: () => _selectTime(context, false),
//             child: Container(
//               height: 56,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade400),
//                 borderRadius: BorderRadius.circular(12),
//                 color: Colors.white,
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 children: [
//                   const Icon(Icons.access_time),
//                   const SizedBox(width: 12),
//                   Text(
//                     toTime == null
//                         ? 'Select Time'
//                         : '${toTime!.hour}:${toTime!.minute.toString().padLeft(2, '0')}',
//                     style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       color: toTime == null ? Colors.grey.shade600 : Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//
//           // Reason Section
//           _buildSectionTitle('Reason'),
//           const SizedBox(height: 8),
//           Container(
//             height: 80,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey.shade400),
//               borderRadius: BorderRadius.circular(12),
//               color: Colors.white,
//             ),
//             child: TextFormField(
//               maxLines: null,
//               expands: true,
//               decoration: InputDecoration(
//                 hintText: 'Enter Reason For Permission',
//                 hintStyle: GoogleFonts.poppins(
//                   fontSize: 16,
//                   color: Colors.grey.shade600,
//                 ),
//                 border: InputBorder.none,
//                 contentPadding: const EdgeInsets.all(16),
//               ),
//               style: GoogleFonts.poppins(fontSize: 16),
//               onChanged: (val) => reason = val,
//               validator: (val) => val!.isEmpty ? 'Reason is required' : null,
//             ),
//           ),
//
//           const SizedBox(height: 40),
//
//           // Submit Button
//           Center(
//             child: SizedBox(
//               width: 325,
//               height: 55,
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate() &&
//                       selectedDate != null &&
//                       fromTime != null &&
//                       toTime != null) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Permission Requested Successfully!')),
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xff26A69A),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                   elevation: 2,
//                 ),
//                 child: Text(
//                   'Submit',
//                   style: GoogleFonts.poppins(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//
//           const SizedBox(height: 30),
//         ],
//       ),
//     );
//   }
//
//   // Section Title Widget
//   Widget _buildSectionTitle(String title) {
//     return Text(
//       title,
//       style: GoogleFonts.poppins(
//         fontSize: 14,
//         fontWeight: FontWeight.w500,
//         color: Colors.black87,
//       ),
//     );
//   }
// }