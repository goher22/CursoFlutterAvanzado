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

class OnStopFollowUserEvent extends MapEvent {}

class OnStartFollowUserEvent extends MapEvent {}

class UpdateUserPolylineEvent extends MapEvent {
  final List<LatLng> userLocation;
  const UpdateUserPolylineEvent(this.userLocation);
}

class OnToggleUserRoute extends MapEvent {}

class DisplayPolylinesEvent extends MapEvent {
  final Map<String, Polyline> polylines;

  const DisplayPolylinesEvent(this.polylines);
}
