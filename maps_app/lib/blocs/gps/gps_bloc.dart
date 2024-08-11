import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  StreamSubscription? gpsStreamSubscription;
  GpsBloc()
      : super(const GpsState(
          isGpsEnabled: false,
          isGpsPermissionGranted: false,
        )) {
    on<GpsAndPermissionEvent>(
      (event, emit) => emit(
        state.copyWith(
          isGpsEnabled: event.isGpsEnable,
          isGpsPermissionGranted: event.isGpsPermissionGranted,
        ),
      ),
    );

    _init();
  }

  Future<void> _init() async {
    final isEnable = await _checkGpsStatus();

    add(GpsAndPermissionEvent(
      isGpsEnable: isEnable,
      isGpsPermissionGranted: state.isGpsPermissionGranted,
    ));
  }

  Future<bool> _checkGpsStatus() async {
    final isEnable = await Geolocator.isLocationServiceEnabled();
    gpsStreamSubscription = Geolocator.getServiceStatusStream().listen((event) {
      final isEnable = (event.index == 1);
      add(GpsAndPermissionEvent(
        isGpsEnable: isEnable,
        isGpsPermissionGranted: state.isGpsPermissionGranted,
      ));
    });
    return isEnable;
  }

  @override
  Future<void> close() {
    gpsStreamSubscription?.cancel();
    return super.close();
  }
}
