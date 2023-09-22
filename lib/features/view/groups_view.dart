import 'package:flutter/material.dart';
import 'package:m3u_nullsafe/m3u_nullsafe.dart';
import 'video_view.dart';

class GroupsView extends StatefulWidget {
  const GroupsView({super.key, required this.contents});
  final List<M3uGenericEntry> contents;

  @override
  State<GroupsView> createState() => _GroupsViewState();
}

class _GroupsViewState extends State<GroupsView> {
  final List<String> groups = ['Haber', 'Belgesel', 'Çocuk', 'Sinema'];
  final List<String> images = [
    'assets/images/news.png',
    'assets/images/documentary.png',
    'assets/images/cartoon.png',
    'assets/images/movie.png'
  ];
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
        title: const Text('Channels'),
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
              mainAxisSpacing: 1),
          itemCount: groups.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .1,
                    child: Text(
                      groups[index],
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoView(
                            url: widget.contents[index].link,
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 100,
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
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: Image.asset(
                                  images[index],
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(
                                groups[index],
                              ),
                            ],
                          )),
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
