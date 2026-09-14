import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnihome_ar/feature/rooms/presentation/provider/state/rooms_screen_notifier.dart';
import 'package:furnihome_ar/feature/rooms/presentation/provider/state/rooms_screen_state.dart';

final roomsStateNotifierProvider =
    StateNotifierProvider<RoomsScreenNotifier, RoomsScreenState>(
  (ref) {
    return RoomsScreenNotifier();
  },
);
