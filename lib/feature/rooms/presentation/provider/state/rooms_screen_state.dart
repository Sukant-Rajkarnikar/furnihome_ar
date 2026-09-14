import 'package:equatable/equatable.dart';
import 'package:furnihome_ar/feature/rooms/data/model/rooms_model.dart';
import 'package:furnihome_ar/shared/enums/data_state_helper.dart';

class RoomsScreenState extends Equatable {
  final String message;
  final DataConcreteState state;
  final List<RoomModel> rooms;

  const RoomsScreenState({
    required this.message,
    required this.state,
    required this.rooms,
  });

  const RoomsScreenState.initial({
    this.message = "",
    this.state = DataConcreteState.initial,
    this.rooms = const [],
  });

  RoomsScreenState copyWith({
    String? message,
    DataConcreteState? state,
    List<RoomModel>? rooms,
  }) {
    return RoomsScreenState(
      message: message ?? this.message,
      state: state ?? this.state,
      rooms: rooms ?? this.rooms,
    );
  }

  @override
  List<Object?> get props => [state, message, rooms];
}
