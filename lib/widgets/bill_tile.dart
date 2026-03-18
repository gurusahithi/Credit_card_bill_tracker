import 'package:flutter/material.dart';
import '../models/bill.dart';
import 'package:intl/intl.dart';

class BillTile extends StatelessWidget {
  final Bill bill;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggle;

  const BillTile({super.key, required this.bill, required this.onEdit, required this.onDelete, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final due = DateTime.parse(bill.dueDate);
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: bill.paid ? Colors.green : Colors.red,
          child: Text(bill.cardName[0].toUpperCase()),
        ),
        title: Text(bill.cardName),
        subtitle: Text("₹${bill.amount} • Due: ${DateFormat.yMMMd().format(due)}"),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
          IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
        ]),
        onTap: onToggle,
      ),
    );
  }
}
