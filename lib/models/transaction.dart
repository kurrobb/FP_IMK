class Transaction {
  final String id;
  final String merchantName;
  final String category;
  final String time;
  final double amount;
  final bool isDebit;
  final String iconPath;

  const Transaction({
    required this.id,
    required this.merchantName,
    required this.category,
    required this.time,
    required this.amount,
    required this.isDebit,
    required this.iconPath,
  });
}

class DummyData {
  static const List<Transaction> todayTransactions = [
    Transaction(
      id: '1',
      merchantName: 'Whole Groceries',
      category: 'Groceries',
      time: '10:42 AM',
      amount: 142500,
      isDebit: true,
      iconPath: 'grocery',
    ),
    Transaction(
      id: '2',
      merchantName: 'Netflix',
      category: 'Entertainment',
      time: '09:15 AM',
      amount: 54000,
      isDebit: true,
      iconPath: 'entertainment',
    ),
    Transaction(
      id: '3',
      merchantName: 'Transfer Masuk',
      category: 'Transfer',
      time: '08:00 AM',
      amount: 500000,
      isDebit: false,
      iconPath: 'transfer',
    ),
  ];

  static const List<Transaction> yesterdayTransactions = [
    Transaction(
      id: '4',
      merchantName: 'Kopi Kenangan',
      category: 'Food & Drink',
      time: '02:30 PM',
      amount: 35000,
      isDebit: true,
      iconPath: 'food',
    ),
    Transaction(
      id: '5',
      merchantName: 'PLN Token',
      category: 'Tagihan',
      time: '11:00 AM',
      amount: 200000,
      isDebit: true,
      iconPath: 'bills',
    ),
    Transaction(
      id: '6',
      merchantName: 'Gojek',
      category: 'Transport',
      time: '09:45 AM',
      amount: 28000,
      isDebit: true,
      iconPath: 'transport',
    ),
    Transaction(
      id: '7',
      merchantName: 'Transfer Masuk',
      category: 'Transfer',
      time: '08:10 AM',
      amount: 1000000,
      isDebit: false,
      iconPath: 'transfer',
    ),
  ];

  static const String accountNumber = '1234 5678 9012';
  static const String accountName = 'Ahmad Fadhil';
  static const double balance = 4820500;
}
