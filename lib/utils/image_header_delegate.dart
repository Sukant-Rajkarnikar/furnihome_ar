import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:furnihome_ar/utils/colors.dart';
import 'package:furnihome_ar/utils/image_constants.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ImageHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final String imageUrl;
  final String arUrl;
  final bool is3DModelActive;

  ImageHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.imageUrl,
    required this.arUrl,
    required this.is3DModelActive,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: is3DModelActive
          ? ModelViewer(
        loading: Loading.lazy,
        backgroundColor:  AppColors.grey_rgba_F0F2F5,
        poster: ImageConstants.IC_Banner_1,
        src: arUrl,
        alt: "3D furniture model",
        ar: false,
        autoRotate: true,
        cameraControls: true,
        disableZoom: true,
      )
          : CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant ImageHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxExtent ||
        minHeight != oldDelegate.minExtent ||
        imageUrl != oldDelegate.imageUrl ||
        arUrl != oldDelegate.arUrl ||
        is3DModelActive != oldDelegate.is3DModelActive;
  }
}