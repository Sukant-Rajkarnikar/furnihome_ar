import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnihome_ar/feature/home/presentation/provider/state/home_screen_notifier.dart';
import 'package:furnihome_ar/feature/home/presentation/provider/state/home_screen_state.dart';

final homeStateNotifierProvider =
    StateNotifierProvider<HomeScreenNotifier, HomeScreenState>(
  (ref) {
    return HomeScreenNotifier();
  },
);
