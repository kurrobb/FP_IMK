import 'package:flutter/material.dart';

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

class AppData extends ChangeNotifier {
  static final AppData _instance = AppData._internal();
  factory AppData() => _instance;
  AppData._internal();

  double _balance = 12450000;
  final String _accountNumber = '1234 5678 4892';
  final String _accountName = 'Ahmad Fadhil';

  final List<Transaction> _todayTransactions = [
    const Transaction(
      id: '1',
      merchantName: 'Whole Groceries',
      category: 'Groceries',
      time: '10:42 AM',
      amount: 142500,
      isDebit: true,
      iconPath: 'grocery',
    ),
    const Transaction(
      id: '2',
      merchantName: 'Gajian Bulanan',
      category: 'Income',
      time: '10:42 AM',
      amount: 6767676,
      isDebit: false,
      iconPath: 'income',
    ),
  ];

  final List<Transaction> _yesterdayTransactions = [
    const Transaction(
      id: '3',
      merchantName: 'Warung Kane',
      category: 'Food',
      time: '12:67 AM',
      amount: 540500,
      isDebit: true,
      iconPath: 'food',
    ),
    const Transaction(
      id: '4',
      merchantName: 'PLN Token',
      category: 'Bills',
      time: '11:00 AM',
      amount: 200000,
      isDebit: true,
      iconPath: 'bills',
    ),
    const Transaction(
      id: '5',
      merchantName: 'Gojek',
      category: 'Transport',
      time: '09:45 AM',
      amount: 28000,
      isDebit: true,
      iconPath: 'transport',
    ),
    const Transaction(
      id: '6',
      merchantName: 'Transfer Masuk',
      category: 'Transfer',
      time: '08:10 AM',
      amount: 1000000,
      isDebit: false,
      iconPath: 'transfer',
    ),
  ];

  double get balance => _balance;
  String get accountNumber => _accountNumber;
  String get accountName => _accountName;
  List<Transaction> get todayTransactions => List.unmodifiable(_todayTransactions);
  List<Transaction> get yesterdayTransactions => List.unmodifiable(_yesterdayTransactions);

  void addTransaction(Transaction tx) {
    _todayTransactions.insert(0, tx);
    if (tx.isDebit) {
      _balance -= tx.amount;
    } else {
      _balance += tx.amount;
    }
    notifyListeners();
  }
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
      merchantName: 'Gajian Bulanan',
      category: 'Income',
      time: '10:42 AM',
      amount: 6767676,
      isDebit: false,
      iconPath: 'income',
    ),
  ];

  static const List<Transaction> yesterdayTransactions = [
    Transaction(
      id: '3',
      merchantName: 'Warung Kane',
      category: 'Food',
      time: '12:67 AM',
      amount: 540500,
      isDebit: true,
      iconPath: 'food',
    ),
    Transaction(
      id: '4',
      merchantName: 'PLN Token',
      category: 'Bills',
      time: '11:00 AM',
      amount: 200000,
      isDebit: true,
      iconPath: 'bills',
    ),
    Transaction(
      id: '5',
      merchantName: 'Gojek',
      category: 'Transport',
      time: '09:45 AM',
      amount: 28000,
      isDebit: true,
      iconPath: 'transport',
    ),
    Transaction(
      id: '6',
      merchantName: 'Transfer Masuk',
      category: 'Transfer',
      time: '08:10 AM',
      amount: 1000000,
      isDebit: false,
      iconPath: 'transfer',
    ),
  ];

  static const String accountNumber = '1234 5678 4892';
  static const String accountName = 'Ahmad Fadhil';
  static const double balance = 12450000;
}
