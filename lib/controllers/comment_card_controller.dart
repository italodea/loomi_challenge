import 'package:get/get.dart';

class CommentCardController extends GetxController {
  var isExpanded = false.obs;

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }
}
