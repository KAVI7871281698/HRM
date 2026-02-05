import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/login_api.dart';
import '../main_root.dart'; // change if needed

class OtpBottomSheet extends StatefulWidget {
  final String phoneNumber;

  const OtpBottomSheet({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OtpBottomSheet> createState() => _OtpBottomSheetState();
}

class _OtpBottomSheetState extends State<OtpBottomSheet> {
  final List<TextEditingController> controllers =
      List.generate(6, (_) => TextEditingController());

  final List<FocusNode> focusNodes =
      List.generate(6, (_) => FocusNode());

  bool isLoading = false;

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Container(
      height: height * 0.40,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.06,
        vertical: height * 0.02,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            children: [
              CircleAvatar(
                radius: width * 0.045,
                backgroundColor: Colors.grey.shade200,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new, size: width * 0.04),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SizedBox(width: width * 0.03),
              Text(
                "Verify with OTP",
                style: TextStyle(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          SizedBox(height: height * 0.035),

          /// Message
          Text(
            "Enter the OTP sent to ${widget.phoneNumber}",
            style: TextStyle(
              color: Colors.black54,
              fontSize: width * 0.035,
            ),
          ),

          SizedBox(height: height * 0.04),

          /// OTP Boxes
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              6,
              (index) => _otpBox(index, width * 0.11, height * 0.065, width * 0.045),
            ),
          ),

          const Spacer(),

          /// Verify button
          SizedBox(
            width: double.infinity,
            height: height * 0.05,
            child: ElevatedButton(
              onPressed: isLoading ? null : _verifyOtpApi,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF26A69A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2)
                  : Text(
                      "Verify",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  /// OTP BOX
  Widget _otpBox(int index, double width, double height, double fontSize) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF26A69A)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF26A69A), width: 2),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }

  /// ✅ VERIFY OTP API
  Future<void> _verifyOtpApi() async {
    String otp = controllers.map((e) => e.text).join();

    if (otp.length != 6) {
      _snack("Enter valid OTP", false);
      return;
    }

    setState(() => isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final lat = prefs.getDouble('lat')?.toString() ?? "145";
      final lng = prefs.getDouble('lng')?.toString() ?? "145";

      final response = await LoginApi.verifyOtp(
        mobile: widget.phoneNumber,
        otp: otp,
        cid: "21472147",
        type: "2001",
        deviceId: "12345",
        lat: lat,
        lng: lng,
      );

      debugPrint("VERIFY OTP RESPONSE => $response");

      final bool isSuccess =
          response["error"] == false ||
          response["error"] == "false" ||
          response["status"] == true ||
          response["status"] == 1;

      if (isSuccess) {
        _snack("OTP verified successfully", true);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => MainRoot()),
          (route) => false,
        );
      } else {
        _snack(
          response["error_msg"] ??
              response["message"] ??
              "Invalid OTP",
          false,
        );
      }
    } catch (e) {
      debugPrint("VERIFY OTP ERROR => $e");
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
}
