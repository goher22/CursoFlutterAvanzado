import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/location/location_bloc.dart';
import '../blocs/map/map_bloc.dart';
import '../blocs/search/search_bloc.dart';
import '../delegates/search_destination_delegate.dart';
import '../models/search_result.dart';

class SearchBarCustom extends StatelessWidget {
  const SearchBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      return state.displayManualMarker
          ? const SizedBox()
          : FadeInDown(
              duration: const Duration(milliseconds: 300),
              child: const _SearchBarCustomBody(),
            );
    });
  }
}

class _SearchBarCustomBody extends StatelessWidget {
  const _SearchBarCustomBody({super.key});

  void onSearchResult(BuildContext context, SearchResult searchResult) async {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);

    if (searchResult.manual) {
      searchBloc.add(OnActivateManualMarkerEvent());
      return;
    }

    if (searchResult.position != null &&
        locationBloc.state.lastKnowLocation != null) {
      final destination = await searchBloc.getCootsStartToEnd(
        locationBloc.state.lastKnowLocation!,
        searchResult.position!,
      );
      await mapBloc.drawRouterPolyline(destination);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        height: 50,
        child: GestureDetector(
          onTap: () async {
            final result = await showSearch(
              context: context,
              delegate: SearchDestinationDelegate(),
            );
            if (result == null) return;

            onSearchResult(context, result);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ]),
            child: const Text(
              "¿Donde quiere ir?",
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
