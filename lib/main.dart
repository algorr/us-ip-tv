import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:us_ip_tv/features/resources/theme_manager.dart';
import 'package:us_ip_tv/features/view/splash_view.dart';
import 'data/service/local_service/local_service.dart';

String? m3uFilePath;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  m3uFilePath = sharedPreferences.getString('m3uFilePath');
  final m3u = sharedPreferences.getStringList('m3uFile');
  await sharedPreferences.setStringList('m3uFile', m3u ?? []);
  await sharedPreferences.setString('m3uFilePath', m3uFilePath ?? ''); */
  //CheckM3uFile().checkM3uExist(m3uFilePath);
  LocalService localService = LocalService();
  await localService.fetchChannels();

  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Us IPTV',
      theme: getAppTheme(),
      home: const SplashView(),
    );
  }
}
