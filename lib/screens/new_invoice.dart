import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:intl/intl.dart' as intl;
import 'package:invoice_saver/shared/component.dart';
import 'package:invoice_saver/shared/cubit/cubit.dart';
import 'package:invoice_saver/shared/cubit/states.dart';
import 'package:invoice_saver/utils/app_colors.dart';
import 'package:invoice_saver/utils/app_string.dart';

class NewInvoice extends StatelessWidget {
  const NewInvoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var merchantNameController = TextEditingController();
    var dateController = TextEditingController();
    var itemController = TextEditingController();
    var qtyController = TextEditingController();
    var priceController = TextEditingController();
    var scaffoldKey = GlobalKey<ScaffoldState>();
    var formKey = GlobalKey<FormState>();
    final invoices = InvoiceCubit.getContext(context).invoices;
    return BlocConsumer<InvoiceCubit, InvoiceState>(
      listener: (context, state) {
        if (state is InvoiceInsertDatabaseState) {
          merchantNameController.clear();
          dateController.clear();
          itemController.clear();
          qtyController.clear();
          priceController.clear();
        }
      },

      builder: (context, state) {
        dateController.text =
            intl.DateFormat.yMMMd().format(DateTime.now()).toString();
        return Directionality(
          textDirection: selectedLanguage == 'Arabic'
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(AppString.newInvoice.tr),
              leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(selectedLanguage == 'Arabic'
                      ? IconBroken.Arrow___Right_2
                      : IconBroken.Arrow___Left_2)),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: SizedBox(
                height: 1000,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 400,
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: SizedBox(
                                      height: 80,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return AppString
                                                .merchantNameMustNotBeEmpty.tr;
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.text,
                                        controller: merchantNameController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 1.0),
                                          ),
                                          labelText: AppString.merchantName.tr,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Flexible(
                                    flex: 1,
                                    child: DropdownButton(
                                      underline: Container(),
                                      isExpanded: true,
                                      borderRadius: BorderRadius.circular(15),
                                      items: [
                                        DropdownMenuItem(
                                          value: AppString.all,
                                          child: Text(AppString.all.tr),
                                        ),
                                        DropdownMenuItem(
                                          value: AppString.customer,
                                          child: Text(AppString.customer.tr),
                                        ),
                                        DropdownMenuItem(
                                          value: AppString.supplier,
                                          child: Text(AppString.supplier.tr),
                                        ),
                                      ],
                                      value: InvoiceCubit.getContext(context)
                                          .selectedStatus,
                                      onChanged: (value) {
                                        if (value != null) {
                                          InvoiceCubit.getContext(context)
                                              .changeStatus(value);
                                          print(value);
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 12),
                              Flexible(
                                flex: 2,
                                child: SizedBox(
                                  height: 80,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return AppString.itemsMustNotBeEmpty.tr;
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.text,
                                    controller: itemController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                            color: Colors.white, width: 1.0),
                                      ),
                                      labelText: AppString.items.tr,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: SizedBox(
                                      height: 80,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return AppString
                                                .dateMustBeChosen.tr;
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.datetime,
                                        controller: dateController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 1.0),
                                          ),
                                          labelText: AppString.date.tr,
                                        ),
                                        onTap: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime.parse(
                                                      '2026-01-01'))
                                              .then((value) {
                                            dateController.text =
                                                intl.DateFormat.yMMMd()
                                                    .format(value!);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Flexible(
                                    flex: 1,
                                    child: SizedBox(
                                      height: 80,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return AppString
                                                .QTYMustNotBeEmpty.tr;
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                        controller: qtyController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 1.0),
                                          ),
                                          labelText: AppString.QTY.tr,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Flexible(
                                    flex: 1,
                                    child: SizedBox(
                                      height: 80,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return AppString
                                                .priceMustNotBeEmpty.tr;
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                        controller: priceController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 1.0),
                                          ),
                                          labelText: AppString.price.tr,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Container(
                                width: 200,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(20),
                                  color: AppColors.coffee,
                                ),
                                child: MaterialButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        InvoiceCubit.getContext(context)
                                            .insertIntoDatabase(
                                          merchantName:
                                              merchantNameController.text,
                                          type: InvoiceCubit.getContext(context)
                                              .selectedStatus
                                              .tr,
                                          item: itemController.text,
                                          invoiceDate: dateController.text,
                                          qty: int.parse(qtyController.text),
                                          price: double.parse(
                                              priceController.text),
                                          total: int.parse(qtyController.text) *
                                              double.parse(
                                                  priceController.text),
                                        );
                                      }
                                    },
                                    child: Text(AppString.add.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: AppColors.white))),
                              ),
                            ],
                          ),
                        ),
                      ),
                      DataTable(
                        border: TableBorder.all(
                            color: AppColors.coffee,
                            style: BorderStyle.solid,
                            borderRadius: BorderRadius.circular(4),
                            width: 1),
                        columns: const [
                          DataColumn(
                            label: Text('#', textAlign: TextAlign.center),
                          ),
                          DataColumn(
                            label: Text(AppString.name,
                                textAlign: TextAlign.center),
                          ),
                          DataColumn(
                            label: Text(AppString.date,
                                textAlign: TextAlign.center),
                          ),
                          DataColumn(
                            label: Text(AppString.total,
                                textAlign: TextAlign.center),
                          )
                        ],
                        rows: [
                          for (var raw in invoices)
                            DataRow(cells: [
                              DataCell(
                                Text(raw['id'].toString(),
                                    textAlign: TextAlign.center),
                              ),
                              DataCell(
                                Text(raw['name'].toString(),
                                    textAlign: TextAlign.center),
                              ),
                              DataCell(
                                Text(raw['date'].toString(),
                                    textAlign: TextAlign.center),
                              ),
                              DataCell(
                                Text(raw['total'].toString(),
                                    textAlign: TextAlign.center),
                              ),
                            ])
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
