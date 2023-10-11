import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:us_ip_tv/features/models/group_model.dart';
import 'package:us_ip_tv/features/view/video_view.dart';

class LiveCategoryView extends StatefulWidget {
  const LiveCategoryView(
      {super.key, required this.data, required this.indexOfGroup});

  final List<ChannelGroup>? data;
  final int indexOfGroup;

  @override
  State<LiveCategoryView> createState() => _LiveCategoryViewState();
}

class _LiveCategoryViewState extends State<LiveCategoryView> {
  int rightPanelIndicator = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.black],
            ),
          ),
        ),
        title: const Text(
          'Live Channels',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/back1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .9,
              width: MediaQuery.of(context).size.width * .3,
              child: ListView.builder(
                  itemCount: widget.data!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          rightPanelIndicator = index;
                        });
                        print(rightPanelIndicator);
                      },
                      child: ListTile(
                        selectedColor: Colors.brown,
                        leading: AutoSizeText(
                          widget.data![index].groupTitle,
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: AutoSizeText(
                          widget.data![index].contentList.length.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * .6,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount:
                      widget.data![rightPanelIndicator].contentList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => VideoView(
                              url: widget.data![rightPanelIndicator]
                                  .contentList[index].link!,
                              title: widget.data![rightPanelIndicator]
                                  .contentList[index].title,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        child: Image.network(
                          widget.data![rightPanelIndicator].contentList[index]
                              .imgUrl!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset('assets/images/logo.png');
                          },
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
