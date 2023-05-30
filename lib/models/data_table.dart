import 'package:flutter/material.dart';

class MyData extends DataTableSource {
  List<Map> data = [];

  MyData({required List<Map> invoices}) {
    data = invoices;
  }

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(data[index]['id'].toString())),
      DataCell(Text(data[index]['item'])),
      DataCell(Text(data[index]['name'])),
      DataCell(Text(data[index]['qty'])),
      DataCell(Text(data[index]['price'])),
      DataCell(Text(data[index]['total'])),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
