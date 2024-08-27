import 'dart:convert';

class GeocodeResponse {
  String type;
  List<Feature> features;
  String attribution;

  GeocodeResponse({
    required this.type,
    required this.features,
    required this.attribution,
  });

  factory GeocodeResponse.fromRawJson(String str) =>
      GeocodeResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GeocodeResponse.fromJson(Map<String, dynamic> json) =>
      GeocodeResponse(
        type: json["type"],
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "attribution": attribution,
      };
}

class Feature {
  String type;
  String id;
  Geometry geometry;
  Properties properties;

  Feature({
    required this.type,
    required this.id,
    required this.geometry,
    required this.properties,
  });

  factory Feature.fromRawJson(String str) => Feature.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        type: json["type"],
        id: json["id"],
        geometry: Geometry.fromJson(json["geometry"]),
        properties: Properties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "geometry": geometry.toJson(),
        "properties": properties.toJson(),
      };
}

class Geometry {
  String type;
  List<double> coordinates;

  Geometry({
    required this.type,
    required this.coordinates,
  });

  factory Geometry.fromRawJson(String str) =>
      Geometry.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class Properties {
  String mapBoxId;
  String featureType;
  String fullAddress;
  String name;
  String namePreferred;
  Coordinates coordinates;
  String placeFormatted;
  Context context;

  Properties({
    required this.mapBoxId,
    required this.featureType,
    required this.fullAddress,
    required this.name,
    required this.namePreferred,
    required this.coordinates,
    required this.placeFormatted,
    required this.context,
  });

  factory Properties.fromRawJson(String str) =>
      Properties.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        mapBoxId: json["mapbox_id"],
        featureType: json["feature_type"],
        fullAddress: json["full_address"],
        name: json["name"],
        namePreferred: json["name_preferred"],
        coordinates: Coordinates.fromJson(json["coordinates"]),
        placeFormatted: json["place_formatted"],
        context: Context.fromJson(json["context"]),
      );

  Map<String, dynamic> toJson() => {
        "mapbox_id": mapBoxId,
        "feature_type": featureType,
        "full_address": fullAddress,
        "name": name,
        "name_preferred": namePreferred,
        "coordinates": coordinates.toJson(),
        "place_formatted": placeFormatted,
        "context": context.toJson(),
      };
}

class Context {
  Address address;
  Postcode street;
  Postcode postcode;
  Place place;
  Region region;
  Country country;

  Context({
    required this.address,
    required this.street,
    required this.postcode,
    required this.place,
    required this.region,
    required this.country,
  });

  factory Context.fromRawJson(String str) => Context.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Context.fromJson(Map<String, dynamic> json) => Context(
        address: Address.fromJson(json["address"]),
        street: Postcode.fromJson(json["street"]),
        postcode: Postcode.fromJson(json["postcode"]),
        place: Place.fromJson(json["place"]),
        region: Region.fromJson(json["region"]),
        country: Country.fromJson(json["country"]),
      );

  Map<String, dynamic> toJson() => {
        "address": address.toJson(),
        "street": street.toJson(),
        "postcode": postcode.toJson(),
        "place": place.toJson(),
        "region": region.toJson(),
        "country": country.toJson(),
      };
}

class Address {
  String mapBoxId;
  String addressNumber;
  String streetName;
  String name;

  Address({
    required this.mapBoxId,
    required this.addressNumber,
    required this.streetName,
    required this.name,
  });

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        mapBoxId: json["mapbox_id"],
        addressNumber: json["address_number"],
        streetName: json["street_name"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "mapbox_id": mapBoxId,
        "address_number": addressNumber,
        "street_name": streetName,
        "name": name,
      };
}

class Country {
  String mapBoxId;
  String name;
  String wikidataId;
  String countryCode;
  String countryCodeAlpha3;
  Translations translations;

  Country({
    required this.mapBoxId,
    required this.name,
    required this.wikidataId,
    required this.countryCode,
    required this.countryCodeAlpha3,
    required this.translations,
  });

