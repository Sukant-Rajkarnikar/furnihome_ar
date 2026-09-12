import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnihome_ar/common_models/furniture_model.dart';
import 'package:furnihome_ar/feature/search/presentation/provider/search_screen_state_provider.dart';
import 'package:furnihome_ar/feature/search/presentation/provider/state/search_screen_state.dart';
import 'package:furnihome_ar/shared/enums/data_state_helper.dart';
import 'package:furnihome_ar/shared/widget/custom_text_field.dart';
import 'package:furnihome_ar/utils/colors.dart';
import 'package:furnihome_ar/utils/dimens.dart';
import 'package:furnihome_ar/utils/image_constants.dart';
import 'package:furnihome_ar/utils/strings.dart';
import 'package:furnihome_ar/utils/text_styles.dart';
import 'package:furnihome_ar/utils/widget_functions.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

@RoutePage()
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final List<int> _rooms = [];
  final List<int> _categories = [];
  int _offset = 0;

  final RefreshController _refreshController = RefreshController();
  final TextEditingController _searchController = TextEditingController();

  bool _isGridView = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData(isLoadMore: false);
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _fetchData({bool isLoadMore = false}) {
    if (!isLoadMore) {
      _offset = 0;
      // Invalidate the provider to clear the old state and results
      // before starting a completely fresh search.
      ref.invalidate(searchStateNotifierProvider);
    } else {
      final currentProductsCount = ref.read(searchStateNotifierProvider).searchResponse?.products.length ?? 0;
      _offset = currentProductsCount;
    }

    // Call the notifier (which will be a fresh instance if invalidated above)
    ref.read(searchStateNotifierProvider.notifier).searchFurniture(
      _rooms,
      _categories,
      _searchController.text.trim(),
      _offset,
    );
  }

  void _onRefresh() {
    _fetchData(isLoadMore: false);
  }

  void _onLoading() {
    _fetchData(isLoadMore: true);
  }

  void _removeFilter(int index) {
    setState(() {
      if (index < _rooms.length) {
        _rooms.removeAt(index);
      } else {
        _categories.removeAt(index - _rooms.length);
      }
    });
    _fetchData(isLoadMore: false);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchStateNotifierProvider);

    ref.listen(searchStateNotifierProvider, (previous, next) {
      if (next.state == DataConcreteState.loaded) {
        _refreshController.refreshCompleted();

        final productsCount = next.searchResponse?.products.length ?? 0;
        final totalCount = next.searchResponse?.count ?? 0;

        if (productsCount > 0 && productsCount >= totalCount) {
          _refreshController.loadNoData();
        } else {
          _refreshController.loadComplete();
        }
      } else if (next.state == DataConcreteState.failure) {
        _refreshController.refreshFailed();
        _refreshController.loadFailed();
      }
    });

    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: Container(
          color: const AppColors().backGroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimens.spacing_16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing_16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          textController: _searchController,
                          borderRadius: Dimens.spacing_12,
                          hintText: Strings.search_furniture,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) => _fetchData(isLoadMore: false),
                        ),
                      ),
                      addHorizontalSpace(Dimens.spacing_16),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.grey_rgba_4C4C4C.withAlpha(30),
                                blurRadius: 2,
                                blurStyle: BlurStyle.normal,
                                offset: const Offset(0, 1)),
                          ],
                          borderRadius: BorderRadius.circular(Dimens.spacing_12),
                          color: const AppColors().primaryColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: Dimens.spacing_10,
                              horizontal: Dimens.spacing_16),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.tune_rounded,
                                color: AppColors.white_rbga_ffffff,
                                size: Dimens.spacing_24,
                              ),
                              addHorizontalSpace(Dimens.spacing_8),
                              Text(
                                Strings.filter.toUpperCase(),
                                style: text_ffffff_14_Semibold_w600,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                addVerticalSpace(Dimens.spacing_16),
                if (_rooms.isNotEmpty || _categories.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.only(left: Dimens.spacing_16),
                    child: _filterList(),
                  ),
                  addVerticalSpace(Dimens.spacing_16),
                ],
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing_16),
                  child: Divider(
                    height: Dimens.spacing_0_3,
                    color: AppColors.black_rgba_e0e0e0.withAlpha(150),
                  ),
                ),
                Expanded(
                  child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    controller: _refreshController,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: Dimens.spacing_16),
                      child: _buildBody(state),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(SearchScreenState state) {
    final searchResponse = state.searchResponse;
    final products = searchResponse?.products ?? [];

    if (state.state == DataConcreteState.loading && products.isEmpty) {
      return SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: const Center(child: CircularProgressIndicator()));
    }
    if (state.state == DataConcreteState.failure && products.isEmpty) {
      return Center(child: Text(state.message ?? 'An error occurred'));
    }
    if (products.isEmpty && state.state == DataConcreteState.loaded) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: const Center(child: Text("No furniture found.")),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing_16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${searchResponse?.count ?? 0} results",
                style: text_1F2024_20_semibold_600,
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white_rbga_ffffff,
                  borderRadius: BorderRadius.circular(Dimens.spacing_12),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.grey_rgba_4C4C4C.withAlpha(30),
                        blurRadius: 2,
                        blurStyle: BlurStyle.normal,
                        offset: const Offset(0, 1)),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing_2),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => _isGridView = true),
                        child: Padding(
                          padding: const EdgeInsets.all(Dimens.spacing_4),
                          child: _isGridView
                              ? _buildActiveToggleIcon(Icons.apps_rounded)
                              : _buildInactiveToggleIcon(Icons.apps_rounded),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _isGridView = false),
                        child: Padding(
                          padding: const EdgeInsets.all(Dimens.spacing_4),
                          child: !_isGridView
                              ? _buildActiveToggleIcon(Icons.table_rows_rounded)
                              : _buildInactiveToggleIcon(Icons.table_rows_rounded),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        addVerticalSpace(Dimens.spacing_16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing_16),
          child: _isGridView
              ? GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: Dimens.spacing_16,
              crossAxisSpacing: Dimens.spacing_16,
              childAspectRatio: 0.65,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final item = products[index];
              return _gridViewItem(item);
            },
          )
              : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            separatorBuilder: (context, index) => addVerticalSpace(Dimens.spacing_16),
            itemBuilder: (context, index) {
              final item = products[index];
              return _listViewItem(item);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActiveToggleIcon(IconData icon) {
    return BackdropFilter(
      filter: ImageFilter.blur(),
      child: Container(
        decoration: BoxDecoration(
          color: const AppColors().primaryColor,
          borderRadius: BorderRadius.circular(Dimens.spacing_8),
        ),
        padding: const EdgeInsets.all(Dimens.spacing_8),
        child: Icon(
          icon,
          size: Dimens.spacing_20,
          color: AppColors.white_rbga_ffffff,
        ),
      ),
    );
  }

  Widget _buildInactiveToggleIcon(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(Dimens.spacing_8),
      ),
      padding: const EdgeInsets.all(Dimens.spacing_8),
      child: Icon(
        icon,
        size: Dimens.spacing_20,
        color: AppColors.black_rgba_e0e0e0,
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      leading: Builder(builder: (context) {
        return IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            context.maybePop();
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

  Widget _filterList() {
    final int totalFilters = _rooms.length + _categories.length;

    return SizedBox(
      height: Dimens.spacing_36,
      child: ListView.separated(
        padding: const EdgeInsets.only(right: Dimens.spacing_16),
        scrollDirection: Axis.horizontal,
        itemCount: totalFilters,
        separatorBuilder: (context, index) => addHorizontalSpace(Dimens.spacing_8),
        itemBuilder: (context, index) {
          String filterText = "";
          if (index < _rooms.length) {
            filterText = "Room ID: ${_rooms[index]}";
          } else {
            filterText = "Category ID: ${_categories[index - _rooms.length]}";
          }

          return Container(
            decoration: BoxDecoration(
              color: AppColors.white_rbga_ffffff,
              borderRadius: BorderRadius.circular(Dimens.spacing_20),
              boxShadow: [
                BoxShadow(
                    color: AppColors.grey_rgba_4C4C4C.withAlpha(30),
                    blurRadius: 2,
                    blurStyle: BlurStyle.normal,
                    offset: const Offset(0, 1)),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing_8),
              child: Row(
                children: [
                  addHorizontalSpace(Dimens.spacing_4),
                  Text(
                    filterText,
                    style: text_1F2024_14_regular_w400,
                  ),
                  addHorizontalSpace(Dimens.spacing_2),
                  InkWell(
                    onTap: () => _removeFilter(index),
                    child: const Padding(
                      padding: EdgeInsets.all(Dimens.spacing_4),
                      child: Icon(
                        Icons.close_rounded,
                        size: Dimens.spacing_20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _listViewItem(FurnitureModel item) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.spacing_16),
        color: AppColors.white_rbga_ffffff,
        boxShadow: [
          BoxShadow(
              color: AppColors.grey_rgba_4C4C4C.withAlpha(30),
              blurRadius: 2,
              blurStyle: BlurStyle.normal,
              offset: const Offset(0, 1)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(Dimens.spacing_16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(Dimens.spacing_16),
                    child: SizedBox(
                      height: Dimens.spacing_132,
                      width: Dimens.spacing_132,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: item.imageNames ?? "",
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(Dimens.spacing_8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Dimens.spacing_20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(Dimens.spacing_20),
                              border: BoxBorder.all(
                                  color: AppColors.white_rbga_ffffff
                                      .withAlpha(200)),
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.white_rbga_ffffff.withAlpha(200),
                                  AppColors.white_rbga_ffffff.withAlpha(100),
                                ],
                                begin: AlignmentGeometry.bottomRight,
                                end: AlignmentGeometry.topLeft,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimens.spacing_6,
                                  vertical: Dimens.spacing_2),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.view_in_ar_rounded,
                                    color: const AppColors().primaryColor,
                                    shadows: [
                                      Shadow(
                                        color: AppColors.white_rbga_ffffff
                                            .withAlpha(200),
                                        blurRadius: 10.0,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                    size: Dimens.spacing_14,
                                  ),
                                  addHorizontalSpace(Dimens.spacing_4),
                                  Text(
                                    Strings.ar.toUpperCase(),
                                    style: text_7b44c0_12_Medium_w600
                                        .copyWith(shadows: [
                                      Shadow(
                                        color: AppColors.white_rbga_ffffff
                                            .withAlpha(200),
                                        blurRadius: 10.0,
                                        offset: const Offset(0, 1),
                                      ),
                                    ]),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            addHorizontalSpace(Dimens.spacing_18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title ?? "N/A",
                    style: text_1F2024_18_Semibold_w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                  addVerticalSpace(Dimens.spacing_2),
                  Text(
                    item.dimensions ?? "No Dimensions available",
                    style: text_2F3036_14_semibold_w600,
                  ),
                  addVerticalSpace(Dimens.spacing_10),
                  Row(
                    children: [
                      Text(
                        item.category ?? "No Category",
                        style: text_71727a_14_regular_w400,
                      ),
                      addHorizontalSpace(Dimens.spacing_4),
                      const Text("•", style: text_71727a_14_regular_w400),
                      addHorizontalSpace(Dimens.spacing_4),
                      Text(item.room ?? "No Room", style: text_71727a_14_regular_w400),
                    ],
                  ),
                  addVerticalSpace(Dimens.spacing_8),
                  Text(
                    "\$${item.price ?? ''}",
                    style: text_7b44c0_18_semibold_w600,
                  ),
                  addVerticalSpace(Dimens.spacing_8),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _gridViewItem(FurnitureModel item) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.spacing_16),
        color: AppColors.white_rbga_ffffff,
        boxShadow: [
          BoxShadow(
              color: AppColors.grey_rgba_4C4C4C.withAlpha(30),
              blurRadius: 2,
              blurStyle: BlurStyle.normal,
              offset: const Offset(0, 1)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(Dimens.spacing_16),
                  topRight: Radius.circular(Dimens.spacing_16),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: Dimens.spacing_132,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: item.imageNames ?? "",
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.spacing_8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimens.spacing_20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimens.spacing_20),
                          border: BoxBorder.all(
                              color: AppColors.white_rbga_ffffff.withAlpha(200)),
                          gradient: LinearGradient(
                            colors: [
                              AppColors.white_rbga_ffffff.withAlpha(200),
                              AppColors.white_rbga_ffffff.withAlpha(100),
                            ],
                            begin: AlignmentGeometry.bottomRight,
                            end: AlignmentGeometry.topLeft,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimens.spacing_6,
                              vertical: Dimens.spacing_2),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.view_in_ar_rounded,
                                color: const AppColors().primaryColor,
                                shadows: [
                                  Shadow(
                                    color: AppColors.white_rbga_ffffff.withAlpha(200),
                                    blurRadius: 10.0,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                                size: Dimens.spacing_16,
                              ),
                              addHorizontalSpace(Dimens.spacing_4),
                              Text(
                                Strings.ar.toUpperCase(),
                                style: text_7b44c0_14_Medium_w600.copyWith(shadows: [
                                  Shadow(
                                    color: AppColors.white_rbga_ffffff.withAlpha(200),
                                    blurRadius: 10.0,
                                    offset: const Offset(0, 1),
                                  ),
                                ]),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          addVerticalSpace(Dimens.spacing_4),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimens.spacing_12, vertical: Dimens.spacing_8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title ?? "N/A",
                  style: text_1F2024_18_Semibold_w600,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                addVerticalSpace(Dimens.spacing_6),
                Text(
                  item.dimensions ?? "No Dimensions available",
                  style: text_2F3036_14_semibold_w600,
                ),
                addVerticalSpace(Dimens.spacing_8),
                Text(
                  "\$${item.price ?? 'N/A'}",
                  style: text_7b44c0_18_semibold_w600,
                )
              ],
            ),
          ),
          addVerticalSpace(Dimens.spacing_8),
        ],
      ),
    );
  }
}