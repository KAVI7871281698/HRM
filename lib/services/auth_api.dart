import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class AuthApi {
  static const String baseUrl =
      "https://erpsmart.in/total/api/m_api/";

  /// SEND OTP
  static Future<bool> sendOtp(String mobile) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final body = {
        "type": "2000",
        "cid": "21472147",
        "lt": (prefs.getDouble('lat') ?? 145).toString(),
        "ln": (prefs.getDouble('lng') ?? 145).toString(),
        "device_id": "12345",
        "mobile": mobile,
      };

      debugPrint("SEND OTP BODY => $body");

      final response = await http.post(
        Uri.parse(baseUrl),
        body: body,
      );

      debugPrint("SEND OTP RESPONSE => ${response.body}");

      final data = json.decode(response.body);

      // ✅ HANDLE MULTIPLE API RESPONSE TYPES
      if (data["status"] == true) return true;
      if (data["error"] == false) return true;
      if (data["success"] == "1") return true;

      return false;
    } catch (e) {
      debugPrint("SEND OTP ERROR => $e");
      return false;
    }
  }

  /// VERIFY OTP
  static Future<bool> verifyOtp({
    required String mobile,
    required String otp,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final body = {
        "type": "2001",
        "cid": "21472147",
        "lt": (prefs.getDouble('lat') ?? 145).toString(),
        "ln": (prefs.getDouble('lng') ?? 145).toString(),
        "device_id": "12345",
        "mobile": mobile,
        "otp": otp,
      };

      debugPrint("VERIFY OTP BODY => $body");

      final response = await http.post(
        Uri.parse(baseUrl),
        body: body,
      );

      debugPrint("VERIFY OTP RESPONSE => ${response.body}");

      final data = json.decode(response.body);

      if (data["status"] == true) return true;
      if (data["error"] == false) return true;
      if (data["success"] == "1") return true;

      return false;
    } catch (e) {
      debugPrint("VERIFY OTP ERROR => $e");
      return false;
    }
  }
}
