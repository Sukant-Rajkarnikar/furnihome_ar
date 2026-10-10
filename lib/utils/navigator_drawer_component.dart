import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:furnihome_ar/routes/app_route.gr.dart';
import 'package:furnihome_ar/routes/route_util.dart';
import 'package:furnihome_ar/utils/colors.dart';
import 'package:furnihome_ar/utils/dimens.dart';
import 'package:furnihome_ar/utils/image_constants.dart';
import 'package:furnihome_ar/utils/strings.dart';
import 'package:furnihome_ar/utils/text_styles.dart';
import 'package:furnihome_ar/utils/widget_functions.dart';

class NavigatorDrawerComponent extends StatelessWidget {
  const NavigatorDrawerComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white_rgba_ffffff,
      child: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpace(Dimens.spacing_32),
            Container(
              margin: const EdgeInsets.all(0.0),
              padding: const EdgeInsets.only(
                  left: Dimens.spacing_24, right: Dimens.spacing_4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: Dimens.spacing_24,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: Dimens.spacing_24),
                        child: SizedBox(
                          height: Dimens.spacing_164,
                          width: Dimens.spacing_164,
                          child: ClipRRect(
                            borderRadius:
                            BorderRadius.circular(Dimens.spacing_10),
                            child: Image.asset(ImageConstants.IC_APP_LOGO),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          icon: Image.asset(
                            ImageConstants.IC_CLOSE_ICON,
                            color: AppColors.purple_rgba_7b44c0,
                            height: Dimens.spacing_24,
                            width: Dimens.spacing_24,
                          ))
                    ],
                  ),
                ],
              ),
            ),
            addVerticalSpace(Dimens.spacing_24),
            const Divider(
              height: Dimens.spacing_1,
              thickness: Dimens.spacing_1,
              color: AppColors.grey_rgba_F8F9FE,
            ),
            addVerticalSpace(Dimens.spacing_16),
            ListTile(
              contentPadding: const EdgeInsets.only(left: Dimens.spacing_32),
              title: const Text(Strings.categories,
                  style: text_1F2024_16_Regular_w400),
              onTap: () {
                context.pop();
                context.pushRoute(const CategoriesRoute());
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: Dimens.spacing_32),
              title:
              const Text(Strings.rooms, style: text_1F2024_16_Regular_w400),
              onTap: () {
                context.pop();
                context.pushRoute(const RoomsRoute());
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: Dimens.spacing_32),
              title: const Text(Strings.search,
                  style: text_1F2024_16_Regular_w400),
              onTap: () {
                context.pop();
                context.pushRoute(SearchRoute());
              },
            ),
          ],
        ),
        const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.all(Dimens.spacing_8),
                child: Text("Version 1.0.0")))
      ]),
    );
  }
}
