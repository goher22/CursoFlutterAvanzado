import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

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

  Future<void> askGpsAccess() async {
    final status = await Permission.location.request();
    switch (status) {
      case PermissionStatus.granted:
        add(GpsAndPermissionEvent(
          isGpsEnable: state.isGpsEnabled,
          isGpsPermissionGranted: true,
        ));
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.provisional:
        add(GpsAndPermissionEvent(
          isGpsEnable: state.isGpsEnabled,
          isGpsPermissionGranted: false,
        ));
        openAppSettings();
        break;
    }
  }

  @override
  Future<void> close() {
    gpsStreamSubscription?.cancel();
    return super.close();
  }
}
