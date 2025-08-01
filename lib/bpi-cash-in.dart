import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'account-state.dart';

class BPICashIn extends StatefulWidget {
  const BPICashIn({super.key});

  @override
  State<BPICashIn> createState() => _BPICashInState();
}

class _BPICashInState extends State<BPICashIn> {
  final TextEditingController _amountController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    // ✅ Listen for changes in the text field
    _amountController.addListener(() {
      setState(() {
        _isButtonEnabled = _amountController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color customBlue = Theme.of(context).primaryColor;

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
                  'Cash In via BPI',
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
                    Navigator.pushReplacementNamed(context, '/cash-in');
                  },
                ),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Enter Amount
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 15,
                                children: [
                                  const Image(
                                    image: AssetImage('images/banks/bpi.png'),
                                    width: 150,
                                  ),
                                  const Text(
                                    'Enter Amount',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color.fromARGB(255, 82, 82, 82),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),

                                  // ✅ PHP Row with TextField
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8.0,
                                    ),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'PHP',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            color: Color.fromARGB(
                                              255,
                                              82,
                                              82,
                                              82,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller:
                                                _amountController, // ✅ link controller
                                            textAlign: TextAlign.right,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText: '0.00',
                                              hintStyle: TextStyle(
                                                color: Colors.grey.withOpacity(
                                                  0.5,
                                                ),
                                              ),
                                              border: InputBorder.none,
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                            ),
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                255,
                                                82,
                                                82,
                                                82,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ✅ Bottom Button
                    Column(
                      spacing: 15,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Center(
                            child: Text(
                              'Please ensure your account has enough balance to cover the Cash In amount and convenience fee.',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: _isButtonEnabled
                                ? () {
                                    // ✅ Only triggers when input has value
                                    print(
                                      'NEXT clicked with amount: ${_amountController.text}',
                                    );
                                    context.read<AccountState>().balance += double.tryParse(_amountController.text) ?? 0;
                                    print(
                                      '${context.read<AccountState>().balance}',
                                    );
                                    
                                  }
                                : null, // ✅ disables button when false
                            style: TextButton.styleFrom(
                              backgroundColor: _isButtonEnabled
                                  ? customBlue
                                  : customBlue.withValues(alpha: 0.5),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 20,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: const Text(
                              'NEXT',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
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
    );
  }
}
