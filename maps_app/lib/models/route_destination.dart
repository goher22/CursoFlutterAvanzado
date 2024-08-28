import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'geocode_response.dart';

class RouteDestination {
  final List<LatLng> points;
  final double duration;
  final double distance;
  final Feature endDestination;

  RouteDestination({
    required this.points,
    required this.duration,
    required this.distance,
    required this.endDestination,
  });
}
