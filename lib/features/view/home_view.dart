import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:m3u_nullsafe/m3u_nullsafe.dart';
import 'package:us_ip_tv/data/service/local_service/local_service.dart';
import 'package:us_ip_tv/features/models/group_model.dart';
import 'package:us_ip_tv/features/view/groups_view.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key, required this.listTracks, required this.data})
      : super(key: key);
  List<M3uGenericEntry> listTracks;
  List<ChannelGroup>? data;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _localService = LocalService();
  var list = [];

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
                height: MediaQuery.of(context).size.height * .7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 300,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemCount: widget.data?.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GroupsView(
                                  data: widget.data,
                                  indexOfGroup: index,
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
                                  AutoSizeText(
                                    widget.data![index].groupTitle,
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
