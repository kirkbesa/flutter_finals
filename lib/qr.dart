import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'components/bottom_navbar.dart'; // Adjust if path is different

class QRPage extends StatelessWidget {
  const QRPage({super.key});

  // Replace with dynamic data later
  final String userName = "Keifer Watson";
  final String userNumber = "092738039355";
  final String qrData = "GCASH-USER-ID-123456"; // Could be your user ID or phone

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: const Text("My QR"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blue[100],
            child: Icon(Icons.person, size: 40, color: Colors.blue[900]),
          ),
          const SizedBox(height: 10),
          Text(
            userName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            userNumber,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
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
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const Spacer(),
          const BottomNavBar(currentRoute: '/qr'),
        ],
      ),
    );
  }
}
