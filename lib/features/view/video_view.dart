import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:iconsax/iconsax.dart';

class VideoView extends StatefulWidget {
  const VideoView({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> with TickerProviderStateMixin {
  late VlcPlayerController _vlcPlayerController;
  bool isTapped = true;

  late AnimationController _scaleVideoAnimationController;
  Animation<double> _scaleVideoAnimation =
      const AlwaysStoppedAnimation<double>(1.0);
  double? _targetVideoScale;
  double _lastZoomGestureScale = 1.0;

  @override
  void initState() {
    super.initState();

    _scaleVideoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 125),
      vsync: this,
    );

    _vlcPlayerController = VlcPlayerController.network(
      widget.url,
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );

    if (_lastZoomGestureScale > 1.0) {
      setState(() {
        // Zoom in
        _scaleVideoAnimationController.forward();
      });
    } else if (_lastZoomGestureScale < 1.0) {
      setState(() {
        // Zoom out
        _scaleVideoAnimationController.reverse();
      });
    }
    _lastZoomGestureScale = 1.0;

    Future.delayed(const Duration(seconds: 3), () {
// Here you can write your code

      setState(() {
        isTapped = !isTapped;
      });
    });
  }

  @override
  void dispose() async {
    super.dispose();
    await _vlcPlayerController.stop();
    await _vlcPlayerController.stopRendererScanning();
    await _vlcPlayerController.dispose();
  }

  void setTargetNativeScale(double newValue) {
    if (!newValue.isFinite) {
      return;
    }
    _scaleVideoAnimation =
        Tween<double>(begin: 1.0, end: newValue).animate(CurvedAnimation(
      parent: _scaleVideoAnimationController,
      curve: Curves.easeInOut,
    ));

    if (_targetVideoScale == null) {
      _scaleVideoAnimationController.forward();
    }
    _targetVideoScale = newValue;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final videoSize = _vlcPlayerController.value.size;
    setState(() {
      _lastZoomGestureScale = 1.0;
      _scaleVideoAnimationController.forward();
    });

    final newTargetScale =
        size.width / (videoSize.width * size.height / videoSize.height);
    setTargetNativeScale(newTargetScale);

    return GestureDetector(
        onTap: () {
          setState(() {
            isTapped = !isTapped;
          });
        },
        onScaleStart: (details) {
          _lastZoomGestureScale = 1.0;
          _scaleVideoAnimationController.forward();
        },
        onScaleEnd: (details) {},
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: isTapped == true
              ? AppBar(
                  backgroundColor: Colors.black,
                  title: Text(
                    widget.url,
                    style: const TextStyle(color: Colors.white),
                  ),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white,
                    ),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _vlcPlayerController.setVolume(0);
                          });
                        },
                        icon: const Icon(
                          Icons.music_off_outlined,
                          color: Colors.white,
                        ))
                  ],
                )
              : null,
          body: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: size.width,
                  child: ScaleTransition(
                    scale: _scaleVideoAnimation,
                    child: VlcPlayer(
                      virtualDisplay: true,
                      controller: _vlcPlayerController,
                      aspectRatio: 0.5,
                      placeholder: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ),
              ),
              isTapped == true
                  ? Positioned(
                      left: size.width / 2.5,
                      top: size.height * .7,
                      bottom: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Iconsax.backward,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  _vlcPlayerController.isPlaying().then(
                                      (value) => value == false
                                          ? _vlcPlayerController.play()
                                          : _vlcPlayerController.pause());
                                });
                              },
                              icon: const Icon(
                                Iconsax.play,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Iconsax.forward,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ));
  }
}
