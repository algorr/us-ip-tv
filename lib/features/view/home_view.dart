import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:us_ip_tv/core/utils/mixins/index.dart';
import 'package:us_ip_tv/features/models/group_model.dart';
import 'package:us_ip_tv/features/view/live_category_view.dart';
import 'package:us_ip_tv/features/resources/index.dart';
import 'package:us_ip_tv/features/view/series_category_view.dart';
import 'package:us_ip_tv/features/view/settings_view.dart';
import 'package:us_ip_tv/features/widgets/home_view/hexagon_custom_widget.dart';
import 'package:us_ip_tv/features/widgets/home_view/home_view_background_widget.dart';

import 'movie_category_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.data}) : super(key: key);

  final List<ChannelGroup>? data;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with
        LiveChannelsMixin,
        MovieChannelsMixin,
        SeriesChannelsMixin,
        TimeOfDayMixin {
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          leadingWidth: AppSize.s100,
          title: const Text(
            StringManager.mainAppbarTitle,
          ),
          actions: [
            IconButton.outlined(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingsView()));
              },
              icon: const Icon(IconManager.mainAppbarActionButtonIcon),
            ),
          ],
          leading: AutoSizeText(
            timeOfDay(),
            textAlign: TextAlign.start,
            style: TextStyle(color: ColorManager.white),
          )),
      body: HomeViewBackgroundWidget(
        widget: GridView.builder(
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
              },
              child: HexagonCustomWidget(
                size: size,
                index: index,
              ),
            );
          },
        ),
      ),
    );
  }
}
