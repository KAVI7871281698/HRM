import 'package:flutter/material.dart';
import 'package:hrm/views/login_section/login_screen.dart';
import 'package:hrm/views/login_section/sign-in_whatsapp.dart';
import 'package:hrm/views/login_section/sign-up.dart';
import 'package:hrm/views/login_section/otp_popup.dart';
import '../../services/auth_api.dart';

class SmsLogin extends StatefulWidget {
  const SmsLogin({super.key});

  @override
  State<SmsLogin> createState() => _SmsLoginState();
}

class _SmsLoginState extends State<SmsLogin> {
  final TextEditingController _emailController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    // MediaQuery
    final Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.13),

                /// Logo
                Center(
                  child: Image.asset(
                    'assets/logo.png',
                    width: width * 0.55,
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: height * 0.05),

                /// Sign in title
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),

                SizedBox(height: height * 0.01),

                /// Subtitle
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Manage your customers, sales & business anywhere.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ),

                SizedBox(height: height * 0.05),

                /// Mobile Field (UI SAME)
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Enter Mobile Number",
                    labelStyle: TextStyle(color: Colors.black54),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black26),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff26A69A)),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.05),

                /// Next Button
                SizedBox(
                  width: 280,
                  height: height * 0.06,
                  child: ElevatedButton(
                    onPressed: _loading ? null : () async {
                      final mobile = _emailController.text.trim();

                      if (mobile.length != 10) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Enter valid 10-digit mobile number"),
                          ),
                        );
                        return;
                      }

                      setState(() => _loading = true);

                      bool sent = await AuthApi.sendOtp(mobile);

                      setState(() => _loading = false);

                      if (sent) {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) {
                            return OtpBottomSheet(
                              phoneNumber: mobile,
                            );
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Send OTP failed"),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff26A69A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _loading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Next",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),

                SizedBox(height: height * 0.04),

                /// OR Divider
                Row(
                  children: const [
                    Expanded(child: Divider(color: Colors.black26)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "or continue with",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.black26)),
                  ],
                ),

                SizedBox(height: height * 0.03),

                /// WhatsApp & Mail Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const WhatsappLogin(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.message, color: Colors.green),
                        label: const Text(
                          "WhatsApp",
                          style: TextStyle(color: Colors.black),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xff26A69A)),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.mail_outline,
                          size: 20,
                          color: Color(0xFF26A69A),
                        ),
                        label: const Text(
                          "Via Mail",
                          style: TextStyle(color: Colors.black),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xff26A69A)),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: height * 0.04),

                /// Sign Up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don’t Have an Account? ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignupScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff000080),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: height * 0.06),

                /// Terms
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    text: "By Continuing you agree to our\n",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: "Terms and Conditions",
                        style: TextStyle(
                          color: Color(0xFF2BAE9E),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
