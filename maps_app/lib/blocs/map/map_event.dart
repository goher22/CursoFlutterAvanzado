part of 'map_bloc.dart';

sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class onMapInitialzedEvent extends MapEvent {
  final GoogleMapController controller;
  const onMapInitialzedEvent(this.controller);
}
