import 'package:firebase_database/firebase_database.dart';
import 'transactions.dart';

class TransactionDao {

  final _transactionsRef = FirebaseDatabase.instance.ref().child('transactions');

  void saveTransaction(Transactions transactions) {
    try {
      _transactionsRef.set(transactions.toJson());
      print('saving...');
    } catch (e) {
      print(e);
    }
  }

  Query getTransactionsQuery() {
    return _transactionsRef;
  }
}