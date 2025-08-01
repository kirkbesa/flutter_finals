import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final String currentRoute;

  const BottomNavBar({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 100,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(
                context,
                icon: Icons.home_outlined,
                label: 'Home',
                route: '/home',
                isActive: currentRoute == '/home',
              ),
              _buildNavItemWithNotification(
                context,
                icon: Icons.mail_outline_rounded,
                label: 'Inbox',
                route: '/inbox',
                isActive: currentRoute == '/inbox',
              ),
              _buildNavItem(
                context,
                icon: Icons.qr_code_scanner_rounded,
                label: 'QR',
                route: '/qr',
                isActive: currentRoute == '/qr',
                isCenter: true,
              ),
              _buildNavItem(
                context,
                icon: Icons.receipt_long_rounded,
                label: 'Transactions',
                route: '/transactions',
                isActive: currentRoute == '/transactions',
              ),
              _buildNavItem(
                context,
                icon: Icons.person,
                label: 'Profile',
                route: '/profile',
                isActive: currentRoute == '/profile',
              ),
            ],
          ),
        ),
        // QR Icon with circle and outline
        Positioned(
          bottom: 50,
          left: MediaQuery.of(context).size.width / 2 - 40,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: Colors.blue, width: 3.0),
            ),
            child: IconButton(
              icon: Icon(
                Icons.qr_code_scanner_rounded,
                color: Colors.blue.withOpacity(1),
                size: 30,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/qr');
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String route,
    required bool isActive,
    bool isCenter = false,
  }) {
    final alphaValue = isActive ? 1.0 : 0.5;
    Color customBlue = Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, route);
      },
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isCenter
                ? Colors.white
                : customBlue.withValues(alpha: alphaValue),
            size: isCenter ? 40 : 30,
          ),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              color: customBlue.withValues(alpha: alphaValue),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItemWithNotification(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String route,
    required bool isActive,
    bool isCenter = false,
  }) {
    final alphaValue = isActive ? 1.0 : 0.5;
    Color customBlue = Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, route);
      },
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Icon(
                icon,
                color: isCenter
                    ? Colors.white
                    : customBlue.withValues(alpha: alphaValue),
                size: isCenter ? 40 : 30,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              color: customBlue.withValues(alpha: alphaValue),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
