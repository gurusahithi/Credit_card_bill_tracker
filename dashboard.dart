import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bill_provider.dart';
import 'add_edit_bill.dart';
import '../widgets/bill_tile.dart';
import '../models/bill.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BillProvider>(builder: (context, prov, _) {
      prov.init();
      final bills = prov.bills;

      return Scaffold(
        appBar: AppBar(title: const Text("Credit Card Bill Tracker")),
        body: bills.isEmpty
            ? const Center(child: Text("No bills added yet."))
            : ListView(children: bills.map((b) {
                return BillTile(
                  bill: b,
                  onEdit: () async {
                    final updated = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AddEditBillScreen(bill: b)),
                    );
                    if (updated != null) prov.updateBill(updated);
                  },
                  onDelete: () => prov.deleteBill(b.id),
                  onToggle: () => prov.togglePaid(b.id),
                );
              }).toList()),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            final newBill = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddEditBillScreen()),
            );
            if (newBill != null) {
              prov.addBill(newBill.cardName, newBill.amount, newBill.dueDate, newBill.notes);
            }
          },
        ),
      );
    });
  }
}
