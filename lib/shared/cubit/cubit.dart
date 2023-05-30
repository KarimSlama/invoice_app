import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_saver/shared/cubit/states.dart';
import 'package:invoice_saver/utils/app_string.dart';
import 'package:sqflite/sqflite.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit() : super(InvoiceInitialState());

  static InvoiceCubit getContext(context) => BlocProvider.of(context);

  String selectedStatus = AppString.all;

  void changeStatus(String value) {
    selectedStatus = value;
    emit(ChangeStatusMenuState());
  }

  late Database database;
  List<Map> invoices = [];
  List<Map> invoicesSearch = [];

  void createDatabase() {
    openDatabase(
      'invoice.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE invoices (id INTEGER PRIMARY KEY, name TEXT, type TEXT, item TEXT, date TEXT, qty TEXT, price TEXT, total TEXT)')
            .then((value) {
          print('table created');
        });
      },
      onOpen: (database) {
        getAllData(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
    });
  }

  insertIntoDatabase(
      {required var merchantName,
      required var type,
      required var item,
      required var invoiceDate,
      required var qty,
      required var price,
      required var total}) async {
    await database.transaction((transaction) {
      return transaction
          .rawInsert(
              'INSERT INTO invoices(name, type, item, date, qty, price, total) VALUES("$merchantName", "$type", "$item", "$invoiceDate", "$qty", "$price", "$total")')
          .then((value) {
        print('$value a new record inserted');
        emit(InvoiceInsertDatabaseState());
        getAllData(database);
      });
    });
  }

  void updateData({required String status, required int id}) async {
    database.rawUpdate('UPDATE invoices SET status = ? WHERE id = ?', [
      status,
      id,
    ]).then((value) {
      getAllData(database);
      emit(InvoiceUpdateDatabaseState());
    });
  } //end updateData()

  void deleteData({required int id}) async {
    database.rawDelete('DELETE FROM invoices WHERE id = ?', [id]).then((value) {
      getAllData(database);
      emit(InvoiceDeleteDatabaseState());
    });
  } //end updateData()

  void getAllData(database) {
    invoices = [];
    emit(InvoiceGetAllDatabaseLoadingState());
    database.rawQuery('SELECT * FROM invoices').then((value) {
      value.forEach((element) {
        invoices.add(element);
      });
      print(invoices);
      emit(InvoiceGetAllDatabaseState());
    });
  } //end getAllData()

  void searchItem(String type, String fromDate, {required String name}) {
    invoices = [];
    emit(SearchInvoiceLoadingState());
    database
        .rawQuery(
            "SELECT * FROM invoices WHERE name LIKE '%$name%' AND type LIKE '%$type%' OR date LIKE '%$fromDate%'")
        .then((value) {
      for (var element in value) {
        invoices.add(element);
      }
      emit(SearchInvoiceSuccessState());
    });
  }

  void searchByName({required String name}) {
    invoices = [];
    emit(SearchInvoiceLoadingState());
    database
        .rawQuery("SELECT * FROM invoices WHERE name LIKE '%$name%'")
        .then((value) {
      for (var element in value) {
        invoices.add(element);
      }
      emit(SearchInvoiceSuccessState());
    });
  }
}
