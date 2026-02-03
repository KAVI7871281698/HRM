import 'package:flutter/material.dart';
import '../../services/auth_api.dart';
import 'package:hrm/views/main_root.dart';

class OtpBottomSheet extends StatefulWidget {
  final String phoneNumber;

  const OtpBottomSheet({super.key, required this.phoneNumber});

  @override
  State<OtpBottomSheet> createState() => _OtpBottomSheetState();
}

class _OtpBottomSheetState extends State<OtpBottomSheet> {
  final List<TextEditingController> controllers =
      List.generate(6, (_) => TextEditingController());

  final List<FocusNode> focusNodes =
      List.generate(6, (_) => FocusNode());

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

    return Container(
      height: size.height * 0.42,
      padding: EdgeInsets.all(size.width * 0.06),
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
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () => Navigator.pop(context),
              ),
              const Text(
                "Verify with OTP",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Text("OTP sent to ${widget.phoneNumber}"),

          const SizedBox(height: 24),

          /// OTP BOXES
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              6,
              (index) => SizedBox(
                width: 45,
                child: TextField(
                  controller: controllers[index],
                  focusNode: focusNodes[index],
                  maxLength: 1,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(counterText: ""),
                  onChanged: (v) {
                    if (v.isNotEmpty && index < 5) {
                      focusNodes[index + 1].requestFocus();
                    }
                  },
                ),
              ),
            ),
          ),

          const Spacer(),

          /// VERIFY BUTTON
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () async {
                String otp =
                    controllers.map((e) => e.text).join();

                bool verified = await AuthApi.verifyOtp(
                  mobile: widget.phoneNumber,
                  otp: otp,
                );

                if (verified) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const MainRoot()),
                    (route) => false,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Invalid OTP")),
                  );
                }
              },
              child: const Text("Verify"),
            ),
          ),
        ],
      ),
    );
  }
}
