import 'package:flutter/material.dart';
import 'package:m3u_nullsafe/m3u_nullsafe.dart';
import 'video_view.dart';

class IndividualView extends StatefulWidget {
  IndividualView({Key? key, required this.contents}) : super(key: key);
  List<M3uGenericEntry> contents;

  @override
  State<IndividualView> createState() => _IndividualViewState();
}

class _IndividualViewState extends State<IndividualView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        title: const Text('Tüm Kanal Listesi'),
      ),
      body: SafeArea(
          child: ListView.builder(
        itemCount: widget.contents.length,
        itemBuilder: (context, index) {
          return InkWell(
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
            child: ListTile(
              title: Text(widget.contents[index].title),
            ),
          );
        },
      )),
    );
  }
}
