class Transactions {
  late final String email;
  late final String nominal;
  late final DateTime date;

  Transactions(this.email, this.nominal, this.date);


  Transactions.fromJson(Map<dynamic, dynamic> json)
      : date = DateTime.parse(json['date'] as String),
        email = json['email'] as String,
        nominal = json['nominal'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'date': date.toString(),
    'email': email,
    'nominal': nominal,
  };
}