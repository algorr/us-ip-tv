import 'package:shared_preferences/shared_preferences.dart';

class CheckM3uFile {
  void checkM3uExist(String? m3uFilePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    m3uFilePath = prefs.getString('m3uFilePath');
    final m3u = prefs.getStringList('m3uFile');
    await prefs.setStringList('m3uFile', m3u ?? []);
    await prefs.setString('m3uFilePath', m3uFilePath ?? '');
  }
}
