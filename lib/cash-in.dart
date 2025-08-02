import 'package:flutter/material.dart';

class CashIn extends StatefulWidget {
  const CashIn({super.key});

  @override
  State<CashIn> createState() => _CashInState();
}

class _CashInState extends State<CashIn> {
  // ✅ Full list of banks
  final List<Map<String, String>> _banks = [
    {'name': 'Bank of Commerce', 'image': 'bankofcommerce'},
    {'name': 'BDO', 'image': 'bdo'},
    {'name': 'BPI', 'image': 'bpi'},
    {'name': 'China Bank', 'image': 'chinabank'},
    {'name': 'EastWest', 'image': 'eastwest'},
    {'name': 'HSBC', 'image': 'hsbc'},
    {'name': 'LandBank', 'image': 'landbank'},
    {'name': 'MayBank', 'image': 'maybank'},
    {'name': 'MetroBank', 'image': 'metrobank'},
    {'name': 'PBCOM', 'image': 'pbcom'},
    {'name': 'PNB', 'image': 'pnb'},
    {'name': 'PSBank', 'image': 'psbank'},
    {'name': 'RCBC', 'image': 'rcbc'},
    {'name': 'Security Bank', 'image': 'securitybank'},
    {'name': 'UnionBank', 'image': 'unionbank'},
  ];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // ✅ Filtered list based on search text
    final List<Map<String, String>> filteredBanks = _banks
        .where(
          (bank) =>
              bank['name']!.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 10),
        child: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Stack(
            children: [
              Center(
                child: Text(
                  'Cash In',
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

      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            // ✅ Search Bar (updates _searchQuery)
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: const TextStyle(fontFamily: 'Poppins'),
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: const Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
            ),

            // ✅ Scrollable Filtered Bank List
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: filteredBanks.map((bank) {
                    return _bankButton(
                      context: context,
                      name: bank['name']!,
                      imageFileName: bank['image']!,
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _bankButton({
  required BuildContext context,
  required String name,
  required String imageFileName,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    child: GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, '/bpi-cash-in');
      },
      child: Row(
        spacing: 20,
        children: [
          Image(
            image: AssetImage('images/banks/$imageFileName.png'),
            width: 50,
          ),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontFamily: 'Karla',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
