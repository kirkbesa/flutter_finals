import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'account-state.dart';
import 'services/api_service.dart';

class SendMoney extends StatefulWidget {
  const SendMoney({super.key});

  @override
  State<SendMoney> createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _isPhoneValid = false;
  bool _showPhoneError = false;
  bool _showAmountField = false;
  bool _showNextButton = false;
  bool _showAmountError = false;
  String _amountErrorMessage = '';

  @override
  void initState() {  
    super.initState();
    _phoneController.addListener(_validatePhone);
    _amountController.addListener(_validateAmount);
  }

  void _validatePhone() {
    String phone = _phoneController.text;
    bool isValid =
        phone.length == 10 &&
        phone.startsWith('9') &&
        RegExp(r'^\d+$').hasMatch(phone);

    setState(() {
      _isPhoneValid = isValid;
      _showPhoneError = phone.isNotEmpty && !isValid;
      _showAmountField = isValid;
      if (!isValid) {
        _showNextButton = false;
        _showAmountError = false;
        _amountErrorMessage = '';
        _amountController.clear();
      }
    });
  }

  void _validateAmount() {
    String amount = _amountController.text;
    bool hasValidAmount = false;

    setState(() {
      if (amount.isEmpty) {
        _showAmountError = false;
        _amountErrorMessage = '';
      } else {
        double? parsedAmount = double.tryParse(amount);
        if (parsedAmount == null || parsedAmount <= 0) {
          _showAmountError = true;
          _amountErrorMessage = 'Amount cannot be 0';
        } else if (parsedAmount > Provider.of<AccountState>(context, listen: false).balance) {
          _showAmountError = true;
          _amountErrorMessage = 'The amount exceeds your balance.';
        } else {
          _showAmountError = false;
          _amountErrorMessage = '';
          hasValidAmount = true;
        }
      }

      _showNextButton = _isPhoneValid && hasValidAmount;
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
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
                  'Express Send',
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

      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Ad
                        const Image(
                          image: AssetImage('images/ads/sendmoneyad.jpg'),
                          width: double.infinity,
                        ),
                        const SizedBox(height: 20),

                        // Phone Number Section
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Send to',
                              style: TextStyle(
                                color: Color(0xFF182a4f),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(height: 10),

                            // Phone Input Row
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: _showPhoneError
                                      ? Colors.red
                                      : const Color(0xFFdee4e9),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  // LEFT SECTION (Flag + Dropdown)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          color: _showPhoneError
                                              ? Colors.red
                                              : const Color(0xFFdee4e9),
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    child: const Row(
                                      children: [
                                        Image(
                                          image: AssetImage(
                                            'images/phflag.png',
                                          ),
                                          width: 24,
                                          height: 24,
                                        ),
                                        SizedBox(width: 6),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),

                                  // RIGHT SECTION (Input + Contact Icon)
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 4,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller: _phoneController,
                                              keyboardType:
                                                  TextInputType.number,
                                              maxLength: 10,
                                              decoration: InputDecoration(
                                                hintText:
                                                    'Enter name or number',
                                                hintStyle: TextStyle(
                                                  color: Colors.grey
                                                      .withValues(alpha: 0.7),
                                                ),
                                                border: InputBorder.none,
                                                counterText:
                                                    '', // Hide character counter
                                              ),
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.contact_page_outlined,
                                            color: customBlue,
                                            size: 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Error message
                            if (_showPhoneError)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  'Please enter a valid number',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Amount Section (appears when phone is valid)
                        if (_showAmountField) ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Amount',
                                style: TextStyle(
                                  color: Color(0xFF182a4f),
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Amount Input Field
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: _showAmountError
                                        ? Colors.red
                                        : const Color(0xFFdee4e9),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        '₱',
                                        style: TextStyle(
                                          color: customBlue,
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: TextField(
                                          controller: _amountController,
                                          keyboardType:
                                              const TextInputType.numberWithOptions(
                                                decimal: true,
                                              ),
                                          decoration: const InputDecoration(
                                            hintText: '0.00',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Amount Error message
                              if (_showAmountError)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    _amountErrorMessage,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),

                              // Available Balance
                              if (!_showAmountError)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    'Available Balance: PHP ${context.watch<AccountState>().balance.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ] else ...[
                          // QR Section (shows when amount field is not visible)
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, '/qr');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.qr_code_scanner_rounded,
                                  size: 30,
                                  color: customBlue,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Scan/Upload QR',
                                  style: TextStyle(
                                    color: customBlue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Next Button (fixed to bottom)
          if (_showNextButton)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      _validateAmount(); // Re-validate the amount
                    
                      // Only proceed if there is no amount error and the button should be shown
                      if (!_showAmountError && _showNextButton) {
                        final recipient = _phoneController.text;
                        final amount = double.tryParse(_amountController.text) ?? 0;
                        final scaffoldMessenger = ScaffoldMessenger.of(context);
                        final navigator = Navigator.of(context);
                        final accountState = context.read<AccountState>();
                        
                        try {
                          // Show loading dialog
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return const AlertDialog(
                                content: Row(
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(width: 20),
                                    Text("Sending money..."),
                                  ],
                                ),
                              );
                            },
                          );

                          // Call send money API
                          print('Calling send money API with recipient: $recipient, amount: $amount');
                          final result = await ApiService.sendMoney(recipient, amount, 'Send Money');
                          print('Send money API result: $result');
                          
                          // Check if widget is still mounted before using context
                          if (!mounted) return;
                          
                          // Update local state
                          accountState.balance = result['newBalance'];
                          
                          // Close loading dialog
                          navigator.pop();
                          
                          // Show success message
                          scaffoldMessenger.showSnackBar(
                            SnackBar(
                              content: Text('Successfully sent PHP ${amount.toStringAsFixed(2)} to $recipient'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          
                          // Navigate back to home
                          navigator.pushReplacementNamed('/home');
                          
                        } catch (e) {
                          // Check if widget is still mounted before using context
                          if (!mounted) return;
                          
                          // Close loading dialog
                          navigator.pop();
                          
                          // Show error message
                          scaffoldMessenger.showSnackBar(
                            SnackBar(
                              content: Text('Error: ${e.toString()}'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: customBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
