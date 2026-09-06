import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnihome_ar/common_models/furniture_model.dart';
import 'package:furnihome_ar/utils/colors.dart';
import 'package:furnihome_ar/utils/dimens.dart';
import 'package:furnihome_ar/utils/image_constants.dart';
import 'package:furnihome_ar/utils/strings.dart';
import 'package:furnihome_ar/utils/text_styles.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class ARViewScreen extends ConsumerStatefulWidget {
  final FurnitureModel furnitureModel;

  const ARViewScreen({super.key, required this.furnitureModel});

  @override
  ConsumerState<ARViewScreen> createState() => _ARViewScreenState();
}

class _ARViewScreenState extends ConsumerState<ARViewScreen> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const AppColors().backGroundColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(Dimens.spacing_16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.spacing_64)
                ),
                height:600,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.all(Radius.circular(Dimens.spacing_16)),
                  child: ModelViewer(

                    loading: Loading.lazy,
                    backgroundColor: AppColors.white_rbga_ffffff,
                    src: widget.furnitureModel.arObj ??
                        "https://pub-cbe50be54be740bda3d4cb2461dfcd79.r2.dev/models/Organic%20Wood%20Coffee%20Table.glb",
                    alt: "3D furniture model",
                    ar: false,
                    autoRotate: true,
                    cameraControls: true,
                    disableZoom: true,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.spacing_16),
              child: Text(
                  widget.furnitureModel.title ?? "",
                  style: text_1F2024_24_regular_400,
                ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(Dimens.spacing_24),
            //   child: ElevatedButton.icon(
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: AppColors.purple_rgba_7b44c0,
            //       foregroundColor: AppColors.white_rgba_ffffff,
            //       elevation: 8,
            //       shadowColor: AppColors.purple_rgba_7b44c0.withAlpha(70),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(32),
            //       ),
            //     ),
            //     icon: const Icon(Icons.view_in_ar_rounded, size: 28),
            //     label: const Text(
            //       Strings.tryItYourself,
            //       style: text_ffffff_16_Semibold_w600,
            //     ),
            //     onPressed: launchDirectAR,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
