import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:invoice_saver/divider_separator.dart';
import 'package:invoice_saver/shared/component.dart';
import 'package:invoice_saver/shared/cubit/mode_cubit.dart';
import 'package:invoice_saver/utils/app_colors.dart';
import 'package:invoice_saver/utils/app_string.dart';
import 'package:invoice_saver/utils/cached_data.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          selectedLanguage == 'Arabic' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppString.settings.tr),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(selectedLanguage == 'Arabic'
                  ? IconBroken.Arrow___Right_2
                  : IconBroken.Arrow___Left_2)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(AppString.languages.tr),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      selectedLanguage = 'Arabic';
                      Get.updateLocale(Locale(selectedLanguage));
                      CacheHelper.saveData(
                          key: 'language', value: selectedLanguage);
                    },
                    child: Text(
                      AppString.arabic.tr,
                      // style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      // color: selectedLanguage == 'Arabic'
                      //     ? AppColors.green
                      //     : Colors.black,
                      // ),
                    ),
                  ),
                  const SizedBox(width: 40),
                  TextButton(
                    onPressed: () {
                      selectedLanguage = 'English';
                      Get.updateLocale(Locale(selectedLanguage));
                      CacheHelper.saveData(
                          key: 'language', value: selectedLanguage);
                    },
                    child: Text(AppString.english.tr),
                  ),
                ],
              ),
              const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: DividerSeparator()),
              const SizedBox(height: 22),
              Text(AppString.themes.tr),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      ModeCubit.getContext(context).isDark = false;
                      ModeCubit.getContext(context).changeMode();
                    },
                    child: Text(
                      AppString.light.tr,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ModeCubit.getContext(context).isDark
                              ? AppColors.green
                              : Colors.white),
                    ),
                  ),
                  const SizedBox(width: 40),
                  TextButton(
                    onPressed: () {
                      ModeCubit.getContext(context).isDark = true;
                      ModeCubit.getContext(context).changeMode();
                    },
                    child: Text(
                      AppString.dark.tr,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ModeCubit.getContext(context).isDark
                              ? Colors.black
                              : AppColors.green),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
