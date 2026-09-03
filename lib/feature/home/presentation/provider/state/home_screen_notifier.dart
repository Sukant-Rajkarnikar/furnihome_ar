import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnihome_ar/di/service_locator.dart';
import 'package:furnihome_ar/feature/home/data/home_repository.dart';
import 'package:furnihome_ar/feature/home/presentation/provider/state/home_screen_state.dart';
import 'package:furnihome_ar/shared/enums/data_state_helper.dart';
import 'package:furnihome_ar/shared/exceptions/parse_error.dart';

class HomeScreenNotifier extends StateNotifier<HomeScreenState> {
  HomeScreenNotifier() : super(const HomeScreenState.initial());

  static final HomeRepository _repository = locator<HomeRepository>();

  Future<void> getHomeScreenData() async {
    state = state.copyWith(state: DataConcreteState.loading);
    try {
      final featuredProducts = await _repository.getFeaturedProducts();
      final newProducts = await _repository.getNewProducts();
      final arProducts = await _repository.getArProducts();
      final roomList = await _repository.getRoomList();
      state = state.copyWith(
          state: DataConcreteState.loaded,
          featuredProducts: featuredProducts,
          newArrivals: newProducts,
          arProducts: arProducts,
          rooms: roomList);
    } catch (e) {
      state = state.copyWith(
          state: DataConcreteState.failure, message: parseError(e));
    }
  }
}
