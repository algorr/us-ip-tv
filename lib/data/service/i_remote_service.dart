import 'package:us_ip_tv/features/models/group_model.dart';

abstract class IRemoteService {
  Future<List<ChannelGroup>?> fetchChannels(String url);
}
