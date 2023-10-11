import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';
import 'package:intl/intl.dart';
import 'package:us_ip_tv/core/utils/mixins/live_channels_mixin.dart';
import 'package:us_ip_tv/core/utils/mixins/movie_channels_mixin.dart';
import 'package:us_ip_tv/core/utils/mixins/series_channels_mixin.dart';
import 'package:us_ip_tv/features/models/group_model.dart';
import 'package:us_ip_tv/features/view/live_category_view.dart';
import 'package:us_ip_tv/features/view/series_category_view.dart';
import 'package:us_ip_tv/features/view/settings_view.dart';

import 'movie_category_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.data}) : super(key: key);

  final List<ChannelGroup>? data;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with LiveChannelsMixin, MovieChannelsMixin, SeriesChannelsMixin {
  final List<String> objects = ['LIVE', 'MOVIES', 'SERIES'];
  final List<String> photos = [
    'assets/images/tv.png',
    'assets/images/movies.png',
    'assets/images/series.png'
  ];

  List<ChannelGroup>? liveChannels = [];
  List<ChannelGroup>? movieChannels = [];
  List<ChannelGroup>? seriesChannels = [];

  @override
  void initState() {
    super.initState();
    liveChannels = getLiveChannels(widget.data);
    movieChannels = getMovieChannels(widget.data);
    seriesChannels = getSeriesChannels(widget.data);
  }

  String timeOfDay() {
    var now = DateTime.now().toLocal();
    String time =
        "${DateFormat('EEEE').format(now).substring(0, 3)} ${now.hour} : ${now.minute}";
    return time;
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.data?[1].groupTitle);
    //print('LiveChannels : ${liveChannels?[2].groupTitle}');
    return Scaffold(
      //backgroundColor: const Color(0XFF406882),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          leadingWidth: 100,
          /*    flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.bottomCenter,
              colors: [
                /*    Color.fromARGB(255, 25, 178, 238),
                Color.fromARGB(255, 21, 236, 229) */
                Colors.black,
                Colors.white,
              ],
            ),
          ),
        ) */
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'US IPTV',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton.outlined(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingsView()));
              },
              icon: const Icon(
                Icons.online_prediction_outlined,
                color: Colors.white,
              ),
            ),
          ],
          leading: AutoSizeText(
            timeOfDay(),
            textAlign: TextAlign.start,
            style: const TextStyle(color: Colors.white),
          )),
      body: Container(
        decoration: const BoxDecoration(
          /* gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              /* Color.fromARGB(255, 25, 178, 238),
              Color.fromARGB(255, 21, 236, 229) */
              Colors.blueGrey,
              Colors.black,
            ],
          ), */
          image: DecorationImage(
            image: AssetImage(
              'assets/images/back1.jpg',
            ),
            fit: BoxFit.cover,
            //colorFilter: ColorFilter.mode(Colors.white, BlendMode.darken),
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: /* GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                          border: const GradientBoxBorder(
                            width: 5,
                            gradient: LinearGradient(
                              colors: [
                                /*   Colors.grey,
                                Colors.red,
                                Colors.green,
                                Colors.blue, */
                                Colors.black,
                                Colors.white
                              ],
                            ),
                          ),
                          /*  boxShadow: const [
                            BoxShadow(
                              color: Colors.white38,
                              offset: Offset(0, 0), //(x,y)
                              blurRadius: 5.0,
                              spreadRadius: 1,
                            )
                          ], */
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              textAlign: TextAlign.center,
                              widget.data![index].groupTitle,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ), */
                GridView.builder(
              itemCount: 3,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (index == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LiveCategoryView(
                            data: liveChannels,
                            indexOfGroup: index,
                          ),
                        ),
                      );
                    } else if (index == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieCategoryView(
                            data: movieChannels,
                            indexOfGroup: index,
                          ),
                        ),
                      );
                    } else if (index == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeriesCategoryView(
                            data: seriesChannels,
                            indexOfGroup: index,
                          ),
                        ),
                      );
                    }
                    /* Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieCategoryView(
                          data: widget.data?[index].contentList,
                          indexOfGroup: index,
                        ),
                      ),
                    ); */

                    /*   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LiveCategoryView(
                          data: widget.data,
                          indexOfGroup: index,
                        ),
                      ),
                    ); */
                  },
                  child: HexagonWidget.pointy(
                    width: 300,
                    elevation: 10,
                    cornerRadius: 40,
                    padding: 0,
                    color: Colors.red,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: /* Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Image.asset(photos[index]),
                          Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: Text(
                              objects[index],
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 40),
                            ),
                          )
                        ],
                      ) */
                          Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.yellow,
                              Colors.red,
                            ],
                          ),
                        ),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              photos[index],
                              width: 60,
                              height: 60,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              objects[index],
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 30),
                            ),
                          ],
                        )),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
