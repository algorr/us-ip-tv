import '../../../features/models/group_model.dart';

abstract class ILocalService {
  Future<List<ChannelGroup>?> fetchChannels();
}
