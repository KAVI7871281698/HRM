import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

class CheckOutVerificationScreen extends StatefulWidget {
  const CheckOutVerificationScreen({super.key});

  @override
  State<CheckOutVerificationScreen> createState() =>
      _CheckOutVerificationScreenState();
}

class _CheckOutVerificationScreenState
    extends State<CheckOutVerificationScreen> {
  final TextEditingController outTimeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  String selectedMode = 'Mode of work';
  bool isLoading = false;
  int uid = 4;

  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUid();
    _fetchLocationAndTime();
  }

  Future<void> _fetchLocationAndTime() async {
    // 1. Set Current Time
    final now = DateTime.now();
    outTimeController.text = DateFormat('hh:mm a').format(now);

    // 2. Fetch Location
    setState(() {
      locationController.text = "Fetching location...";
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() => locationController.text = "Location services disabled");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => locationController.text = "Permission denied");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(
          () => locationController.text = "Permission permanently denied",
        );
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Reverse geocoding to get address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address =
            "${place.locality ?? ''}, ${place.subAdministrativeArea ?? ''}"
                .trim();
        if (address.startsWith(',')) address = address.substring(1).trim();
        if (address.endsWith(','))
          address = address.substring(0, address.length - 1).trim();

        setState(() {
          locationController.text = address.isEmpty
              ? "Location found"
              : address;
        });
      } else {
        setState(() => locationController.text = "Address not found");
      }
    } catch (e) {
      debugPrint("LOCATION ERROR => $e");
      setState(() => locationController.text = "Error getting location");
    }
  }

  Future<void> _loadUid() async {
    // API REMOVED: Using local state/defaults
    setState(() {
      uid = 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF26A69A),
        foregroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Check out Verification',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.06,
            vertical: size.height * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Check out Verification',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),

              /// Out Time
              _label('Out Time'),
              _textField(
                controller: outTimeController,
                hint: 'Tap to select time',
                readOnly: true,
                onTap: _pickTime,
                prefixIcon: Icons.access_time_outlined,
              ),
              const SizedBox(height: 14),

              /// Location
              _label('Location'),
              _textField(
                controller: locationController,
                hint: '',
                prefixIcon: Icons.my_location,
              ),
              const SizedBox(height: 14),

              /// Work Mode
              _label('Work Mode'),
              _dropdownField(),
              const SizedBox(height: 18),

              /// Selfie
              _selfieCard(size),
              SizedBox(height: size.height * 0.1),

              /// Submit Button
              Center(
                child: SizedBox(
                  width: size.width * 0.55,
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2AA89A),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    onPressed: isLoading ? null : _submit,
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------- UI Helpers ----------

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    bool readOnly = false,
    VoidCallback? onTap,
    IconData? prefixIcon,
  }) {
    return SizedBox(
      height: 44,
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: const Color(0xFF26A69A), size: 22)
              : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xFF2AA89A)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xFF2AA89A)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xFF2AA89A)),
          ),
        ),
      ),
    );
  }

  Widget _dropdownField() {
    return SizedBox(
      height: 44,
      child: DropdownButtonFormField<String>(
        value: selectedMode,
        items: const [
          DropdownMenuItem(value: 'Mode of work', child: Text('Mode of work')),
          DropdownMenuItem(value: 'Office', child: Text('Office')),
          DropdownMenuItem(
            value: 'Work From Home',
            child: Text('Work From Home'),
          ),
        ],
        onChanged: (value) {
          setState(() {
            selectedMode = value!;
          });
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFD7FFFA),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none,
          ),
        ),
        icon: const Icon(Icons.keyboard_arrow_down),
      ),
    );
  }

  Widget _selfieCard(Size size) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selfie Verification',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Center(
            child: DottedBorder(
              color: Colors.grey.shade400,
              strokeWidth: 1.5,
              dashPattern: const [6, 4],
              borderType: BorderType.RRect,
              radius: const Radius.circular(8),
              child: Container(
                height: size.height * 0.18,
                width: 300,
                child: _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      )
                    : const Center(
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 34,
                          color: Color(0xFF2AA89A),
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: SizedBox(
              height: 38,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2AA89A),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: _takeSelfie,
                icon: const Icon(Icons.camera_alt, size: 16),
                label: Text(
                  _image == null ? 'Take Selfie' : 'Retake Selfie',
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ---------- Actions ----------

  Future<void> _takeSelfie() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 50,
    );

    if (photo != null) {
      setState(() {
        _image = File(photo.path);
      });
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      outTimeController.text = picked.format(context);
    }
  }

  void _submit() async {
    if (outTimeController.text.isEmpty ||
        locationController.text.isEmpty ||
        selectedMode == 'Mode of work' ||
        _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all details and take a selfie'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    // API REMOVED: Simulation success
    await Future.delayed(const Duration(milliseconds: 1000));

    setState(() => isLoading = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Checked out successfully'),
          backgroundColor: Color(0xFF2AA89A),
        ),
      );
      Navigator.pop(context, true);
    }
  }
}