import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:hungry/models/helper/api_service.dart';

class MessageController extends GetxController {
  var responseText = "".obs;
  var messages = <Map<String, dynamic>>[].obs;
  var isTyping = false.obs;

  Future<void> sendMessage(String message) async {
    messages.add({
      'text': message,
      'isUser': true,
      'time': DateFormat('hh:mm a').format(DateTime.now())
    });

    responseText.value = "Thinking...";
    isTyping.value = true;
    update();

    String reply = await GoogleApiService.getApiResponse(message);

    responseText.value = reply;
    messages.add({
      'text': reply,
      'isUser': false,
      'time': DateFormat('hh:mm a').format(DateTime.now())
    });

    isTyping.value = false;
    update();
  }
}
