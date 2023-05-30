import 'package:day_night_switch/day_night_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:invoice_saver/divider_separator.dart';
import 'package:invoice_saver/screens/new_invoice.dart';
import 'package:invoice_saver/screens/search_invoice.dart';
import 'package:invoice_saver/screens/setting_screen.dart';
import 'package:invoice_saver/shared/component.dart';
import 'package:invoice_saver/utils/app_string.dart';
import 'package:invoice_saver/utils/navigate_fun.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          selectedLanguage == 'Arabic' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppString.invoiceSaverLite.tr),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  navigateTo(context, const SettingScreen());
                },
                icon: const Icon(IconBroken.Setting))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  navigateTo(context, const NewInvoice());
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      const Icon(IconBroken.Chart),
                      const SizedBox(width: 18),
                      Text(AppString.newInvoice.tr),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  navigateTo(context, const SearchInvoice());
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      const Icon(IconBroken.Search),
                      const SizedBox(width: 18),
                      Text(AppString.searchInvoice.tr),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      const Icon(Icons.content_paste_search),
                      const SizedBox(width: 18),
                      Text(AppString.searchItems.tr),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: DividerSeparator()),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      const Icon(IconBroken.User1),
                      const SizedBox(width: 18),
                      Text(AppString.customersAndSupplies.tr),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      const Icon(IconBroken.Category),
                      const SizedBox(width: 18),
                      Text(AppString.items.tr),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      const Icon(IconBroken.Discovery),
                      const SizedBox(width: 18),
                      Text(AppString.transactions.tr),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: DividerSeparator()),
            ],
          ),
        ),
      ),
    );
  }
}
