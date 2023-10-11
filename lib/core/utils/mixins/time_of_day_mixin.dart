import 'package:intl/intl.dart';

mixin TimeOfDayMixin {
  String timeOfDay() {
    var now = DateTime.now().toLocal();
    String time =
        "${DateFormat('EEEE').format(now).substring(0, 3)} ${now.hour} : ${now.minute}";
    return time;
  }
}
