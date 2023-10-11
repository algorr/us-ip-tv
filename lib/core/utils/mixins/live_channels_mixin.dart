import 'package:us_ip_tv/features/models/group_model.dart';

mixin LiveChannelsMixin {
  List<ChannelGroup>? getLiveChannels(List<ChannelGroup>? data) {
    List<ChannelGroup>? listOfLiveChannels = [];
    for (var element in data!) {
      if (element.groupTitle == 'Belgesel' ||
          element.groupTitle == 'Cocuk' ||
          element.groupTitle == 'Yerel Kanallar' ||
          element.groupTitle == 'Ulusal ' ||
          element.groupTitle == 'Haber ' ||
          element.groupTitle == 'Dini' ||
          element.groupTitle == 'Kıbrıs' ||
          element.groupTitle == 'DE National (Ulusal)' ||
          element.groupTitle == 'De Kino (Sinema)' ||
          element.groupTitle == 'De Nachrichten (Haber)' ||
          element.groupTitle == 'De Nachrichten (Haber)' ||
          element.groupTitle == 'De Dokumentarfilm (Belgesel)' ||
          element.groupTitle == 'De Kind (Çocuk)' ||
          element.groupTitle == '► XXX + 18 Adult' ||
          element.groupTitle == '► XXX + 18 Adult-1' ||
          element.groupTitle == 'Sinema ' ||
          element.groupTitle == 'Eğlence' ||
          element.groupTitle == 'beIN Sports' ||
          element.groupTitle == 'S Sport' ||
          element.groupTitle == 'Exxen Spor' ||
          element.groupTitle == '► USA' ||
          element.groupTitle == '► Golf Sports' ||
          element.groupTitle == 'Spor ') {
        listOfLiveChannels.add(element);
      }
    }
    return listOfLiveChannels;
  }
}
