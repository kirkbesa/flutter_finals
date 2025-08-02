import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'components/bottom_navbar.dart'; // Adjust if path is different

class QRPage extends StatelessWidget {
  const QRPage({super.key});

  // Replace with dynamic data later
  final String userName = "Keifer Watson";
  final String userNumber = "09273803935";
  final String qrData = "GCASH-USER-ID-123456"; // Could be your user ID or phone

  @override
  Widget build(BuildContext context) {
    Color customBlue = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 10),
        child: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Stack(
            children: [
              Center(
                child: Text(
                  'Generate QR',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                ),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      body: Container(color: Colors.white, child: Column(
        children: [
          const SizedBox(height: 30),
          CircleAvatar(
            radius: 40,
            backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.20),
            child: Icon(Icons.person, size: 40, color: Theme.of(context).primaryColor),
          ),
          const SizedBox(height: 10),
          Text(
            userName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
          ),
          Text(
            userNumber,
            style: TextStyle(fontSize: 14, color: Colors.grey[700], fontFamily: 'Poppins'),
          ),
          const SizedBox(height: 30),
          QrImageView(
            data: qrData,
            version: QrVersions.auto,
            size: 250.0,
            backgroundColor: Colors.white,
          ),
          const SizedBox(height: 20),
          const Text(
            "Scan this QR to send me money",
            style: TextStyle(fontSize: 16, color: Colors.grey, fontFamily: 'Poppins'),
          ),
          const Spacer(),
          const BottomNavBar(currentRoute: '/qr'),
        ],
      ),
      ),
    );
  }
}
