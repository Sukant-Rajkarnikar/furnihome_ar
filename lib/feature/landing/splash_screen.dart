import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:furnihome_ar/routes/route_util.dart';
import 'package:furnihome_ar/routes/router_paths.dart';
import 'package:furnihome_ar/utils/dimens.dart';
import 'package:furnihome_ar/utils/image_constants.dart';
import 'package:furnihome_ar/utils/strings.dart';
import 'package:furnihome_ar/utils/text_styles.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5),
      () {
        // Navigator.pop(context);
        // Navigator.push(context, AnimScaleTransition(page: const HomeScreen()));
        context.replaceRouteTo(Paths.homeScreen);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(ImageConstants.IC_SPLASH_SCREEN),
            fit: BoxFit.cover),
      ),
      child: Stack(
        children: [
          Center(
              child: Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.spacing_50),
                  child: Image.asset(ImageConstants.IC_APP_LOGO,
                      width: Dimens.spacing_250))),
          const Positioned.fill(
              bottom: 50,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  Strings.bySukant,
                  style: text_7b44c0_16_Regular_w400,
                ),
              )),
        ],
      ),
    );
  }
}
