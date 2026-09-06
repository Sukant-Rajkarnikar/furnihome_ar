import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnihome_ar/common_models/furniture_model.dart';
import 'package:furnihome_ar/feature/home/presentation/provider/home_screen_state_provider.dart';
import 'package:furnihome_ar/feature/rooms/model/rooms_model.dart';
import 'package:furnihome_ar/routes/app_route.gr.dart';
import 'package:furnihome_ar/shared/enums/data_state_helper.dart';
import 'package:furnihome_ar/utils/colors.dart';
import 'package:furnihome_ar/utils/dimens.dart';
import 'package:furnihome_ar/utils/image_constants.dart';
import 'package:furnihome_ar/utils/navigator_drawer_component.dart';
import 'package:furnihome_ar/utils/strings.dart';
import 'package:furnihome_ar/utils/text_styles.dart';
import 'package:furnihome_ar/utils/widget_functions.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(homeStateNotifierProvider.notifier).getHomeScreenData());
  }

  void _onRefresh() {
    ref.read(homeStateNotifierProvider.notifier).getHomeScreenData();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeStateNotifierProvider);
    ref.listen(homeStateNotifierProvider, (previous, next) {
      if (next.state == DataConcreteState.loaded) {
        _refreshController.refreshCompleted();
      } else if (next.state == DataConcreteState.failure) {
        _refreshController.refreshFailed();
      }
    });

    return Scaffold(
      drawer: const NavigatorDrawerComponent(),
      appBar: _appBar(),
      body: Container(
        color: const AppColors().backGroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.spacing_16, vertical: Dimens.spacing_16),
          child: SmartRefresher(
            onRefresh: _onRefresh,
            controller: _refreshController,
            child: SingleChildScrollView(
              child: _buildBody(state),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(dynamic state) {
    if (state.state == DataConcreteState.loading &&
        state.featuredProducts.isEmpty) {
      return SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: const Center(child: CircularProgressIndicator()));
    }
    if (state.state == DataConcreteState.failure &&
        state.featuredProducts.isEmpty) {
      return Center(child: Text(state.message ?? ''));
    }
    if (state.featuredProducts.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _bannerComponent(ImageConstants.IC_Banner_1),
        addVerticalSpace(Dimens.spacing_48),
        titleWidget(Strings.featuredProducts),
        addVerticalSpace(Dimens.spacing_16),
        _featuredProductsListWidget(state.featuredProducts),
        addVerticalSpace(Dimens.spacing_50),
        titleWidget(Strings.browseByRoom),
        addVerticalSpace(Dimens.spacing_16),
        _browseByRoomListWidget(state.rooms),
        addVerticalSpace(Dimens.spacing_48),
        titleWidget(Strings.ourNewReleases),
        addVerticalSpace(Dimens.spacing_8),
        _newArrivalsListWidget(state.newArrivals),
        addVerticalSpace(Dimens.spacing_48),
        _arProductWidget(state.arProducts),
        addVerticalSpace(Dimens.spacing_48),
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      leading: Builder(builder: (context) {
        return IconButton(
          icon: Image.asset(
            ImageConstants.IC_HAMBURGER_MENU_ICON,
            width: Dimens.spacing_20,
            height: Dimens.spacing_20,
            color: AppColors.black_rgba_1f2024,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      }),
      actionsPadding: const EdgeInsets.symmetric(horizontal: Dimens.spacing_16),
      actions: [
        InkWell(
          child: const Icon(Icons.search),
          onTap: () {},
        )
      ],
      centerTitle: true,
      title: Image.asset(
        ImageConstants.IC_APP_LOGO_TEXT,
        height: Dimens.spacing_28,
      ),
    );
  }

  Widget titleWidget(String title) {
    return Text(
      title,
      style: text_1F2024_18_Semibold_w400,
    );
  }

  Widget _bannerComponent(String image) {
    return Center(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimens.spacing_12),
          child: Image.asset(image)),
    );
  }

  Widget _featuredProductsListWidget(List<FurnitureModel> furnitureList) {
    return SizedBox(
      height: Dimens.spacing_350,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: furnitureList.length,
        itemBuilder: (BuildContext context, int index) {
          return _featuredProductsListItem(furnitureList[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return addHorizontalSpace(Dimens.spacing_24);
        },
      ),
    );
  }

  Widget _featuredProductsListItem(FurnitureModel furniture) {
    return InkWell(
      onTap: () {
        context.pushRoute(ProductDetailRoute(product: furniture));
      },
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(Dimens.spacing_16),
        child: Container(
          width: Dimens.spacing_300,
          height: Dimens.spacing_350,
          decoration: const BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(Dimens.spacing_16))),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: furniture.imageNames ?? "",
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      AppColors.black_rgba_1F2024.withAlpha(0),
                      AppColors.black_rgba_1F2024.withAlpha(225),
                    ])),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.spacing_16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        furniture.title ?? "N/A",
                        style: text_ffffff_24_Semibold_w600,
                      ),
                      Text(
                        furniture.category ?? "N/A",
                        style: text_ffffff_16_Regular_w400,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _browseByRoomListWidget(List<RoomModel> roomsList) {
    return SizedBox(
      height: Dimens.spacing_140,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: roomsList.length,
        itemBuilder: (BuildContext context, int index) {
          return _browseByRoomListItem(roomsList[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return addHorizontalSpace(Dimens.spacing_36);
        },
      ),
    );
  }

  Widget _browseByRoomListItem(RoomModel room) {
    return InkWell(
      onTap: () {
        //todo nav to room screen
        // context.pushRoute(ProductDetailRoute(product: furniture));
      },
      child: Column(
        children: [
          ClipOval(
            child: Container(
              height: Dimens.spacing_100,
              width: Dimens.spacing_100,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white_rbga_ffffff,
                  border:
                      Border.all(color: AppColors.grey_rgba_e0e7ff, width: 2)),
              child: Padding(
                padding: const EdgeInsets.all(Dimens.spacing_2),
                child: ClipOval(
                    child: CachedNetworkImage(
                        imageUrl: room.imageName, fit: BoxFit.cover)),
              ),
            ),
          ),
          addVerticalSpace(Dimens.spacing_8),
          Text(
            room.title.toUpperCase(),
            style: text_8F9098_14_Regular_w400,
          ),
        ],
      ),
    );
  }

  Widget _newArrivalsListWidget(List<FurnitureModel> newArrivalsList) {
    return SizedBox(
      height: Dimens.spacing_300,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: newArrivalsList.length,
        itemBuilder: (BuildContext context, int index) {
          return _newArrivalsListItem(newArrivalsList[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return addHorizontalSpace(Dimens.spacing_16);
        },
      ),
    );
  }

  Widget _newArrivalsListItem(FurnitureModel furniture) {
    return InkWell(
      onTap: () {
        context.pushRoute(ProductDetailRoute(product: furniture));
      },
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(Dimens.spacing_16),
        child: Container(
          height: Dimens.spacing_300,
          width: Dimens.spacing_200,
          decoration: BoxDecoration(
            color: AppColors.white_rbga_ffffff,
            borderRadius: BorderRadius.circular(Dimens.spacing_16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 125,
                child: CachedNetworkImage(
                  imageUrl: furniture.imageNames ?? "",
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(Dimens.spacing_16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        furniture.title ?? "N/A",
                        style: text_1F2024_18_Semibold_w600,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      addVerticalSpace(Dimens.spacing_8),
                      Text(
                        furniture.category ?? "N/A",
                        style: text_8F9098_14_Regular_w400,
                      ),
                      addVerticalSpace(Dimens.spacing_12),
                      Text(
                        "\$${furniture.price ?? "N/A"}",
                        style: text_7b44c0_18_semibold_w600,
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _arProductWidget(List<FurnitureModel> furnitureList) {
    if (furnitureList.isEmpty) return const SizedBox.shrink();
    FurnitureModel arFurniture = furnitureList[0];

    return InkWell(
      onTap: () {
        debugPrint("Moving");
        context.pushRoute(ARViewRoute(furnitureModel: furnitureList[0]));
      },
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(Dimens.spacing_16),
        child: Container(
          height: Dimens.spacing_350,
          decoration: const BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(Dimens.spacing_16))),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: arFurniture.imageNames ?? "",
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                      AppColors.white_rbga_ffffff.withAlpha(125),
                      AppColors.white_rbga_ffffff.withAlpha(200),
                    ])),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.spacing_16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: Dimens.spacing_56,
                        width: Dimens.spacing_56,
                        decoration: BoxDecoration(
                          color: AppColors.purple_rgba_9162ff.withAlpha(75),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.view_in_ar_rounded,
                          color: AppColors.purple_rgba_5400bf,
                          size: Dimens.spacing_24,
                        ),
                      ),
                      addVerticalSpace(Dimens.spacing_16),
                      const Text(
                        Strings.seeItInYourSpace,
                        style: text_1f2024_28_Bold_w800,
                      ),
                      addVerticalSpace(Dimens.spacing_12),
                      const Text(
                        Strings.seeItInYourSpaceText,
                        style: text_4c4c4c_18_Regular_w400,
                      ),
                      addVerticalSpace(Dimens.spacing_16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.purple_rgba_7b44c0,
                            elevation: Dimens.spacing_0,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimens.spacing_12),
                            )),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.lens_blur_rounded,
                              color: AppColors.white_rbga_ffffff,
                              size: Dimens.spacing_24,
                            ),
                            addHorizontalSpace(Dimens.spacing_4),
                            const Text(
                              Strings.tryItYourself,
                              style: text_ffffff_16_Regular_w400,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
