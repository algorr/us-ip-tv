import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:m3u_nullsafe/m3u_nullsafe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:us_ip_tv/data/service/local_service/local_service.dart';
import 'package:us_ip_tv/features/view/home_view.dart';
import 'package:us_ip_tv/main.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  File file = File('');
  List<M3uGenericEntry> listTracks = [];
  Map<String, List<M3uGenericEntry>> contents = {};
  List parts = [];
  LocalService localService = LocalService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final FilePickerResult? result =
                await FilePicker.platform.pickFiles(
              type: FileType.any,
            );
            SharedPreferences pref = await SharedPreferences.getInstance();
            //final liste = await parseFile(result?.paths);
            final filePath = File(result!.paths.first!);
            setState(() {
              m3uFilePath = filePath.readAsStringSync();
              //print(m3uFilePath);
              if (m3uFilePath != null) {
                pref.setStringList('m3uFile', filePath.readAsLinesSync());
                pref.setString('m3uFilePath', m3uFilePath!);
              }
            });
            final file = await File(result.paths.first!).readAsString();

            final listOfTracks = await parseFile(file);
            final data = await localService.fetchChannels();

            final categories = sortedCategories(
                entries: listOfTracks, attributeName: 'group-title');
            // print('categories : $categories');
            var bolum = categories.keys.toList();

            setState(() {
              listTracks = listOfTracks;
              contents = categories;
              parts.add(bolum);
            });

            //print('Tracks : $listOfTracks');

            m3uFilePath != ''
                ? Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomeView(
                          listTracks: listOfTracks,
                          data: data,
                        )))
                : showAdaptiveDialog(
                    context: context,
                    builder: (context) {
                      return const Text('M3u File is not added');
                    });
          },
          child: const Text('Pick M3U File'),
        ),
      ),
    );
  }
}
