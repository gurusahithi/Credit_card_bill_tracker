import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/bill.dart';

class AddEditBillScreen extends StatefulWidget {
  final Bill? bill;
  const AddEditBillScreen({super.key, this.bill});

  @override
  State<AddEditBillScreen> createState() => _AddEditBillScreenState();
}

class _AddEditBillScreenState extends State<AddEditBillScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameC;
  late TextEditingController _amountC;
  late TextEditingController _notesC;
  DateTime dueDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _nameC = TextEditingController(text: widget.bill?.cardName ?? "");
    _amountC = TextEditingController(text: widget.bill?.amount.toString() ?? "");
    _notesC = TextEditingController(text: widget.bill?.notes ?? "");
    if (widget.bill != null) dueDate = DateTime.parse(widget.bill!.dueDate);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.bill != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Edit Bill" : "Add Bill")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              controller: _nameC,
              decoration: const InputDecoration(labelText: "Card Name"),
              validator: (v) => v!.isEmpty ? "Required" : null,
            ),
            TextFormField(
              controller: _amountC,
              decoration: const InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
              validator: (v) => v!.isEmpty ? "Required" : null,
            ),
            const SizedBox(height: 16),
            Row(children: [
              Expanded(child: Text(DateFormat.yMMMd().format(dueDate))),
              TextButton(
                child: const Text("Pick Date"),
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: dueDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (picked != null) setState(() => dueDate = picked);
                },
              ),
            ]),
            TextFormField(
              controller: _notesC,
              decoration: const InputDecoration(labelText: "Notes"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: Text(isEdit ? "Save Changes" : "Add Bill"),
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;
                final bill = Bill(
                  id: widget.bill?.id ?? DateTime.now().microsecondsSinceEpoch.toString(),
                  cardName: _nameC.text,
                  amount: double.parse(_amountC.text),
                  dueDate: DateFormat("yyyy-MM-dd").format(dueDate),
                  paid: widget.bill?.paid ?? false,
                  notes: _notesC.text,
                );
                Navigator.pop(context, bill);
              },
            )
          ]),
        ),
      ),
    );
  }
}
