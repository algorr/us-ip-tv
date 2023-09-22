import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:m3u_nullsafe/m3u_nullsafe.dart';
import 'package:us_ip_tv/data/service/local_service/local_service.dart';
import 'package:us_ip_tv/features/view/groups_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.listTracks}) : super(key: key);
  final List<M3uGenericEntry> listTracks;
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> menus = ['Channels', 'Movies', 'Series'];
  List<IconData> icons = [
    Icons.tv_outlined,
    Icons.local_movies_outlined,
    Iconsax.truck_remove
  ];

  final _localService = LocalService();
  final list = [];

  @override
  void initState() {
    super.initState();
    _localService.fetchChannels().then((value) => list.add(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 25, 178, 238),
              Color.fromARGB(255, 21, 236, 229)
            ],
          )),
        ),
        title: const Text(
          'US IP TV',
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
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 25, 178, 238),
            Color.fromARGB(255, 21, 236, 229)
          ],
        )),
        child: SafeArea(
          child: Column(
            children: [
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
                            /*  Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => IndividualView(
                                  contents: widget.listTracks,
                                ),
                              ),
                            ); */
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GroupsView(
                                  contents: widget.listTracks,
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
      ),
    );
  }
}
