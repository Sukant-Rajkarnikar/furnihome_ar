import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnihome_ar/feature/rooms/data/model/rooms_model.dart';
import 'package:furnihome_ar/feature/rooms/presentation/provider/rooms_screen_state_provider.dart';
import 'package:furnihome_ar/feature/rooms/presentation/provider/state/rooms_screen_state.dart';
import 'package:furnihome_ar/routes/app_route.gr.dart';
import 'package:furnihome_ar/routes/route_util.dart';
import 'package:furnihome_ar/shared/enums/data_state_helper.dart';
import 'package:furnihome_ar/utils/colors.dart';
import 'package:furnihome_ar/utils/dimens.dart';
import 'package:furnihome_ar/utils/image_constants.dart';
import 'package:furnihome_ar/utils/strings.dart';
import 'package:furnihome_ar/utils/text_styles.dart';
import 'package:furnihome_ar/utils/widget_functions.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

@RoutePage()
class RoomsScreen extends ConsumerStatefulWidget {
  const RoomsScreen({super.key});

  @override
  ConsumerState<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends ConsumerState<RoomsScreen> {
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        ref.read(roomsStateNotifierProvider.notifier).getRoomsScreenData());
  }

  void _onRefresh() {
    ref.read(roomsStateNotifierProvider.notifier).getRoomsScreenData();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(roomsStateNotifierProvider);
    ref.listen(roomsStateNotifierProvider, (previous, next) {
      if (next.state == DataConcreteState.loaded) {
        _refreshController.refreshCompleted();
      } else if (next.state == DataConcreteState.failure) {
        _refreshController.refreshFailed();
      }
    });

    return Scaffold(
      appBar: _appBar(context),
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

  Widget _buildBody(RoomsScreenState state) {
    if (state.state == DataConcreteState.loading && state.rooms.isEmpty) {
      return SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: const Center(child: CircularProgressIndicator()));
    }
    if (state.state == DataConcreteState.failure && state.rooms.isEmpty) {
      return Center(child: Text(state.message ?? ''));
    }
    if (state.rooms.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          Strings.exploreByRoom,
          style: text_1f2024_30_Semibold_w600,
        ),
        addVerticalSpace(Dimens.spacing_4),
        const Text(
          Strings.exploreByRoomText,
          style: text_1F2024_16_Regular_w400,
        ),
        addVerticalSpace(Dimens.spacing_24),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.rooms.length,
          separatorBuilder: (context, index) =>
              addVerticalSpace(Dimens.spacing_24),
          itemBuilder: (context, index) {
            final room = state.rooms[index];
            return _roomListItem(room);
          },
        ),
        addVerticalSpace(Dimens.spacing_48),
      ],
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: Builder(builder: (context) {
        return IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            context.pop();
          },
        );
      }),
      centerTitle: true,
      title: Image.asset(
        ImageConstants.IC_APP_LOGO_TEXT,
        height: Dimens.spacing_28,
      ),
    );
  }

  Widget _roomListItem(RoomModel room) {
    return InkWell(
      onTap: () {
        context.pushRoute(SearchRoute(initialRooms: [room.id]));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.spacing_16),
          boxShadow: [
            BoxShadow(
                color: AppColors.grey_rgba_4C4C4C.withAlpha(30),
                blurRadius: 2,
                blurStyle: BlurStyle.normal,
                offset: const Offset(0, 1)),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimens.spacing_16),
          child: SizedBox(
            height: Dimens.spacing_200,
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: room.imageName,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  memCacheWidth: 600,
                  maxWidthDiskCache: 600,
                  fadeInDuration: const Duration(milliseconds: 300),
                  placeholder: (context, url) => Container(
                    color: AppColors.grey_rgba_F0F2F5,
                    child: const Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.purple_rgba_5400bf,),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.grey_rgba_F0F2F5,
                    child: const Center(
                      child: Icon(Icons.image_not_supported, color: Colors.grey),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: AlignmentGeometry.bottomCenter,
                          end: AlignmentGeometry.center,
                          colors: [
                        AppColors.black_rgba_1F2024.withAlpha(220),
                        AppColors.black_rgba_1F2024.withAlpha(30)
                      ])),
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(Dimens.spacing_16),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            room.title,
                            style: text_ffffff_24_Semibold_w600,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.spacing_16),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: AppColors.white_rbga_ffffff,
                                shape: BoxShape.circle,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(Dimens.spacing_8),
                                child: Icon(Icons.arrow_forward_rounded),
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
