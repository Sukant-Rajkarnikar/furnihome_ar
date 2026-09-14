import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnihome_ar/di/service_locator.dart';
import 'package:furnihome_ar/feature/rooms/data/rooms_repository.dart';
import 'package:furnihome_ar/feature/rooms/presentation/provider/state/rooms_screen_state.dart';
import 'package:furnihome_ar/shared/enums/data_state_helper.dart';
import 'package:furnihome_ar/shared/exceptions/parse_error.dart';

class RoomsScreenNotifier extends StateNotifier<RoomsScreenState> {
  RoomsScreenNotifier() : super(const RoomsScreenState.initial());

  static final RoomsRepository _repository =
      locator<RoomsRepository>();

  Future<void> getRoomsScreenData() async {
    state = state.copyWith(state: DataConcreteState.loading);
    try {
      final rooms = await _repository.getRoomList();
      state = state.copyWith(
        state: DataConcreteState.loaded,
        rooms: rooms,
      );
    } catch (e) {
      state = state.copyWith(
          state: DataConcreteState.failure, message: parseError(e));
    }
  }
}
