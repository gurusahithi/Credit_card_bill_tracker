import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/bill.dart';

class BillProvider with ChangeNotifier {
  static const String _kStorageKey = 'ccb_local_storage_v1';
  final List<Bill> _bills = [];
  bool _initialized = false;

  List<Bill> get bills => List.unmodifiable(_bills);

  Future<void> init() async {
    if (_initialized) return;
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_kStorageKey);
    if (raw != null) {
      final arr = json.decode(raw) as List;
      _bills.clear();
      _bills.addAll(arr.map((e) => Bill.fromMap(e)));
    }
    _initialized = true;
    notifyListeners();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final arr = _bills.map((b) => b.toMap()).toList();
    await prefs.setString(_kStorageKey, json.encode(arr));
  }

  Future<void> addBill(String name, double amount, String date, String notes) async {
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    _bills.add(Bill(id: id, cardName: name, amount: amount, dueDate: date, notes: notes));
    await _save();
    notifyListeners();
  }

  Future<void> updateBill(Bill updated) async {
    final idx = _bills.indexWhere((b) => b.id == updated.id);
    if (idx >= 0) {
      _bills[idx] = updated;
      await _save();
      notifyListeners();
    }
  }

  Future<void> deleteBill(String id) async {
    _bills.removeWhere((b) => b.id == id);
    await _save();
    notifyListeners();
  }

  Future<void> togglePaid(String id) async {
    final idx = _bills.indexWhere((b) => b.id == id);
    final b = _bills[idx];
    _bills[idx] = Bill(
      id: b.id, cardName: b.cardName, amount: b.amount,
      dueDate: b.dueDate, paid: !b.paid, notes: b.notes,
    );
    await _save();
    notifyListeners();
  }
}
