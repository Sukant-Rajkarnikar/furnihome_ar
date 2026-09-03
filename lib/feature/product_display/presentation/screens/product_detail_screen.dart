import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnihome_ar/common_models/furniture_model.dart';
import 'package:furnihome_ar/routes/route_util.dart';
import 'package:furnihome_ar/utils/colors.dart';
import 'package:furnihome_ar/utils/dimens.dart';
import 'package:furnihome_ar/utils/image_constants.dart';
import 'package:furnihome_ar/utils/strings.dart';
import 'package:furnihome_ar/utils/text_styles.dart';
import 'package:furnihome_ar/utils/utils.dart';
import 'package:furnihome_ar/utils/widget_functions.dart';

@RoutePage()
class ProductDetailScreen extends ConsumerStatefulWidget {
  final FurnitureModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        color: const AppColors().backGroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CachedNetworkImage(imageUrl: widget.product.imageNames ?? ""),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.spacing_24, vertical: Dimens.spacing_24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              widget.product.title ?? "N/A",
                              style: text_1f2024_28_Semibold_w600,
                            ),
                            addVerticalSpace(Dimens.spacing_8),
                            Text(
                              "\$ ${widget.product.price}",
                              style: text_7b44c0_24_Semibold_w600,
                            ),
                            addVerticalSpace(Dimens.spacing_8),
                            Text(widget.product.desc ?? "N/A", style: text_1f2024_16_Regular_w400,),
                            addVerticalSpace(Dimens.spacing_32),
                            Text(
                              Strings.details.toUpperCase(),
                              style: text_4C4C4C_16_Semibold_w400,
                            ),
                            addVerticalSpace(Dimens.spacing_8),
                            const Divider(
                              color: AppColors.black_rgba_e0e0e0,
                              height: Dimens.spacing_0_5,
                            ),
                            addVerticalSpace(Dimens.spacing_8),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        Strings.room,
                                        style: text_4C4C4C_16_regular_w400
                                            .copyWith(letterSpacing: 0.3),
                                      ),
                                      Text(
                                        widget.product.room ?? "N/A",
                                        style: text_1F2024_20_regular_400,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        Strings.category,
                                        style: text_4C4C4C_16_regular_w400
                                            .copyWith(letterSpacing: 0.3),
                                      ),
                                      Text(
                                        widget.product.category ?? "N/A",
                                        style: text_1F2024_20_regular_400,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            addVerticalSpace(Dimens.spacing_32),
                            Text(
                              Strings.dimensions.toUpperCase(),
                              style: text_4C4C4C_16_Semibold_w400,
                            ),
                            addVerticalSpace(Dimens.spacing_8),
                            const Divider(
                              color: AppColors.black_rgba_e0e0e0,
                              height: Dimens.spacing_0_5,
                            ),
                            addVerticalSpace(Dimens.spacing_32),
                          ],
                        ),
                      ),
                    ),
                    _getARViewButton(context, widget.product),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () {
          context.pop();
        },
      ),
    );
  }

  Widget _getARViewButton(BuildContext context, FurnitureModel product) {
    return SizedBox(
      width: Dimens.spacing_170,
      height: Dimens.spacing_48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.purple_rgba_7b44c0,
            elevation: Dimens.spacing_0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimens.spacing_12),
            )),
        onPressed: () {
          if (product.arObj?.isEmpty ?? true) {
            showToast(Strings.ar_view_unavailable, false);
          } else {
            //todo Navigate to AR View Screen
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageConstants.IC_AR_ICON,
              height: Dimens.spacing_22,
              width: Dimens.spacing_22,
            ),
            addHorizontalSpace(Dimens.spacing_8),
            Text(
              Strings.tryItYourself,
              style: text_ffffff_16_Semibold_w600,
            )
          ],
        ),
      ),
    );
  }
}
