import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnihome_ar/common_models/furniture_model.dart';
import 'package:furnihome_ar/utils/colors.dart';
import 'package:furnihome_ar/utils/dimens.dart';
import 'package:furnihome_ar/utils/image_constants.dart';
import 'package:furnihome_ar/utils/image_header_delegate.dart';
import 'package:furnihome_ar/utils/strings.dart';
import 'package:furnihome_ar/utils/text_styles.dart';
import 'package:furnihome_ar/utils/utils.dart';
import 'package:furnihome_ar/utils/widget_functions.dart';
import 'package:url_launcher/url_launcher.dart';

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
  bool is3DModelActive = false;

  @override
  void initState() {
    super.initState();
    getDimensions();
  }

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
                  delegate: ImageHeaderDelegate(
                    minHeight: 250.0,
                    maxHeight: screenWidth,
                    imageUrl: widget.product.imageNames ?? "",
                    arUrl: widget.product.arObj ??
                        "https://pub-cbe50be54be740bda3d4cb2461dfcd79.r2.dev/models/Organic%20Wood%20Coffee%20Table.glb",
                    is3DModelActive: is3DModelActive,
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
            Positioned(
              top: 0,
              left: 0,
              child: InkWell(
                onTap: () {
                  context.maybePop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.spacing_12),
                  child: ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.all(Dimens.spacing_8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.white_rgba_ffffff.withAlpha(175),
                          ),
                          gradient: RadialGradient(
                            colors: [
                              AppColors.white_rgba_ffffff.withAlpha(175),
                              AppColors.white_rgba_ffffff.withAlpha(75),
                            ],
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: const AppColors().primaryColor,
                          shadows: [
                            Shadow(
                              color: AppColors.white_rbga_ffffff.withAlpha(200),
                              blurRadius: 10.0,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Padding(
                  padding: const EdgeInsets.all(Dimens.spacing_12),
                  child: _buildViewToggle()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewToggle() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.white_rgba_ffffff.withAlpha(200),
            ),
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [
                AppColors.white_rgba_ffffff.withAlpha(200),
                AppColors.white_rgba_ffffff.withAlpha(10),
              ],
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    is3DModelActive = false;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: !is3DModelActive
                        ? const AppColors().primaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.photo_library_outlined,
                        size: 16,
                        color: !is3DModelActive
                            ? AppColors.white_rbga_ffffff
                            : const AppColors().primaryColor,
                      ),
                      addHorizontalSpace(6),
                      Text(
                        Strings.photo.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          letterSpacing: 0.5,
                          color: !is3DModelActive
                              ? AppColors.white_rbga_ffffff
                              : const AppColors().primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    is3DModelActive = true;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: is3DModelActive
                        ? const AppColors().primaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.view_in_ar,
                        size: 16,
                        color: is3DModelActive
                            ? AppColors.white_rbga_ffffff
                            : const AppColors().primaryColor,
                      ),
                      addHorizontalSpace(6),
                      Text(
                        Strings.threeDModel.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          letterSpacing: 0.5,
                          shadows: [
                            Shadow(
                              color: AppColors.white_rbga_ffffff.withAlpha(128),
                              blurRadius: 2.0,
                              offset: const Offset(0, 1),
                            ),
                          ],
                          color: is3DModelActive
                              ? AppColors.white_rbga_ffffff
                              : const AppColors().primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
            launchDirectAR();
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

  void getDimensions() {
    String dimension = widget.product.dimensions ?? "";
    final wMatch = RegExp(r'W(\d+)').firstMatch(dimension);
    final hMatch = RegExp(r'H(\d+)').firstMatch(dimension);
    final dMatch = RegExp(r'D(\d+)').firstMatch(dimension);

    furnitureWidth = wMatch != null ? double.parse(wMatch.group(1)!) : 0;
    furnitureHeight = hMatch != null ? double.parse(hMatch.group(1)!) : 0;
    furnitureDepth = dMatch != null ? double.parse(dMatch.group(1)!) : 0;
  }

  Future<void> launchDirectAR() async {
    final glbUrl = widget.product.arObj ??
        "https://pub-cbe50be54be740bda3d4cb2461dfcd79.r2.dev/models/Organic%20Wood%20Coffee%20Table.glb";
    final String encodedUrl = Uri.encodeComponent(glbUrl);
    final String sceneViewerUrl =
        'https://arvr.google.com/scene-viewer/1.0?file=$encodedUrl&mode=ar_only&resizable=false';
    try {
      await launchUrl(
        Uri.parse(sceneViewerUrl),
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      debugPrint("Error launching AR: $e");
    }
  }
}
