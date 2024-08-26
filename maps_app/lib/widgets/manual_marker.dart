import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/location/location_bloc.dart';
import '../blocs/map/map_bloc.dart';
import '../blocs/search/search_bloc.dart';
import '../helpers/show_loading_message.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      return state.displayManualMarker
          ? const _ManualMarkerBody()
          : const SizedBox();
    });
  }
}

class _ManualMarkerBody extends StatelessWidget {
  const _ManualMarkerBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          const Positioned(
            top: 70,
            left: 20,
            child: _BtnBack(),
          ),
          Center(
            child: Transform.translate(
              offset: const Offset(0, -20),
              child: BounceInDown(
                from: 100,
                child: const Icon(
                  Icons.location_on_rounded,
                  size: 60,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 70,
            left: 40,
            child: FadeInUp(
              duration: const Duration(microseconds: 300),
              child: MaterialButton(
                minWidth: size.width - 120,
                onPressed: () async {
                  final start = locationBloc.state.lastKnowLocation;
                  if (start == null) return;

                  final end = mapBloc.mapCenter;
                  if (end == null) return;

                  showLoadingMessage(context);

                  final resp = await searchBloc.getCootsStartToEnd(start, end);
                  await mapBloc.drawRouterPolyline(resp);

                  searchBloc.add(OnDeactivateManualMarkerEvent());
                  Navigator.pop(context);
                },
                color: Colors.black,
                elevation: 0,
                height: 50,
                shape: const StadiumBorder(),
                child: const Text(
                  "Confirmar destinó",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BtnBack extends StatelessWidget {
  const _BtnBack();

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(microseconds: 300),
      child: CircleAvatar(
        maxRadius: 30,
        backgroundColor: Colors.white,
        child: IconButton(
            onPressed: () {
              BlocProvider.of<SearchBloc>(context)
                  .add(OnDeactivateManualMarkerEvent());
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
      ),
    );
  }
}
