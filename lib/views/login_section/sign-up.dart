import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isAgreed = false;
  bool isLoading = false;

  /// Controllers
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController mobileCtrl = TextEditingController();
  final TextEditingController whatsappCtrl = TextEditingController();

  /// API URL
  final String apiUrl = "https://erpsmart.in/total/api/m_api/";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.05),

                /// LOGO
                Image.asset(
                  'assets/logo.png',
                  width: size.width * 0.55,
                  fit: BoxFit.contain,
                ),

                SizedBox(height: size.height * 0.04),

                /// TITLE
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Signup",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  "Create your account",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                /// NAME
                _inputField("Enter Your Name", nameCtrl),
                const SizedBox(height: 16),

                /// EMAIL
                _inputField("Enter Business Email", emailCtrl),
                const SizedBox(height: 16),

                /// MOBILE
                _inputField(
                  "Enter Mobile Number",
                  mobileCtrl,
                  type: TextInputType.phone,
                ),
                const SizedBox(height: 16),

                /// WHATSAPP
                _inputField(
                  "Enter WhatsApp Number",
                  whatsappCtrl,
                  type: TextInputType.phone,
                ),
                const SizedBox(height: 16),

                /// TERMS
                Row(
                  children: [
                    Checkbox(
                      value: _isAgreed,
                      activeColor: const Color(0xFF2BAE9E),
                      onChanged: (value) {
                        setState(() => _isAgreed = value!);
                      },
                    ),
                    const Expanded(
                      child: Text(
                        "I agree to the Terms of Service and Privacy Policy",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                /// BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _signupApiCall,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2BAE9E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          )
                        : const Text(
                            "GET STARTED",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 30),

                /// LOGIN REDIRECT
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(fontSize: 12),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Signin",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF2BAE9E),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// INPUT FIELD (UI UNCHANGED)
  Widget _inputField(
    String hint,
    TextEditingController controller, {
    TextInputType type = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  /// ✅ SIGNUP API CALL (FINAL FIX)
  Future<void> _signupApiCall() async {
    if (!_isAgreed) {
      _showSnack("Please accept terms", false);
      return;
    }

    setState(() => isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final lat = prefs.getDouble('lat')?.toString() ?? "0";
      final lng = prefs.getDouble('lng')?.toString() ?? "0";

      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          "name": nameCtrl.text.trim(),
          "mobile": mobileCtrl.text.trim(),
          "w_number": whatsappCtrl.text.trim(),
          "email": emailCtrl.text.trim(),
          "cid": "21472147",
          "type": "2045",
          "device_id": "123456",
          "ln": lng,
          "lt": lat,
        },
      );

      debugPrint("API RESPONSE => ${response.body}");

      final data = jsonDecode(response.body);

      /// ✅ CORRECT CONDITION FOR YOUR API
      if (data["error"] == false) {
        _showSnack(data["error_msg"] ?? "Signup successful", true);

        Future.delayed(const Duration(milliseconds: 800), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        });
      } else {
        _showSnack(data["error_msg"] ?? "Signup failed", false);
      }
    } catch (e) {
      debugPrint("SIGNUP ERROR => $e");
      _showSnack("Server error", false);
    }

    setState(() => isLoading = false);
  }

  /// SNACKBAR
  void _showSnack(String message, bool success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
