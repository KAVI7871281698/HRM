import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrm/views/main_root.dart';
import 'package:hrm/views/widgets/profile_card.dart';

import 'leave_application.dart';


void main() => runApp(const MaterialApp(home: LeaveManagementScreen()));

class LeaveManagementScreen extends StatefulWidget {
  const LeaveManagementScreen({super.key});

  @override
  State<LeaveManagementScreen> createState() => _LeaveManagementScreenState();
}

class _LeaveManagementScreenState extends State<LeaveManagementScreen> {
  int selectedTab = 0; // 0 = Summary, 1 = History

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xff26A69A),
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
          'Leave Management',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // const ProfileSection(),
            const SizedBox(height: 12),

            // TABS
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 16, 8),
              child: Container(
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
                            color: selectedTab == 0 ? const Color(0xff26A69A) : Colors.white,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Text(
                            "Leave Summary",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: selectedTab == 0 ? Colors.white : Colors.grey.shade700,
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
                            color: selectedTab == 1 ? const Color(0xff26A69A) : Colors.white,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Text(
                            "Leave History",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: selectedTab == 1 ? Colors.white : Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            selectedTab == 0
                ? const LeaveBalanceGrid()
                : const LeaveHistoryList(),


            if (selectedTab == 0) ...[
              const SizedBox(height: 40),
              const HolidayListCard(),
              const SizedBox(height: 40),
              const ApplyLeaveButton(),
              const SizedBox(height: 40),
            ] else
              const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}


// class ProfileSection extends StatelessWidget {
//   const ProfileSection({super.key});
//   @override Widget build(BuildContext context) => Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//     child: ProfileInfoCard(name: 'Harsh', employeeId: '1023', designation: 'Supervisor', profileImagePath: 'assets/profile.png'),
//   );
// }

class LeaveBalanceGrid extends StatelessWidget {
  const LeaveBalanceGrid({super.key});

  static final List<Map<String, dynamic>> leaveData = [
    {
      "type": "Casual", "taken": 3, "total": 12, "balance": "9/12",
      "gradient": const [Color(0xFFF5F5F5), Color(0xFFD4D6FF)],
      "progressColor": const Color(0xff8388FF), "titleColor": const Color(0xff1B2C61),
    },
    {
      "type": "Sick", "taken": 6, "total": 12, "balance": "6/12",
      "gradient": const [Color(0xFFF5F5F5), Color(0xFFD4FEFF)],
      "progressColor": const Color(0xff59FAFF), "titleColor": const Color(0xff1B2C61),
    },
    {
      "type": "Earned", "taken": 2, "total": 12, "balance": "10/12",
      "gradient": const [Color(0xFFF5F5F5), Color(0xFFF4D4FF)],
      "progressColor": const Color(0xffD679F8), "titleColor": const Color(0xff1B2C61),
    },
    {
      "type": "Maternity", "taken": 3, "total": 12, "balance": "9/12",
      "gradient": const [Color(0xFFF5F5F5), Color(0xFFFFD4D5)],
      "progressColor": const Color(0xffFB6065), "titleColor": const Color(0xff1B2C61),
    },
    {
      "type": "Unpaid", "taken": 2, "total": null, "balance": "-/-",
      "gradient": const [Color(0xFFF5F5F5), Color(0xFFA8EA9F)],
      "progressColor": const Color(0xFF00B894), "titleColor": const Color(0xff1B2C61),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double cardWidth = (MediaQuery.of(context).size.width - 48 - 20) / 2;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 20, runSpacing: 20,
        children: leaveData.map((data) {
          final progress = data["total"] == null ? 0.0 : (data["taken"] as num) / (data["total"] as num);
          return SizedBox(
            width: cardWidth,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: data["gradient"]),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('• ${data["type"]}', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: data["titleColor"])),
                const SizedBox(height: 12),
                Text('Taken    : ${data["taken"]} Days', style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87)),
                const SizedBox(height: 6),
                Text('Balance : ${data["balance"]}', style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87)),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation(data["progressColor"]),
                    minHeight: 8,
                  ),
                ),
              ]),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class LeaveHistoryList extends StatelessWidget {
  const LeaveHistoryList({super.key});

  final List<Map<String, String>> history = const [
    {"date": "2025/11/01", "type": "Sick Leave", "status": "Pending"},
    {"date": "2025/10/29", "type": "Casual Leave", "status": "Approved"},
    {"date": "2025/10/06", "type": "Casual Leave", "status": "Approved"},
    {"date": "2025/09/15", "type": "Sick Leave", "status": "Approved"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: history.length,
      itemBuilder: (context, index) {
        final item = history[index];
        final bool isPending = item["status"] == "Pending";

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 2))],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  'assets/leavearrow.png',
                  width: 24,
                  height: 24,
                  // color: const Color(0xff26A69A),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(item["date"]!, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87)),
                  const SizedBox(height: 4),
                  Text(item["type"]!, style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey.shade600)),
                ]),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isPending ? const Color(0xffFFF3E0) : const Color(0xffE8F5E8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  item["status"]!,
                  style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: isPending ? const Color(0xffF87000) : const Color(0xff05D817)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ApplyLeaveButton extends StatelessWidget {
  const ApplyLeaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: SizedBox(
        width: 280,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LeaveApplication()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff26A69A),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 6,
          ),
          child: Text('Apply Leave / Permission', style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white)),
        ),
      ),
    );
  }
}
class HolidayListCard extends StatelessWidget {
  const HolidayListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xffF5ACAC),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(
                Icons.event_note_outlined,
                color: Color(0xff1B2C61),
                size: 26,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Holiday List',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff1B2C61),
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_right,
                size: 35,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
