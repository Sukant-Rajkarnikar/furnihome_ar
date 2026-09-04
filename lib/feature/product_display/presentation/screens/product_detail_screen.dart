import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnihome_ar/common_models/furniture_model.dart';
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

  double furnitureWidth = 0;
  double furnitureDepth = 0;
  double furnitureHeight = 0;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const AppColors().backGroundColor,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Dimens.spacing_8, horizontal: Dimens.spacing_16),
          child: _getARViewButton(context, widget.product),
        ),
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _ImageHeaderDelegate(
                    minHeight: 250.0,
                    maxHeight: screenWidth,
                    imageUrl: widget.product.imageNames ?? "",
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: const AppColors().backGroundColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.spacing_24,
                      vertical: Dimens.spacing_24,
                    ),
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
                        Text(
                          widget.product.desc ?? "N/A",
                          style: text_1f2024_16_Regular_w400,
                        ),
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
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    Strings.room,
                                    style: text_4C4C4C_16_regular_w400.copyWith(
                                        letterSpacing: 0.3),
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
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    Strings.category,
                                    style: text_4C4C4C_16_regular_w400.copyWith(
                                        letterSpacing: 0.3),
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
                        addVerticalSpace(Dimens.spacing_8),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    Strings.width,
                                    style: text_4C4C4C_16_regular_w400.copyWith(
                                        letterSpacing: 0.3),
                                  ),
                                  Text(
                                    "$furnitureWidth\"",
                                    style: text_1F2024_20_regular_400,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    Strings.depth,
                                    style: text_4C4C4C_16_regular_w400.copyWith(
                                        letterSpacing: 0.3),
                                  ),
                                  Text(
                                    "$furnitureDepth\"",
                                    style: text_1F2024_20_regular_400,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    Strings.height,
                                    style: text_4C4C4C_16_regular_w400.copyWith(
                                        letterSpacing: 0.3),
                                  ),
                                  Text(
                                    "$furnitureHeight\"",
                                    style: text_1F2024_20_regular_400,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        addVerticalSpace(Dimens.spacing_32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Custom fixed back button overlay
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: Dimens.spacing_64,
                width: MediaQuery.sizeOf(context).width,
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const AppColors().backGroundColor.withAlpha(0),
                      const AppColors().backGroundColor.withAlpha(255),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const AppColors().backGroundColor.withAlpha(150),
                        const AppColors().backGroundColor.withAlpha(10),
                      ],
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    onPressed: () {
                      context.popRoute();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getARViewButton(BuildContext context, FurnitureModel product) {
    return SizedBox(
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
            const Text(
              Strings.tryItYourself,
              style: text_ffffff_16_Semibold_w600,
            )
          ],
        ),
      ),
    );
  }

  void getDimensions(){
    String dimension = widget.product.dimensions ?? "";

    final wMatch = RegExp(r'W(\d+)').firstMatch(dimension);
    final hMatch = RegExp(r'H(\d+)').firstMatch(dimension);
    final dMatch = RegExp(r'D(\d+)').firstMatch(dimension);

    furnitureWidth = wMatch != null ? double.parse(wMatch.group(1)!) : 0;
    furnitureHeight = hMatch != null ? double.parse(hMatch.group(1)!) : 0;
    furnitureDepth = dMatch != null ? double.parse(dMatch.group(1)!) : 0;
  }

}

class _ImageHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final String imageUrl;

  _ImageHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.imageUrl,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _ImageHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxExtent ||
        minHeight != oldDelegate.minExtent ||
        imageUrl != oldDelegate.imageUrl;
  }
}
