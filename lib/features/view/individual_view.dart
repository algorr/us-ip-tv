import 'package:flutter/material.dart';
import 'package:m3u_nullsafe/m3u_nullsafe.dart';
import 'package:us_ip_tv/features/models/group_model.dart';
import 'video_view.dart';

class IndividualView extends StatefulWidget {
  const IndividualView({Key? key, required this.contents}) : super(key: key);
  final List<M3uGenericEntry> contents;

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
        child: /* ListView.builder(
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
                leading: SizedBox(
                  width: 100,
                  height: 00,
                  child: widget.contents[index].attributes['tvg-logo'] != ''
                      ? Image.network(
                          widget.contents[index].attributes['tvg-logo']!,
                          fit: BoxFit.cover,
                        )
                      : Image.asset('assets/images/logo.png'),
                ),
                title: Text(
                    widget.contents[index].attributes['group-title'] ?? ''),
                subtitle: Text(widget.contents[index].title),
              ),
            );
          },
        ), */
            SizedBox(
          height: MediaQuery.of(context).size.height,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemCount: widget.contents.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                            widget.contents[index].attributes['group-title']!),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Expanded(
                          flex: 5,
                          child: Card(
                            shape: StadiumBorder(),
                            elevation: 20,
                            child:
                                widget.contents[index].attributes['tvg-logo'] !=
                                        ''
                                    ? Image.network(
                                        widget.contents[index]
                                            .attributes['tvg-logo']!,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.asset(
                                        'assets/images/logo.png',
                                        fit: BoxFit.fill,
                                      ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
