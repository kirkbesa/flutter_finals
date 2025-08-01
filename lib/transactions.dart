import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/bottom_navbar.dart';
import 'account-state.dart';
import 'models/user.dart';
import 'services/api_service.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  List<Transaction> _transactions = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final transactions = await ApiService.getTransactions();
      
      // If no transactions, load sample data for testing
      if (transactions.isEmpty) {
        setState(() {
          _transactions = _getSampleTransactions();
          _isLoading = false;
        });
      } else {
        setState(() {
          _transactions = transactions;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
        // Load sample data on error for testing
        _transactions = _getSampleTransactions();
      });
    }
  }

  List<Transaction> _getSampleTransactions() {
    final now = DateTime.now();
    return [
      Transaction(
        id: '1',
        type: 'send',
        amount: -100.00,
        description: 'Send Money',
        timestamp: now.subtract(const Duration(hours: 2)),
      ),
      Transaction(
        id: '2',
        type: 'send',
        amount: -492.00,
        description: 'Send Money',
        timestamp: now.subtract(const Duration(hours: 14)),
      ),
      Transaction(
        id: '3',
        type: 'send',
        amount: -175.00,
        description: 'Send Money',
        timestamp: now.subtract(const Duration(days: 1, hours: 2)),
      ),
      Transaction(
        id: '4',
        type: 'send',
        amount: -100.00,
        description: 'Send Money',
        timestamp: now.subtract(const Duration(days: 2, hours: 8)),
      ),
      Transaction(
        id: '5',
        type: 'receive',
        amount: 245.00,
        description: 'Receive Money',
        timestamp: now.subtract(const Duration(days: 2, hours: 10)),
      ),
      Transaction(
        id: '6',
        type: 'qr-payment',
        amount: -245.00,
        description: 'Pay via Scanned QR',
        timestamp: now.subtract(const Duration(days: 2, hours: 13)),
      ),
    ];
  }

  String _getDateHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final transactionDate = DateTime(date.year, date.month, date.day);

    if (transactionDate == today) {
      return 'Today';
    } else if (transactionDate == yesterday) {
      return 'Yesterday';
    } else {
      return '${_getMonthName(date.month)} ${date.day}, ${date.year}';
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  String _formatTime(DateTime time) {
    final hour = time.hour;
    final minute = time.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    return '${displayHour}:${minute.toString().padLeft(2, '0')} $period';
  }

  String _getTransactionDescription(Transaction transaction) {
    switch (transaction.type) {
      case 'send':
        return 'Send Money';
      case 'receive':
        return 'Receive Money';
      case 'cash-in':
        return 'Cash In';
      case 'qr-payment':
        return 'Pay via Scanned QR';
      default:
        return transaction.description ?? 'Transaction';
    }
  }

  bool _isDebitTransaction(Transaction transaction) {
    // Check if amount is negative (from backend) or if it's a send/qr-payment type
    return transaction.amount < 0 || 
           transaction.type == 'send' || 
           transaction.type == 'qr-payment';
  }

  String _formatAmount(Transaction transaction) {
    final isDebit = _isDebitTransaction(transaction);
    final absAmount = transaction.amount.abs();
    final prefix = isDebit ? '-' : '+';
    return '$prefix${absAmount.toStringAsFixed(2)}';
  }

  Map<String, List<Transaction>> _groupTransactionsByDate() {
    final grouped = <String, List<Transaction>>{};
    
    for (final transaction in _transactions) {
      final dateHeader = _getDateHeader(transaction.timestamp);
      if (!grouped.containsKey(dateHeader)) {
        grouped[dateHeader] = [];
      }
      grouped[dateHeader]!.add(transaction);
    }

    // Sort transactions within each group by timestamp (newest first)
    for (final key in grouped.keys) {
      grouped[key]!.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final groupedTransactions = _groupTransactionsByDate();
    final sortedDates = groupedTransactions.keys.toList()
      ..sort((a, b) {
        // Custom sorting: Today, Yesterday, then by date
        if (a == 'Today') return -1;
        if (b == 'Today') return 1;
        if (a == 'Yesterday') return -1;
        if (b == 'Yesterday') return 1;
        return b.compareTo(a); // For other dates, sort descending
      });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          Container(
            color: Colors.blue,
            child: SafeArea(
              child: Column(
                children: [
                  // Main header
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: const Text(
                      'Transaction History',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Sub header with date and icons
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'As of ${_getMonthName(DateTime.now().month)} ${DateTime.now().day}, ${DateTime.now().year}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.filter_list,
                              color: Colors.blue[300],
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Icon(
                              Icons.access_time,
                              color: Colors.blue[300],
                              size: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Transaction list
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _error != null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Error loading transactions',
                              style: TextStyle(color: Colors.red[600]),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: _loadTransactions,
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : _transactions.isEmpty
                        ? const Center(
                            child: Text(
                              'No transactions found',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: _loadTransactions,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: sortedDates.length,
                              itemBuilder: (context, index) {
                                final date = sortedDates[index];
                                final transactions = groupedTransactions[date]!;
                                
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Date header
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      child: Text(
                                        date,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    // Transactions for this date
                                    ...transactions.map((transaction) {
                                      final isDebit = _isDebitTransaction(transaction);
                                      final amountColor = isDebit ? Colors.red[600] : Colors.green[600];
                                      final amountPrefix = isDebit ? '-' : '+';
                                      
                                      return Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey[200]!,
                                              width: 0.5,
                                            ),
                                          ),
                                        ),
                                        child: ListTile(
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 4,
                                          ),
                                          leading: Text(
                                            _formatTime(transaction.timestamp),
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 12,
                                            ),
                                          ),
                                          title: Text(
                                            _getTransactionDescription(transaction),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          trailing: Text(
                                            _formatAmount(transaction),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: amountColor,
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ],
                                );
                              },
                            ),
                          ),
          ),
          const BottomNavBar(currentRoute: '/transactions'),
        ],
      ),
    );
  }
}
