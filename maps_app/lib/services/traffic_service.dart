import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/geocode_response.dart';
import '../models/traffic_response.dart';
import 'geocode_interceptor.dart';
import 'traffic_interceptor.dart';

class TrafficService {
  final Dio _dioTraffic;
  final Dio _dioGeocode;
  final String _baseTrafficUrl = 'https://api.mapbox.com/directions/v5/mapbox';
  final String _baseGeocodeUrl =
      'https://api.mapbox.com/search/geocode/v6/forward';

  TrafficService()
      : _dioTraffic = Dio()..interceptors.add(TrafficInterceptor()),
        _dioGeocode = Dio()..interceptors.add(GeocodeInterceptor());

  Future<TrafficResponse> getCoorsStartToEnd(LatLng start, LatLng end) async {
    final coorsString =
        '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
    final url = '$_baseTrafficUrl/driving/$coorsString';

    final resp = await _dioTraffic.get(url);

    final data = TrafficResponse.fromJson(resp.data);

    return data;
  }

  Future<List<Feature>> getResultsByQuery(
      LatLng proximity, String query) async {
    if (query.isEmpty) return [];
    final url = '$_baseGeocodeUrl?q=$query';

    final resp = await _dioGeocode.get(url, queryParameters: {
      "q": query,
      "proximity": "${proximity.longitude},${proximity.latitude} ",
    });

    final geocodeResponse = GeocodeResponse.fromJson(resp.data);

    return geocodeResponse.features;
  }
}
