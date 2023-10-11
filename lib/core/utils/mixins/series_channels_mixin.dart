import 'package:us_ip_tv/features/models/group_model.dart';

mixin SeriesChannelsMixin {
  List<ChannelGroup>? getSeriesChannels(List<ChannelGroup>? data) {
    List<ChannelGroup>? listOfSeriesChannels = [];
    for (var element in data!) {
      if (element.groupTitle == 'Cumartesi Dizileri' ||
          element.groupTitle == 'Cuma Dizileri' ||
          element.groupTitle == 'Perşembe Dizileri' ||
          element.groupTitle == 'Çarşamba Dizileri' ||
          element.groupTitle == 'Pazartesi Dizileri' ||
          element.groupTitle == 'Salı Dizileri' ||
          element.groupTitle == 'Pazar Dizileri' ||
          element.groupTitle == 'Netflix Dizileri TR Dublaj' ||
          element.groupTitle == 'Yabancı Dizi  TR Dublaj' ||
          element.groupTitle == 'Netfilix-Belgesel TR Dublaj' ||
          element.groupTitle == 'Blu TV Dizileri' ||
          element.groupTitle == 'Puhu TV Dizileri' ||
          element.groupTitle == 'Cocuk Seri  TR Dublaj' ||
          element.groupTitle == 'Belgesel ( seri ) TR Dublaj' ||
          element.groupTitle == 'Disney + Hulu + Amazon + ESPN' ||
          element.groupTitle == 'Gain TV TR Dublaj' ||
          element.groupTitle == 'Netfilix-Belgesel TR Dublaj' ||
          element.groupTitle == 'Netflix Cocuk  TR Dublaj' ||
          element.groupTitle == 'Belgesel ( seri ) TR Dublaj' ||
          element.groupTitle == 'beIN Originals' ||
          element.groupTitle == 'Yabancı Dizi  TR Dublaj') {
        listOfSeriesChannels.add(element);
      }
    }

    return listOfSeriesChannels;
  }
}
