import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/bottom_navbar.dart'; // adjust path if needed
import 'account-state.dart';

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
                    context: context,
                    icon: Icons.person_outline, 
                    label: "Personal Info"),
                _buildOption(
                    context: context,
                    icon: Icons.security, 
                    label: "Security Settings"),
                _buildOption(
                    context: context,
                    icon: Icons.help_outline, 
                    label: "Help Center"),
                const Divider(),
                _buildOption(
                  context: context,
                  icon: Icons.logout, 
                  label: "Log Out",
                  isLogout: true,
                ),
              ],
            ),
          ),
          const BottomNavBar(currentRoute: '/profile'),
        ],
      ),
    );
  }

  Widget _buildOption({
    required BuildContext context,
    required IconData icon, 
    required String label, 
    bool isLogout = false,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.blue[800]),
          title: Text(label),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () async {
            if (isLogout) {
              // Show confirmation dialog
              final shouldLogout = await showDialog<bool>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return Dialog(
                    backgroundColor: Colors.transparent,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Question text
                          const Text(
                            'Are you sure you want to log out?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0A1F44),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          
                          // Log Out button
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1f71fa),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Log Out',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          // Cancel text button
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFF1f71fa),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );

              if (shouldLogout == true) {
                // Perform logout
                final accountState = context.read<AccountState>();
                await accountState.logout();
                
                // Navigate to login page and clear the navigation stack
                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context, 
                    '/login', 
                    (route) => false,
                  );
                }
              }
            } else {
              // Add your navigation or logic here for other options
            }
          },
        ),
        const Divider(height: 0),
      ],
    );
  }
}
