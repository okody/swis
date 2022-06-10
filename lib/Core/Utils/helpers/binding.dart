import 'package:get/get.dart';
import 'package:swis/Core/Controllers/operation_controller.dart';
import 'package:swis/Core/Utils/localstorage.dart';
import 'package:swis/Screens/Provider/home_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => LocalstorageCONTROLLER());
    Get.lazyPut(() => Home_CONTROLLER());
    Get.lazyPut(() => OperationCOTROLLER());
  }
}
