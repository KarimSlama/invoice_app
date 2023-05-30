import 'package:get/get.dart';
import 'package:invoice_saver/languages/ar.dart';
import 'package:invoice_saver/languages/en.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'English': English,
        'Arabic': Arabic,
      };
}
