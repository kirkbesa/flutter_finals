import 'package:flutter/material.dart';

class MPINScreen extends StatefulWidget {
  const MPINScreen({super.key});

  @override
  State<MPINScreen> createState() => _MPINScreenState();
}

class _MPINScreenState extends State<MPINScreen> {
  String input = "";
  final String correctMPIN = "1234"; // Change this as needed

  void _handleKeyPress(String value) {
    if (input.length < 4) {
      setState(() {
        input += value;
      });

      if (input.length == 4) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (input == correctMPIN) {
            Navigator.pushReplacementNamed(context, '/home');
          } else {
            _showErrorDialog();
            setState(() {
              input = "";
            });
          }
        });
      }
    }
  }

  void _handleBackspace() {
    if (input.isNotEmpty) {
      setState(() {
        input = input.substring(0, input.length - 1);
      });
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Invalid MPIN"),
        content: const Text("Please try again."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      width: 15,
      height: 15,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: index < input.length ? Colors.blue : Colors.grey[300],
      ),
    );
  }

  Widget _buildKey(String value) {
    return InkWell(
      onTap: () => _handleKeyPress(value),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Text(
          value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildKeyboard() {
    const keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '', '0', '<'];

    return GridView.builder(
      shrinkWrap: true,
      itemCount: keys.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (_, index) {
        String key = keys[index];
        if (key == '') return const SizedBox.shrink();
        if (key == '<') {
          return IconButton(
            icon: const Icon(Icons.backspace),
            onPressed: _handleBackspace,
          );
        }
        return _buildKey(key);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0380FF),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 40),
            Column(
              children: [
                Image.asset('assets/gcash_logo.png', height: 70), // Optional
                const Text(
                  "GCash",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Good Day!",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    "092738039355", // Replace with dynamic value if needed
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, _buildDot),
                ),
                const SizedBox(height: 20),
              ],
            ),
            _buildKeyboard(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text(
                    "Help Center",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    "Forgot MPIN?",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
