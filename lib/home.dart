import 'package:flutter/material.dart';
import 'components/bottom_navbar.dart';
import 'package:provider/provider.dart';
import 'account-state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NavBar and Box Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Color customBlue = Theme.of(context).primaryColor;

    return Scaffold(
      body: Column(
        children: [
          // Content area (will take the remaining space)
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                color: customBlue.withValues(alpha: 0.05),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsetsGeometry.all(20),
                      // First Box
                      child: Column(
                        children: [
                          // Logo
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Image(
                                image: AssetImage('images/logo_horizontal.png'),
                                width: 150,
                              ),
                            ],
                          ),
                          // Tabs
                          Row(
                            children: [
                              _homeTabs(
                                context: context,
                                label: 'Wallet',
                                isHighlighted: true,
                              ),
                              _homeTabs(
                                context: context,
                                label: 'Save',
                                isHighlighted: false,
                              ),
                              _homeTabs(
                                context: context,
                                label: 'Borrow',
                                isHighlighted: false,
                              ),
                              _homeTabs(
                                context: context,
                                label: 'Grow',
                                isHighlighted: false,
                              ),
                            ],
                          ),
                          // Balance
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(color: customBlue),
                                  child: Padding(
                                    padding: EdgeInsetsGeometry.fromLTRB(
                                      20,
                                      20,
                                      20,
                                      10,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          spacing: 10,
                                          children: [
                                            Text(
                                              'AVAILABLE BALANCE',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white.withValues(alpha: 0.5),
                                                fontSize: 14,
                                              ),
                                            ),
                                            Icon(
                                              Icons.remove_red_eye_outlined,
                                              size: 18,
                                              color: Colors.white.withValues(alpha: 0.5),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '₱ ${context.watch<AccountState>().balance.toStringAsFixed(2)}',
                                              style: TextStyle(
                                                fontFamily: 'Karla',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                                fontSize: 40,
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pushReplacementNamed(
                                                  context,
                                                  '/cash-in',
                                                );
                                              },
                                              style: TextButton.styleFrom(
                                                backgroundColor: Colors.white,
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsGeometry.all(
                                                  10,
                                                ),
                                                child: Text(
                                                  '+ Cash In',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    color: customBlue,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Buttons
                          Container(
                            decoration: BoxDecoration(color: Colors.white),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    _featureButton(
                                      context: context,
                                      label: 'Send',
                                      icon: Icons.payments_rounded,
                                      onClick: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          '/send-money',
                                        );
                                      },
                                    ),
                                    _featureButton(
                                      context: context,
                                      label: 'Load',
                                      icon: Icons.add_to_home_screen_rounded,
                                    ),
                                    _featureButton(
                                      context: context,
                                      label: 'Transfer',
                                      icon: Icons.account_balance_rounded,
                                    ),
                                    _featureButton(
                                      context: context,
                                      label: 'Bills',
                                      icon: Icons.request_quote_outlined,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    _featureButton(
                                      context: context,
                                      label: 'Borrow',
                                      icon: Icons.real_estate_agent_outlined,
                                    ),
                                    _featureButton(
                                      context: context,
                                      label: 'GSave',
                                      icon: Icons.savings_outlined,
                                    ),
                                    _featureButton(
                                      context: context,
                                      label: 'GInvest',
                                      icon: Icons.spa_outlined,
                                    ),
                                    _featureButton(
                                      context: context,
                                      label: 'View All',
                                      icon: Icons.more_horiz_rounded,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Padding(
                        padding: EdgeInsetsGeometry.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 20,
                          children: [
                            Text(
                              'Explore the App',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                color: customBlue,
                                fontSize: 18,
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                spacing: 30,
                                children: [
                                  _exploreButtons(
                                    context: context,
                                    label: 'GInsure',
                                    icon: Icons.safety_check_rounded,
                                  ),
                                  _exploreButtons(
                                    context: context,
                                    label: 'GLife',
                                    icon: Icons.g_mobiledata_rounded,
                                  ),
                                  _exploreButtons(
                                    context: context,
                                    label: 'Cards',
                                    icon: Icons.credit_card,
                                  ),
                                  _exploreButtons(
                                    context: context,
                                    label: 'GForest',
                                    icon: Icons.energy_savings_leaf_outlined,
                                  ),
                                  _exploreButtons(
                                    context: context,
                                    label: 'Travel',
                                    icon: Icons.travel_explore_rounded,
                                  ),
                                  _exploreButtons(
                                    context: context,
                                    label: 'Food Hub',
                                    icon: Icons.food_bank_rounded,
                                  ),
                                  _exploreButtons(
                                    context: context,
                                    label: 'Shop',
                                    icon: Icons.shopping_basket_outlined,
                                  ),
                                  _exploreButtons(
                                    context: context,
                                    label: 'GJobs',
                                    icon: Icons.cases_rounded,
                                  ),
                                  _exploreButtons(
                                    context: context,
                                    label: 'GDeals',
                                    icon: Icons.discount_outlined,
                                  ),
                                ],
                              ),
                            ),
                            // Ad
                            Container(
                              width: double.infinity,
                              height: 500,
                              decoration: BoxDecoration(
                                color: customBlue,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Navbar with 5 icons
          const BottomNavBar(currentRoute: '/home'),
        ],
      ),
    );
  }
}

Widget _exploreButtons({
  required BuildContext context,
  required String label,
  required IconData icon,
}) {
  Color customBlue = Theme.of(context).primaryColor;

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        decoration: BoxDecoration(
          color: customBlue.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: Icon(icon, color: customBlue, size: 30),
        ),
      ),
      Text(
        label,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          color: customBlue,
          fontSize: 14,
        ),
      ),
    ],
  );
}

Widget _homeTabs({
  required BuildContext context,
  required String label,
  required bool isHighlighted,
}) {
  Color customBlue = Theme.of(context).primaryColor;

  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        color: isHighlighted ? customBlue : Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              color: isHighlighted ? Colors.white : customBlue,
              fontSize: 14,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _featureButton({
  required BuildContext context,
  required String label,
  required IconData icon,
  VoidCallback? onClick,
}) {
  Color customBlue = Theme.of(context).primaryColor;

  return Expanded(
    child: Padding(
      padding: EdgeInsetsGeometry.only(top: 20, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          GestureDetector(
            onTap: onClick,
            child: Icon(icon, color: customBlue, size: 40),
          ),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              color: customBlue,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ),
  );
}
