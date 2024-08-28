import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> getAssetImageMarker() async {
  return BitmapDescriptor.asset(
    const ImageConfiguration(
      devicePixelRatio: 2.5,
    ),
    'assets/custom-pin.png',
  );
}
