import 'package:flutter/material.dart';
import '../components/bottom_navbar.dart'; // adjust path if needed

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            color: Colors.blue[800],
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50, color: Colors.grey[700]),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Keifer Watson",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "092738039355",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 10),
                _buildOption(
                    icon: Icons.person_outline, label: "Personal Info"),
                _buildOption(icon: Icons.security, label: "Security Settings"),
                _buildOption(icon: Icons.help_outline, label: "Help Center"),
                const Divider(),
                _buildOption(icon: Icons.logout, label: "Log Out"),
              ],
            ),
          ),
          const BottomNavBar(currentRoute: '/profile'),
        ],
      ),
    );
  }

  Widget _buildOption({required IconData icon, required String label}) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.blue[800]),
          title: Text(label),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            // Add your navigation or logic here
          },
        ),
        const Divider(height: 0),
      ],
    );
  }
}
