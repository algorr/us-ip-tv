import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:us_ip_tv/features/resources/index.dart';

class HomeViewBackgroundWidget extends StatelessWidget {
  const HomeViewBackgroundWidget({super.key, required this.widget});

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            ImageManager.backgroundImage,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: AppSize.s5, sigmaY: AppSize.s5),
        child: Padding(
          padding: const EdgeInsets.all(AppMargin.m8),
          child: widget,
        ),
      ),
    );
  }
}
