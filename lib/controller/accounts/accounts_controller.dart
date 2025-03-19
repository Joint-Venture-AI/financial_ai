import 'package:financial_ai_mobile/views/screens/accounts/components/card_tab_section.dart';
import 'package:financial_ai_mobile/views/screens/accounts/components/cash_tab_section.dart';
import 'package:financial_ai_mobile/views/screens/accounts/components/tab_all_section.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AccountsTabController extends GetxController {
  var accountTab = ['All', 'Cash', 'Card'].obs;
  var timeSchedule = ['Daily', 'Weekly'].obs;

  var selectedAccountTab = 'All'.obs;
  var selectedTimeScheduleTab = 'Daily'.obs;
}