  factory Country.fromRawJson(String str) => Country.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        mapBoxId: json["mapbox_id"],
        name: json["name"],
        wikidataId: json["wikidata_id"],
        countryCode: json["country_code"],
        countryCodeAlpha3: json["country_code_alpha_3"],
        translations: Translations.fromJson(json["translations"]),
      );

  Map<String, dynamic> toJson() => {
        "mapbox_id": mapBoxId,
        "name": name,
        "wikidata_id": wikidataId,
        "country_code": countryCode,
        "country_code_alpha_3": countryCodeAlpha3,
        "translations": translations.toJson(),
      };
}

class Translations {
  Es es;

  Translations({
    required this.es,
  });

  factory Translations.fromRawJson(String str) =>
      Translations.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Translations.fromJson(Map<String, dynamic> json) => Translations(
        es: Es.fromJson(json["es"]),
      );

  Map<String, dynamic> toJson() => {
        "es": es.toJson(),
      };
}

class Es {
  String language;
  String name;

  Es({
    required this.language,
    required this.name,
  });

  factory Es.fromRawJson(String str) => Es.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Es.fromJson(Map<String, dynamic> json) => Es(
        language: json["language"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "language": language,
        "name": name,
      };
}

class Place {
  String mapBoxId;
  String name;
  String wikidataId;
  String shortCode;
  Translations translations;

  Place({
    required this.mapBoxId,
    required this.name,
    required this.wikidataId,
    required this.shortCode,
    required this.translations,
  });

  factory Place.fromRawJson(String str) => Place.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        mapBoxId: json["mapbox_id"],
        name: json["name"],
        wikidataId: json["wikidata_id"],
        shortCode: json["short_code"],
        translations: Translations.fromJson(json["translations"]),
      );

  Map<String, dynamic> toJson() => {
        "mapbox_id": mapBoxId,
        "name": name,
        "wikidata_id": wikidataId,
        "short_code": shortCode,
        "translations": translations.toJson(),
      };
}

class Postcode {
  String mapBoxId;
  String name;

  Postcode({
    required this.mapBoxId,
    required this.name,
  });

  factory Postcode.fromRawJson(String str) =>
      Postcode.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Postcode.fromJson(Map<String, dynamic> json) => Postcode(
        mapBoxId: json["mapbox_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "mapbox_id": mapBoxId,
        "name": name,
      };
}

class Region {
  String mapBoxId;
  String name;
  String wikidataId;
  String regionCode;
  String regionCodeFull;
  Translations translations;

  Region({
    required this.mapBoxId,
    required this.name,
    required this.wikidataId,
    required this.regionCode,
    required this.regionCodeFull,
    required this.translations,
  });

  factory Region.fromRawJson(String str) => Region.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        mapBoxId: json["mapbox_id"],
        name: json["name"],
        wikidataId: json["wikidata_id"],
        regionCode: json["region_code"],
        regionCodeFull: json["region_code_full"],
        translations: Translations.fromJson(json["translations"]),
      );

  Map<String, dynamic> toJson() => {
        "mapbox_id": mapBoxId,
        "name": name,
        "wikidata_id": wikidataId,
        "region_code": regionCode,
        "region_code_full": regionCodeFull,
        "translations": translations.toJson(),
      };
}

class Coordinates {
  double longitude;
  double latitude;
  String accuracy;
  List<RoutablePoint> routablePoints;

  Coordinates({
    required this.longitude,
    required this.latitude,
    required this.accuracy,
    required this.routablePoints,
  });

  factory Coordinates.fromRawJson(String str) =>
      Coordinates.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        longitude: json["longitude"].toDouble(),
        latitude: json["latitude"].toDouble(),
        accuracy: json["accuracy"],
        routablePoints: List<RoutablePoint>.from(
            json["routable_points"].map((x) => RoutablePoint.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "longitude": longitude,
        "latitude": latitude,
        "accuracy": accuracy,
        "routable_points":
            List<dynamic>.from(routablePoints.map((x) => x.toJson())),
      };
}

class RoutablePoint {
  String name;
  double latitude;
  double longitude;

  RoutablePoint({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory RoutablePoint.fromRawJson(String str) =>
      RoutablePoint.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RoutablePoint.fromJson(Map<String, dynamic> json) => RoutablePoint(
        name: json["name"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
      };
}
