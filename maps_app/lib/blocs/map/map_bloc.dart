import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/route_destination.dart';

import '../../themes/WY.dart';
import '../location/location_bloc.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  LatLng? mapCenter;

  StreamSubscription<LocationState>? locationStateSubscription;

  MapBloc({
    required this.locationBloc,
  }) : super(const MapState()) {
    on<onMapInitialzedEvent>(_onInitMap);
    on<OnStartFollowUserEvent>(_onStartFollowUserEvent);
    on<OnStopFollowUserEvent>(
        (event, emit) => emit(state.copyWith(isFollowUser: false)));
    on<OnToggleUserRoute>(
        (event, emit) => emit(state.copyWith(showMyRoute: !state.showMyRoute)));

    on<UpdateUserPolylineEvent>(_onPolylineNewPoint);
    on<DisplayPolylinesEvent>((event, emit) => state.copyWith(
          polylines: event.polylines,
          markes: event.markers,
        ));

    locationStateSubscription = locationBloc.stream.listen((locationState) {
      if (locationState.lastKnowLocation != null) {
        add(UpdateUserPolylineEvent(locationState.myLocationHistory));
      }
      if (!state.isFollowUser || locationState.lastKnowLocation == null) return;
      moveCamera(locationState.lastKnowLocation!);
    });
  }

  void _onInitMap(onMapInitialzedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;
    _mapController!.setMapStyle(jsonEncode(wyTheme));
    emit(state.copyWith(isMapInitialized: true));
  }

  void _onStartFollowUserEvent(
      OnStartFollowUserEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(isFollowUser: true));
    if (locationBloc.state.lastKnowLocation == null) return;
    moveCamera(locationBloc.state.lastKnowLocation!);
  }

  void _onPolylineNewPoint(
      UpdateUserPolylineEvent event, Emitter<MapState> emit) {
    const myRoute = Polyline(
      polylineId: PolylineId("myRoute"),
      color: Colors.black,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['myRoute'] = myRoute;

    emit(state.copyWith(polylines: currentPolylines));
  }

  Future drawRouterPolyline(RouteDestination destination) async {
    final myRouter = Polyline(
      polylineId: const PolylineId("route"),
      color: Colors.black,
      width: 5,
      points: destination.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );

    final startMarker = Marker(
      markerId: MarkerId("start"),
      position: destination.points.first,
    );

    final endMarker = Marker(
      markerId: MarkerId("end"),
      position: destination.points.last,
    );

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['route'] = myRouter;

    final currentMarkes = Map<String, Marker>.from(state.markes);
    currentMarkes['start'] = startMarker;
    currentMarkes['end'] = endMarker;

    add(DisplayPolylinesEvent(
      currentPolylines,
      currentMarkes,
    ));
  }

  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }

  @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }
}
