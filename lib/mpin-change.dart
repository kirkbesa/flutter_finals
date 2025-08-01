import 'package:flutter/material.dart';
import 'services/api_service.dart';

class MPINChangeScreen extends StatefulWidget {
  const MPINChangeScreen({super.key});

  @override
  State<MPINChangeScreen> createState() => _MPINChangeScreenState();
}

class _MPINChangeScreenState extends State<MPINChangeScreen> {
  String currentMpin = "";
  String newMpin = "";
  String confirmMpin = "";
  bool isLoading = false;
  bool isCurrentMpinComplete = false;
  bool isNewMpinComplete = false;
  bool isConfirmMpinComplete = false;
  String currentStep = "current"; // "current", "new", "confirm"

  void _handleKeyPress(String value) {
    if (currentStep == "current" && currentMpin.length < 4) {
      setState(() {
        currentMpin += value;
        isCurrentMpinComplete = currentMpin.length == 4;
      });
    } else if (currentStep == "new" && newMpin.length < 4) {
      setState(() {
        newMpin += value;
        isNewMpinComplete = newMpin.length == 4;
      });
    } else if (currentStep == "confirm" && confirmMpin.length < 4) {
      setState(() {
        confirmMpin += value;
        isConfirmMpinComplete = confirmMpin.length == 4;
      });
    }
  }

  void _handleBackspace() {
    if (currentStep == "current" && currentMpin.isNotEmpty) {
      setState(() {
        currentMpin = currentMpin.substring(0, currentMpin.length - 1);
        isCurrentMpinComplete = currentMpin.length == 4;
      });
    } else if (currentStep == "new" && newMpin.isNotEmpty) {
      setState(() {
        newMpin = newMpin.substring(0, newMpin.length - 1);
        isNewMpinComplete = newMpin.length == 4;
      });
    } else if (currentStep == "confirm" && confirmMpin.isNotEmpty) {
      setState(() {
        confirmMpin = confirmMpin.substring(0, confirmMpin.length - 1);
        isConfirmMpinComplete = confirmMpin.length == 4;
      });
    }
  }

  void _nextStep() {
    if (currentStep == "current" && isCurrentMpinComplete) {
      setState(() {
        currentStep = "new";
      });
    } else if (currentStep == "new" && isNewMpinComplete) {
      setState(() {
        currentStep = "confirm";
      });
    } else if (currentStep == "confirm" && isConfirmMpinComplete) {
      _changeMpin();
    }
  }

  Future<void> _changeMpin() async {
    if (newMpin != confirmMpin) {
      _showErrorDialog("New MPINs don't match. Please try again.");
      setState(() {
        confirmMpin = "";
        isConfirmMpinComplete = false;
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await ApiService.changeMpin(currentMpin, newMpin);
      _showSuccessDialog();
    } catch (e) {
      _showErrorDialog(e.toString().replaceAll('Exception: ', ''));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Success"),
        content: const Text("MPIN changed successfully!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index, String mpin) {
    return Container(
      width: 15,
      height: 15,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: index < mpin.length ? Colors.blue : Colors.grey[300],
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
              offset: const Offset(2, 2),
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
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
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

  String _getStepTitle() {
    switch (currentStep) {
      case "current":
        return "Enter Current MPIN";
      case "new":
        return "Enter New MPIN";
      case "confirm":
        return "Confirm New MPIN";
      default:
        return "Change MPIN";
    }
  }

  String _getCurrentMpin() {
    switch (currentStep) {
      case "current":
        return currentMpin;
      case "new":
        return newMpin;
      case "confirm":
        return confirmMpin;
      default:
        return "";
    }
  }

  bool _canProceed() {
    switch (currentStep) {
      case "current":
        return isCurrentMpinComplete;
      case "new":
        return isNewMpinComplete;
      case "confirm":
        return isConfirmMpinComplete;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0380FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0380FF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Change MPIN",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 40),
            Column(
              children: [
                Image.asset(
                  'images/logo_horizontal_white.png',
                  height: 70,
                ),
                const SizedBox(height: 30),
                Text(
                  _getStepTitle(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) => _buildDot(index, _getCurrentMpin())),
                ),
                const SizedBox(height: 20),
                if (_canProceed())
                  ElevatedButton(
                    onPressed: isLoading ? null : _nextStep,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF0380FF),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0380FF)),
                            ),
                          )
                        : const Text(
                            "Next",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                  ),
              ],
            ),
            _buildKeyboard(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
} 