import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../blocs/map/map_bloc.dart';

class MapView extends StatelessWidget {
  final LatLng initialLocation;
  final Set<Polyline> polylines;
  final Set<Marker> markers;

  const MapView({
    super.key,
    required this.initialLocation,
    required this.polylines,
    required this.markers,
  });

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final CameraPosition initialCameraPosition = CameraPosition(
      target: initialLocation,
      zoom: 15,
    );

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Listener(
        onPointerMove: (pointerMoveEvent) =>
            mapBloc.add(OnStopFollowUserEvent()),
        child: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          compassEnabled: false,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          myLocationEnabled: true,
          polylines: polylines,
          markers: markers,
          onMapCreated: (controller) => mapBloc.add(
            onMapInitialzedEvent(controller),
          ),
          onCameraMove: (position) => mapBloc.mapCenter = position.target,
        ),
      ),
    );
  }
}
