import 'package:get/get.dart';
import 'package:swis/Core/Utils/Languages/ar.dart';
import 'package:swis/Core/Utils/Languages/en.dart';

class Translation extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {"en": en, "ar": ar};
}
