import 'package:us_ip_tv/features/models/group_model.dart';

mixin MovieChannelsMixin {
  List<ChannelGroup>? getMovieChannels(List<ChannelGroup>? data) {
    List<ChannelGroup>? listOfMovieChannels = [];
    for (var element in data!) {
      if (element.groupTitle == 'Yerli Film Sinema 2017/18/19/20' ||
          element.groupTitle == 'Yabanci Sinema 2017/18/19/20' ||
          element.groupTitle == 'Aksiyon Filmleri' ||
          element.groupTitle == 'Korku Filmleri' ||
          element.groupTitle == 'Komedi Filmleri' ||
          element.groupTitle == 'Kovboy Filmleri' ||
          element.groupTitle == 'Dram Filmler' ||
          element.groupTitle == 'Aile Filmler' ||
          element.groupTitle == 'Animasyon Cocuk' ||
          element.groupTitle == 'Germany Animation' ||
          element.groupTitle == '+18 Playboy Erotik' ||
          element.groupTitle == '+18 Yesilcam' ||
          element.groupTitle == '+18 massange' ||
          element.groupTitle == 'Romantik Filmler' ||
          element.groupTitle == 'Yeşilçam' ||
          element.groupTitle == 'Sinema boxset' ||
          element.groupTitle == 'Sinema,Boxset [Backup]' ||
          element.groupTitle == '4K Sinema' ||
          element.groupTitle == 'Yerli Sinema 2021' ||
          element.groupTitle == 'Yabancı Sinema 2022' ||
          element.groupTitle == 'Yabancı Sinema 2023' ||
          element.groupTitle == 'Yerli Sinema 2023' ||
          element.groupTitle == 'Tr Altyazı Sinema' ||
          element.groupTitle == 'Tr Altyazı Sinema 2023' ||
          element.groupTitle == 'Boxset Sinemalar' ||
          element.groupTitle == 'Yabancı Sinema 2021 ' ||
          element.groupTitle == 'Netflix Cocuk  TR Dublaj' ||
          element.groupTitle == 'Eglence/Talk show Gosteri') {
        listOfMovieChannels.add(element);
      }
    }
    return listOfMovieChannels;
  }
}
