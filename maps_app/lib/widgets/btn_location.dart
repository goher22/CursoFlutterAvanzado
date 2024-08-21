import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/ui/custom_snackbar.dart';

import '../blocs/location/location_bloc.dart';
import '../blocs/map/map_bloc.dart';

class BtnCurrentLocation extends StatelessWidget {
  const BtnCurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          onPressed: () {
            final userLocation = locationBloc.state.lastKnowLocation;

            if (userLocation == null) {
              final snackBar = CustomSnackbar(message: "No hay ubicación");
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              return;
            }
            mapBloc.moveCamera(userLocation);
          },
          icon: const Icon(
            Icons.my_location_outlined,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
