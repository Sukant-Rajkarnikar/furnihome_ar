import 'package:equatable/equatable.dart';
import 'package:furnihome_ar/common_models/furniture_model.dart';
import 'package:furnihome_ar/feature/rooms/model/rooms_model.dart';
import 'package:furnihome_ar/shared/enums/data_state_helper.dart';

class HomeScreenState extends Equatable {
  final String message;
  final DataConcreteState state;
  final List<FurnitureModel> featuredProducts;
  final List<RoomModel> rooms;
  final List<FurnitureModel> newArrivals;
  final List<FurnitureModel> arProducts;

  const HomeScreenState({
    required this.message,
    required this.state,
    required this.featuredProducts,
    required this.rooms,
    required this.newArrivals,
    required this.arProducts,
  });

  const HomeScreenState.initial({
    this.message = "",
    this.state = DataConcreteState.initial,
    this.featuredProducts = const [],
    this.rooms = const [],
    this.newArrivals = const [],
    this.arProducts = const [],
  });

  HomeScreenState copyWith({
    String? message,
    DataConcreteState? state,
    List<FurnitureModel>? featuredProducts,
    List<RoomModel>? rooms,
    List<FurnitureModel>? newArrivals,
    List<FurnitureModel>? arProducts,
  }) {
    return HomeScreenState(
      message: message ?? this.message,
      state: state ?? this.state,
      featuredProducts: featuredProducts ?? this.featuredProducts,
      rooms: rooms ?? this.rooms,
      newArrivals: newArrivals ?? this.newArrivals,
      arProducts: arProducts ?? this.arProducts,
    );
  }

  @override
  List<Object?> get props => [state, message, featuredProducts];
}
