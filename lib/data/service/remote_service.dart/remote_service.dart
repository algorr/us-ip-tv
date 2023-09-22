import 'dart:convert';
import 'dart:io';
import 'package:m3u_nullsafe/m3u_nullsafe.dart';
import 'package:us_ip_tv/data/service/i_remote_service.dart';
import 'package:us_ip_tv/features/models/group_model.dart';
import 'package:http/http.dart' as http;

class RemoteService extends IRemoteService {
  @override
  Future<List<ChannelGroup>?> fetchChannels(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == HttpStatus.ok || response.body.isNotEmpty) {
      final data = utf8.decode(response.bodyBytes);
      final m3uList = await M3uParser.parse(data);

      List<ChannelGroup> channelGroupList = [];

      for (var item in m3uList) {
        final tvSerieTitle = item.title.split(RegExp(r'S[0-9][0-9]')).first;
        final tvSerieSeasonTitle =
            item.title.split(RegExp(r'E[0-9][0-9]')).first;
        final groupTitle = item.attributes['group-title'];
        final imgUrl = item.attributes['tvg-logo'];
        final content = Episode(
          title: item.title,
          imgUrl: imgUrl,
          link: item.link,
        );
        if (channelGroupList
            .contains(ChannelGroup(groupTitle: groupTitle ?? 'Other'))) {
          //Channel grubu bul
          var channelGroup = channelGroupList
              .firstWhere((element) => element.groupTitle == groupTitle);
          //item dizi mi
          if (item.title.contains(RegExp(r'S[0-9][0-9]'))) {
            //dizi var mı
            if (channelGroup.tvSerie.contains(TvSerie(title: tvSerieTitle))) {
              //diziyi bul
              var tvSerie = channelGroup.tvSerie
                  .firstWhere((element) => element.title == tvSerieTitle);
              //Sezon var mı
              if (tvSerie.seasons.contains(Season(title: tvSerieSeasonTitle))) {
                //Sezonu bul
                var season = tvSerie.seasons.firstWhere(
                    (element) => element.title == tvSerieSeasonTitle);
                season.episodes.add(content);
              } else {
                tvSerie.seasons.add(Season(
                  title: tvSerieSeasonTitle,
                  imgUrl: imgUrl,
                  episodes: [content],
                ));
              }
            } else {
              channelGroup.tvSerie.add(
                TvSerie(
                  title: tvSerieTitle,
                  imgUrl: imgUrl,
                  seasons: [
                    Season(
                      title: tvSerieSeasonTitle,
                      imgUrl: imgUrl,
                      episodes: [content],
                    ),
                  ],
                ),
              );
            }
          } else {
            channelGroup.contentList.add(content);
          }
        } else {
          if (item.title.contains(RegExp(r'S[0-9][0-9]'))) {
            channelGroupList.add(
              ChannelGroup(
                groupTitle: groupTitle ?? 'Other',
                imgUrl: imgUrl,
                tvSerie: [
                  TvSerie(
                    title: tvSerieTitle,
                    imgUrl: imgUrl,
                    seasons: [
                      Season(
                        title: tvSerieSeasonTitle,
                        imgUrl: imgUrl,
                        episodes: [content],
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            channelGroupList.add(
              ChannelGroup(
                groupTitle: groupTitle ?? 'Other',
                imgUrl: imgUrl,
                contentList: [content],
              ),
            );
          }
        }
      }
      return channelGroupList;
    }
    return null;
  }
}
