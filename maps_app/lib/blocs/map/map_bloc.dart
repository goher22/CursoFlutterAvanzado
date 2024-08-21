import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  GoogleMapController? mapController;

  MapBloc() : super(const MapState()) {
    on<onMapInitialzedEvent>(_onInitMap);
  }

  void _onInitMap(onMapInitialzedEvent event, Emitter<MapState> emit) {
    mapController = event.controller;
    emit(state.copyWith(isMapInitialized: true));
  }
}
