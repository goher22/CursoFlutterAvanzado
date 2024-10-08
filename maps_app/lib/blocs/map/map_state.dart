part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool isFollowUser;
  final bool showMyRoute;

  final Map<String, Polyline> polylines;
  final Map<String, Marker> markes;

  const MapState({
    this.isMapInitialized = false,
    this.isFollowUser = true,
    this.showMyRoute = true,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markes,
  })  : polylines = polylines ?? const {},
        markes = markes ?? const {};

  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowUser,
    bool? showMyRoute,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markes,
  }) =>
      MapState(
        isMapInitialized: isMapInitialized ?? this.isMapInitialized,
        isFollowUser: isFollowUser ?? this.isFollowUser,
        showMyRoute: showMyRoute ?? this.showMyRoute,
        polylines: polylines ?? this.polylines,
        markes: markes ?? this.markes,
      );

  @override
  List<Object> get props => [
        isMapInitialized,
        isFollowUser,
        showMyRoute,
        polylines,
        markes,
      ];
}
