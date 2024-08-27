import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/location/location_bloc.dart';
import '../blocs/search/search_bloc.dart';
import '../models/search_result.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchResult> {
  SearchDestinationDelegate()
      : super(
          searchFieldLabel: 'Buscar...',
        );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        final result = SearchResult(cancel: true);
        close(context, result);
      },
      icon: const Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final proximity =
        BlocProvider.of<LocationBloc>(context).state.lastKnowLocation;

    searchBloc.getGeoCodeByQuery(proximity!, query);

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Text("Resultados ${state.places.length}");
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(
            Icons.location_on_outlined,
            color: Colors.black,
          ),
          title: const Text(
            "Colocar la ubicación manualmente",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          onTap: () {
            final result = SearchResult(cancel: false, manual: true);
            close(context, result);
          },
        )
      ],
    );
  }
}
