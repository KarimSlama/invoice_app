import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:intl/intl.dart' as intl;
import 'package:invoice_saver/models/data_table.dart';
import 'package:invoice_saver/shared/component.dart';
import 'package:invoice_saver/shared/cubit/cubit.dart';
import 'package:invoice_saver/shared/cubit/states.dart';
import 'package:invoice_saver/utils/app_colors.dart';
import 'package:invoice_saver/utils/app_string.dart';

class SearchInvoice extends StatelessWidget {
  const SearchInvoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvoiceCubit, InvoiceState>(
      listener: (context, state) {},
      builder: (context, state) {
        final invoices = InvoiceCubit.getContext(context).invoices;
        // var invoicesSearch = InvoiceCubit.getContext(context).invoicesSearch;
        var merchantNameController = TextEditingController();
        var toDateController = TextEditingController();
        var fromDateController = TextEditingController();
        fromDateController.text = intl.DateFormat.yMMMd()
            .format(DateTime.now().subtract(const Duration(days: 7)))
            .toString();
        toDateController.text =
            intl.DateFormat.yMMMd().format(DateTime.now()).toString();
        return Directionality(
          textDirection: selectedLanguage == 'Arabic'
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(
              title: Text(AppString.searchInvoice.tr),
              leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(selectedLanguage == 'Arabic'
                      ? IconBroken.Arrow___Right_2
                      : IconBroken.Arrow___Left_2)),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
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
                                return AppString.merchantNameMustNotBeEmpty.tr;
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            controller: merchantNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.0),
                              ),
                              labelText: AppString.merchantName.tr,
                            ),
                            onFieldSubmitted: (value) =>
                                InvoiceCubit.getContext(context).searchByName(
                              name: value,
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
                          value:
                              InvoiceCubit.getContext(context).selectedStatus,
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
                  Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: SizedBox(
                          height: 80,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppString.dateMustBeChosen.tr;
                              }
                              return null;
                            },
                            keyboardType: TextInputType.datetime,
                            controller: fromDateController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.0),
                              ),
                              labelText: AppString.fromDate.tr,
                            ),
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now()
                                          .subtract(const Duration(days: 7)),
                                      firstDate: DateTime.now()
                                          .subtract(const Duration(days: 7)),
                                      lastDate: DateTime.parse('2026-01-01'))
                                  .then((value) {
                                fromDateController.text =
                                    intl.DateFormat.yMMMd().format(value!);
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        flex: 2,
                        child: SizedBox(
                          height: 80,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppString.dateMustBeChosen.tr;
                              }
                              return null;
                            },
                            keyboardType: TextInputType.datetime,
                            controller: toDateController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.0),
                              ),
                              labelText: AppString.toDate.tr,
                            ),
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2026-01-01'))
                                  .then((value) {
                                toDateController.text =
                                    intl.DateFormat.yMMMd().format(value!);
                              });
                            },
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
                      borderRadius: BorderRadiusDirectional.circular(20),
                      color: AppColors.coffee,
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        InvoiceCubit.getContext(context).searchItem(
                          name: merchantNameController.text,
                          InvoiceCubit.getContext(context).selectedStatus,
                          fromDateController.text,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(IconBroken.Search, color: AppColors.white),
                          const SizedBox(width: 30),
                          Text(AppString.search.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppColors.white)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Expanded(
                    child: DataTable(
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
                          label:
                              Text(AppString.name, textAlign: TextAlign.center),
                        ),
                        DataColumn(
                          label:
                              Text(AppString.date, textAlign: TextAlign.center),
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
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
