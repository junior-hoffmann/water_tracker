class Drink {
  final DateTime date;
  final int amount;

  Drink({required this.date, required this.amount});

  factory Drink.fromMap(Map<String, dynamic> map) {
    return Drink(
      date: DateTime.parse(map['date']),
      amount: int.parse(map['amount']),
    );
  }
}