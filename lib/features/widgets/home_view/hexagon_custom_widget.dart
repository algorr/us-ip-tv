import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';
import 'package:us_ip_tv/core/constants/string_consts.dart';
import 'package:us_ip_tv/features/resources/index.dart';

class HexagonCustomWidget extends StatelessWidget {
  const HexagonCustomWidget(
      {super.key, required this.size, required this.index});
  final Size size;
  final int index;

  @override
  Widget build(BuildContext context) {
    return HexagonWidget.pointy(
      width: size.width * .3,
      elevation: AppSize.s10,
      cornerRadius: AppSize.s40,
      padding: AppSize.s0,
      color: ColorManager.red,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: AppSize.s20, sigmaY: AppSize.s20),
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorManager.orange,
                ColorManager.red,
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  StringConstants.icons[index],
                  width: size.width * .15,
                  height: size.height * .2,
                ),
                const SizedBox(
                  height: AppSize.s40,
                ),
                Text(
                  StringConstants.pages[index],
                  style: TextStyle(
                      color: ColorManager.black, fontSize: AppSize.s30),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
