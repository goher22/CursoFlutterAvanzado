import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';

import '../../models/route_destination.dart';
import '../../services/traffic_service.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  TrafficService trafficService;
  SearchBloc({
    required this.trafficService,
  }) : super(const SearchState()) {
    on<SearchEvent>((event, emit) {
      on<OnActivateManualMarkerEvent>(
          (event, emit) => emit(state.copyWith(displayManualMarker: true)));
      on<OnDeactivateManualMarkerEvent>(
          (event, emit) => emit(state.copyWith(displayManualMarker: false)));
    });
  }

  Future getCootsStartToEnd(LatLng start, LatLng end) async {
    final resp = await trafficService.getCoorsStartToEnd(start, end);

    final geometry = resp.routes[0].geometry;
    final distance = resp.routes[0].distance;
    final duration = resp.routes[0].duration;

    final points = decodePolyline(
      geometry,
      accuracyExponent: 6,
    );

    final latLngList = points
        .map((coor) => LatLng(
              coor[0].toDouble(),
              coor[1].toDouble(),
            ))
        .toList();

    return RouteDestination(
      points: latLngList,
      duration: duration,
      distance: distance,
    );
  }
}
