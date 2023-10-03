import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../models/group_model.dart';
import 'video_view.dart';

class GroupsView extends StatefulWidget {
  GroupsView({
    super.key,
    required this.data,
    required this.indexOfGroup,
  });

  List<ChannelGroup>? data;
  int indexOfGroup;

  @override
  State<GroupsView> createState() => _GroupsViewState();
}

class _GroupsViewState extends State<GroupsView> {
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
              Color.fromARGB(255, 21, 236, 229),
            ],
          )),
        ),
        title: Text(widget.data![widget.indexOfGroup].groupTitle),
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
        height: MediaQuery.of(context).size.height,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 50),
          itemCount: widget.data![widget.indexOfGroup].contentList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                    child: AutoSizeText(
                      widget
                          .data![widget.indexOfGroup].contentList[index].title,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoView(
                              url: widget.data?[widget.indexOfGroup]
                                      .contentList[index].link ??
                                  '',
                              title: widget.data?[widget.indexOfGroup]
                                      .contentList[index].title ??
                                  '',
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: 150,
                        width: 200,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 150,
                                  width: 200,
                                  child: Image.network(
                                    widget.data![widget.indexOfGroup]
                                            .contentList[index].imgUrl ??
                                        '',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                /*   Expanded(
                                  child: AutoSizeText(
                                    widget.data![widget.indexOfGroup]
                                        .contentList[index].title,
                                  ),
                                ), */
                              ],
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
