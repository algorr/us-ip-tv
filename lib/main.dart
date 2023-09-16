import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:m3u_nullsafe/m3u_nullsafe.dart';
import 'features/view/individual_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      title: 'Mine',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  File file = File('');
  List<M3uGenericEntry> listTracks = [];
  List<String> menus = ['Channels', 'Movies', 'Series'];
  List<IconData> icons = [
    Icons.tv_outlined,
    Icons.local_movies_outlined,
    Iconsax.truck_remove
  ];
  Map<String, List<M3uGenericEntry>> contents = {};
  List parts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Mine',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton.outlined(
            onPressed: () {},
            icon: const Icon(
              Icons.settings_applications_outlined,
              color: Colors.white,
            ),
          ),
        ],
        leading: IconButton.outlined(
            onPressed: () {},
            icon: const Icon(
              Icons.online_prediction_sharp,
              color: Colors.white,
            )),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final FilePickerResult? result =
                    await FilePicker.platform.pickFiles(
                  type: FileType.any,
                );

                //final liste = await parseFile(result?.paths);
                final file = await File(result!.paths.first!).readAsString();
                final listOfTracks = await parseFile(file);

                final categories = sortedCategories(
                    entries: listOfTracks, attributeName: 'group-title');
                // print('categories : $categories');
                var bolum = categories.keys.toList();

                setState(() {
                  listTracks = listOfTracks;
                  contents = categories;
                  parts.add(bolum);
                });
                print('Bolumler : ${parts.first}');
                print('File : ${categories.keys}');
                //print('Tracks : $listOfTracks');
              },
              child: const Text('Pick M3U File'),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemCount: menus.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => IndividualView(
                                contents: listTracks,
                              ),
                            ),
                          );
                        },
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Colors.yellow,
                                    Colors.red,
                                    Colors.blue
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  icons[index],
                                  size: 60,
                                ),
                                Text(
                                  menus[index],
                                ),
                              ],
                            )),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
