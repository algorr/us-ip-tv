import 'package:flutter/material.dart';
import 'package:m3u_nullsafe/m3u_nullsafe.dart';
import 'package:us_ip_tv/data/service/local_service/local_service.dart';
import 'package:us_ip_tv/features/view/home_view.dart';
import 'package:us_ip_tv/features/view/settings_view.dart';
import 'package:us_ip_tv/main.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final LocalService _localService = LocalService();

  @override
  void initState() {
    super.initState();
    _checkM3uFile();
  }

  void _checkM3uFile() async {
    final listOfTracks = await parseFile(m3uFilePath ?? '');

    var data = await _localService.fetchChannels();
    await Future.delayed(const Duration(seconds: 3)).then((value) =>
        listOfTracks.isNotEmpty
            ? Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomeView(
                      data: data,
                    )))
            : Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettingsView())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}
