import 'package:flutter/material.dart';
import 'components/bottom_navbar.dart';

class Inbox extends StatefulWidget {
  const Inbox({super.key});

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  String activeTab = 'Chats'; // Default active tab

  @override
  Widget build(BuildContext context) {
    Color customBlue = Theme.of(context).primaryColor;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: customBlue.withValues(alpha: 0.05),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ✅ Inbox header
                  Container(
                    color: customBlue,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: const Text(
                      'Inbox',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  // ✅ Tabs Section
                  Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildTab('Chats', customBlue),
                        _buildTab('Notifications', customBlue),
                      ],
                    ),
                  ),

                  // ✅ Content changes based on active tab
                  Container(
                    child: activeTab == 'Chats'
                        ? _chatsContent(customBlue)
                        : Expanded(child: _notificationsContent(customBlue)),
                  ),
                ],
              ),
            ),
          ),
          const BottomNavBar(currentRoute: '/inbox'),
        ],
      ),
    );
  }

  // ✅ Tab Builder Widget
  Widget _buildTab(String tabName, Color customBlue) {
    bool isActive = activeTab == tabName;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            activeTab = tabName;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? customBlue : Colors.transparent,
                width: 4,
              ),
            ),
          ),
          child: Center(
            child: Text(
              tabName,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: isActive ? customBlue : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _notificationsContent(Color customBlue) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            _notification(
              customBlue,
              'May ₱50 donut? May ₱50 fund!',
              'Investing in GFunds is as easy as buyin...',
              'a few hours ago',
            ),
            _notification(
              customBlue,
              'Protektado ka sa commute!',
              'Avail BPI PasaHERO Protect via GInsur...',
              'a few hours ago',
            ),
            _notification(
              customBlue,
              'Express Send Notification',
              'You have received PHP 580.00 of GCash fr...',
              'a few hours ago',
            ),
            _notification(
              customBlue,
              'Online Payment Successful!',
              'Your payment of P1,102.00 to Shopee Phil...',
              'a few hours ago',
            ),
            _notification(
              customBlue,
              'Express Send Notification',
              'You have sent PHP 90.00 to SH****E KI***...',
              'yesterday 8:00 PM',
            ),
            _notification(
              customBlue,
              'Side hustle na \'di hassle?',
              'Kayang kaya yan with GFunds! Kumita...',
              'yesterday 3:12 PM',
            ),
            _notification(
              customBlue,
              'Protektado ka sa commute!',
              'Avail BPI PasaHERO Protect via GInsur...',
              'yesterday 11:00 AM',
            ),
            _notification(
              customBlue,
              'No worries sa future ng anak!',
              'Secured na ang education niya with...',
              'Jul 30, 2025',
            ),
            _notification(
              customBlue,
              'Save ₱50K, earn 8% p.a.! 💸',
              'Deposit at least ₱50,000 and enjoy 8% p.a...',
              'Jul 29, 2025',
            ),
            _notification(
              customBlue,
              'Express Send Notification',
              'You have received PHP 580.00 of GCash fr...',
              'Jul 28, 2025',
            ),
            _notification(
              customBlue,
              'Online Payment Successful!',
              'Your payment of P1,102.00 to Shopee Phil...',
              'Jul 27, 2025',
            ),
            _notification(
              customBlue,
              'Express Send Notification',
              'You have sent PHP 90.00 to SH****E KI***...',
              'Jul 27, 2025',
            ),
            _notification(
              customBlue,
              'Express Send Notification',
              'You have received PHP 925.00 of GCash fr...',
              'Jul 26, 2025',
            ),
          ],
        ),
      ),
    );
  }

  Widget _notification(
    Color customBlue,
    String title,
    String description,
    String timestamp,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 15, horizontal: 20),
        child: Expanded(
          child: Row(
            spacing: 20,
            children: [
              Icon(Icons.mail_outline_rounded, size: 25, color: customBlue),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 20,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 5,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: customBlue,
                          ),
                        ),
                        Text(
                          description,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      timestamp,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chatsContent(Color customBlue) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        color: Colors.white,
        child: Center(
          child: Column(
            spacing: 15,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              Text(
                'Welcome to GChat!',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: customBlue,
                ),
              ),
              // SubHeader
              Text(
                'GChat allows you to chat and transact with your contacts. Would you like to enable this feature?',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              // Enable GChat Button
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: customBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: Text(
                  'Enable GChat',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
