import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:invoice_saver/models/translations.dart';
import 'package:invoice_saver/screens/splash_screen.dart';
import 'package:invoice_saver/shared/component.dart';
import 'package:invoice_saver/shared/cubit/cubit.dart';
import 'package:invoice_saver/shared/cubit/invoice_observer.dart';
import 'package:invoice_saver/shared/cubit/mode_cubit.dart';
import 'package:invoice_saver/shared/cubit/mode_state.dart';
import 'package:invoice_saver/utils/cached_data.dart';
import 'package:invoice_saver/utils/themes/theme_data/theme_dark.dart';
import 'package:invoice_saver/utils/themes/theme_data/theme_light.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  selectedLanguage = CacheHelper.getData(key: 'language');
  runApp(MyApp(
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  bool? isDark;

  MyApp({this.isDark, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InvoiceCubit()..createDatabase(),
        ),
        BlocProvider(
          create: (context) => ModeCubit()..changeMode(fromShared: isDark),
        ),
      ],
      child: BlocConsumer<ModeCubit, ModeStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
            theme:
                ModeCubit.getContext(context).isDark ? themeLight : themeDark,
            translations: Translation(),
            locale: Locale(selectedLanguage ?? 'English'),
            fallbackLocale: const Locale('English'),
          );
        },
      ),
    );
  }
}
