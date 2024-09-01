import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/helpers/widget_to_marker.dart';
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

    double kms = destination.distance / 1000;
    kms = (kms * 100).floorToDouble();
    kms /= 100;

    int tripDuration = (destination.duration / 60).floorToDouble().toInt();

    // final startMaker = await getAssetImageMarker();
    // final endMaker = await getNetworkImageMarker();

    final startMaker = await getStartCustomMarker(tripDuration, "Mi ubicación");
    final endMaker = await getEndCustomMarker(
        kms.toInt(), destination.endDestination.properties.fullAddress);

    final startMarker = Marker(
      anchor: const Offset(0.1, 1),
      markerId: const MarkerId("start"),
      position: destination.points.first,
      icon: startMaker,
      // infoWindow: InfoWindow(
      //   title: 'Inicio',
      //   snippet: 'Kms: $kms, duration: $tripDuration',
      // ),
    );

    final endMarker = Marker(
      markerId: const MarkerId("end"),
      position: destination.points.last,
      icon: endMaker,
      // anchor: const Offset(0, 0),
      // infoWindow: InfoWindow(
      //   title: destination.endDestination.properties.namePreferred,
      //   snippet: destination.endDestination.properties.fullAddress,
      // ),
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

    await Future.delayed(const Duration(milliseconds: 300));

    // _mapController?.showMarkerInfoWindow(const MarkerId("start"));
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
