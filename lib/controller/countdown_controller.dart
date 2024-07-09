import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountdownController extends GetxController {
  var daysLeft = 90.obs;
  var daysPassed = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadCountdown();
  }

  void _loadCountdown() async {
    final prefs = await SharedPreferences.getInstance();
    final targetDateStr = prefs.getString('target_date');
    if (targetDateStr != null) {
      final targetDate = DateTime.parse(targetDateStr);
      daysLeft.value = targetDate.difference(DateTime.now()).inDays;
      daysPassed.value = 90 - daysLeft.value;
    } else {
      // Set a new target date
      final newTargetDate = DateTime.now().add(Duration(days: 90));
      prefs.setString('target_date', newTargetDate.toIso8601String());
      daysLeft.value = 90;
      daysPassed.value = 0;
    }
  }
}
