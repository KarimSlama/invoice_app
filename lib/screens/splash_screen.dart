import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invoice_saver/screens/home_screen.dart';
import 'package:invoice_saver/utils/app_string.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppString.invoiceSaver.tr,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 40,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                    fontFamily: GoogleFonts.philosopher().fontFamily,
                  ),
            ),
            const SizedBox(
              height: 18.0,
            ),
            Text(
              AppString.savingYourSignificantInvoices.tr,
            ),
          ],
        ),
      ),
    );
  }

  Future navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
  }

  @override
  void initState() {
    super.initState();
    navigateToHome().then((value) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        )));
  }
}
