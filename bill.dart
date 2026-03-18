class Bill {
  String id;
  String cardName;
  double amount;
  String dueDate;
  bool paid;
  String notes;

  Bill({required this.id, required this.cardName, required this.amount,
    required this.dueDate, this.paid=false, this.notes=''});

  factory Bill.fromMap(Map<String, dynamic> m) => Bill(
    id: m['id'], cardName: m['cardName'],
    amount: (m['amount'] as num).toDouble(),
    dueDate: m['dueDate'], paid: m['paid'],
    notes: m['notes'] ?? '',
  );

  Map<String, dynamic> toMap() => {
    'id': id, 'cardName': cardName, 'amount': amount,
    'dueDate': dueDate, 'paid': paid, 'notes': notes,
  };
}
