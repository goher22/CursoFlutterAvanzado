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
  String mapboxId;
  String featureType;
  String fullAddress;
  String name;
  String namePreferred;
  Coordinates coordinates;
  String placeFormatted;
  List<double> bbox;
  Context context;

  Properties({
    required this.mapboxId,
    required this.featureType,
    required this.fullAddress,
    required this.name,
    required this.namePreferred,
    required this.coordinates,
    required this.placeFormatted,
    required this.bbox,
    required this.context,
  });

  factory Properties.fromRawJson(String str) =>
      Properties.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        mapboxId: json["mapbox_id"],
        featureType: json["feature_type"],
        fullAddress: json["full_address"],
        name: json["name"],
        namePreferred: json["name_preferred"],
        coordinates: Coordinates.fromJson(json["coordinates"]),
        placeFormatted: json["place_formatted"],
        bbox: List<double>.from(json["bbox"].map((x) => x.toDouble())),
        context: Context.fromJson(json["context"]),
      );

  Map<String, dynamic> toJson() => {
        "mapbox_id": mapboxId,
        "feature_type": featureType,
        "full_address": fullAddress,
        "name": name,
        "name_preferred": namePreferred,
        "coordinates": coordinates.toJson(),
        "place_formatted": placeFormatted,
        "bbox": List<dynamic>.from(bbox.map((x) => x)),
        "context": context.toJson(),
      };

  @override
  String toString() {
    return 'Feacture: $name';
  }
}

class Context {
  Region region;
  Country country;
  Place place;
  Place district;
  Place locality;

  Context({
    required this.region,
    required this.country,
    required this.place,
    required this.district,
    required this.locality,
  });

  factory Context.fromRawJson(String str) => Context.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Context.fromJson(Map<String, dynamic> json) => Context(
        region: Region.fromJson(json["region"]),
        country: Country.fromJson(json["country"]),
        place: Place.fromJson(json["place"]),
        district: Place.fromJson(json["district"]),
        locality: Place.fromJson(json["locality"]),
      );

  Map<String, dynamic> toJson() => {
        "region": region.toJson(),
        "country": country.toJson(),
        "place": place.toJson(),
        "district": district.toJson(),
        "locality": locality.toJson(),
      };
}

class Country {
  String mapboxId;
  String name;
  String wikidataId;
  String countryCode;
  String countryCodeAlpha3;
  Translations translations;

  Country({
    required this.mapboxId,
    required this.name,
    required this.wikidataId,
    required this.countryCode,
    required this.countryCodeAlpha3,
    required this.translations,
  });

  factory Country.fromRawJson(String str) => Country.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        mapboxId: json["mapbox_id"],
        name: json["name"],
        wikidataId: json["wikidata_id"],
        countryCode: json["country_code"],
        countryCodeAlpha3: json["country_code_alpha_3"],
        translations: Translations.fromJson(json["translations"]),
      );

  Map<String, dynamic> toJson() => {
        "mapbox_id": mapboxId,
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
  String name;

  Es({
    required this.name,
  });

  factory Es.fromRawJson(String str) => Es.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Es.fromJson(Map<String, dynamic> json) => Es(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

enum Language { EN, ES }

final languageValues = EnumValues({"en": Language.EN, "es": Language.ES});

class Place {
  String mapboxId;
  String name;
  String wikidataId;
  Translations translations;

  Place({
    required this.mapboxId,
    required this.name,
    required this.wikidataId,
    required this.translations,
  });

  factory Place.fromRawJson(String str) => Place.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        mapboxId: json["mapbox_id"],
        name: json["name"],
        wikidataId: json["wikidata_id"],
        translations: Translations.fromJson(json["translations"]),
      );

  Map<String, dynamic> toJson() => {
        "mapbox_id": mapboxId,
        "name": name,
        "wikidata_id": wikidataId,
        "translations": translations.toJson(),
      };
}

class Region {
  String mapboxId;
  String name;
  String wikidataId;
  String regionCode;
  String regionCodeFull;
  Translations translations;

  Region({
    required this.mapboxId,
    required this.name,
    required this.wikidataId,
    required this.regionCode,
    required this.regionCodeFull,
    required this.translations,
  });

  factory Region.fromRawJson(String str) => Region.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        mapboxId: json["mapbox_id"],
        name: json["name"],
        wikidataId: json["wikidata_id"],
        regionCode: json["region_code"],
        regionCodeFull: json["region_code_full"],
        translations: Translations.fromJson(json["translations"]),
      );

  Map<String, dynamic> toJson() => {
        "mapbox_id": mapboxId,
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

  Coordinates({
    required this.longitude,
    required this.latitude,
  });

  factory Coordinates.fromRawJson(String str) =>
      Coordinates.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        longitude: json["longitude"].toDouble(),
        latitude: json["latitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "longitude": longitude,
        "latitude": latitude,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
