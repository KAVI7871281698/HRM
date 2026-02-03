import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hrm/views/main_root.dart';
import '../login_section/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isAgreed = false;

  @override
  void initState() {
    super.initState();
    _saveLocation();
  }

  /// SAVE LATITUDE & LONGITUDE 
  Future<void> _saveLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('lat', position.latitude);
    await prefs.setDouble('lng', position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.05),

                /// LOGO
                Center(
                  child: Image.asset(
                    'assets/logo.png',
                    width: width * 0.55,
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: height * 0.04),

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

                SizedBox(height: height * 0.005),

                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Create your account",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                SizedBox(height: height * 0.03),

                /// NAME
                _inputField("Enter Your Name"),

                SizedBox(height: height * 0.02),

                /// EMAIL
                _inputField("Enter Business Email"),

                SizedBox(height: height * 0.02),

                /// MOBILE
                _inputField(
                  "Enter Mobile Number",
                  keyboardType: TextInputType.phone,
                ),

                SizedBox(height: height * 0.02),

                /// WHATSAPP
                _inputField(
                  "Enter WhatsApp Number",
                  keyboardType: TextInputType.phone,
                ),

                SizedBox(height: height * 0.02),

                /// TERMS CHECKBOX
                Row(
                  children: [
                    Checkbox(
                      value: _isAgreed,
                      activeColor: const Color(0xFF2BAE9E),
                      onChanged: (value) {
                        setState(() {
                          _isAgreed = value!;
                        });
                      },
                    ),
                    Expanded(
                      child: RichText(
                        text: const TextSpan(
                          text: "I agree to the ",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                          children: [
                            TextSpan(
                              text: "Terms of Service ",
                              style: TextStyle(
                                color: Color(0xFF2BAE9E),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(text: "and "),
                            TextSpan(
                              text: "Privacy Policy",
                              style: TextStyle(
                                color: Color(0xFF2BAE9E),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: height * 0.02),

                /// GET STARTED BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_isAgreed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text("Please accept terms & conditions"),
                          ),
                        );
                        return;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainRoot(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2BAE9E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "GET STARTED",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.03),

                /// SOCIAL LOGIN
                const Text(
                  "or Signup with",
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),

                SizedBox(height: height * 0.02),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/google.png',
                      width: 36,
                      height: 36,
                    ),
                    const SizedBox(width: 20),
                    Image.asset(
                      'assets/apple.png',
                      width: 48,
                      height: 48,
                    ),
                  ],
                ),

                SizedBox(height: height * 0.03),

                /// ALREADY HAVE ACCOUNT
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
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

                SizedBox(height: height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// INPUT FIELD (UNCHANGED UI)
  Widget _inputField(
    String hint, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colors.black26),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Color(0xFF2BAE9E)),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }
}
