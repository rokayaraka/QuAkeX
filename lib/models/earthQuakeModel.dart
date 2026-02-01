import 'dart:convert';

import 'package:flutter/foundation.dart';

class EarthQuakeModel {
  final String type;
  final Metadata metadata;
  final List<Feature> features;
  final List<double> bbox;
  EarthQuakeModel({
    required this.type,
    required this.metadata,
    required this.features,
    required this.bbox,
  });

  EarthQuakeModel copyWith({
    String? type,
    Metadata? metadata,
    List<Feature>? features,
    List<double>? bbox,
  }) {
    return EarthQuakeModel(
      type: type ?? this.type,
      metadata: metadata ?? this.metadata,
      features: features ?? this.features,
      bbox: bbox ?? this.bbox,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'metadata': metadata.toMap(),
      'features': features.map((x) => x.toMap()).toList(),
      'bbox': bbox,
    };
  }

  factory EarthQuakeModel.fromMap(Map<String, dynamic> map) {
    return EarthQuakeModel(
      type: map['type'] ?? '',
      metadata: Metadata.fromMap(map['metadata']),
      features: List<Feature>.from(map['features']?.map((x) => Feature.fromMap(x))),
      bbox: List<double>.from(map['bbox']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EarthQuakeModel.fromJson(String source) => EarthQuakeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EarthQuakeModel(type: $type, metadata: $metadata, features: $features, bbox: $bbox)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is EarthQuakeModel &&
      other.type == type &&
      other.metadata == metadata &&
      listEquals(other.features, features) &&
      listEquals(other.bbox, bbox);
  }

  @override
  int get hashCode {
    return type.hashCode ^
      metadata.hashCode ^
      features.hashCode ^
      bbox.hashCode;
  }
}

class Metadata {
  final int generated;
  final String url;
  final String title;
  final int status;
  final String api;
  final int count;
  Metadata({
    required this.generated,
    required this.url,
    required this.title,
    required this.status,
    required this.api,
    required this.count,
  });

  Metadata copyWith({
    int? generated,
    String? url,
    String? title,
    int? status,
    String? api,
    int? count,
  }) {
    return Metadata(
      generated: generated ?? this.generated,
      url: url ?? this.url,
      title: title ?? this.title,
      status: status ?? this.status,
      api: api ?? this.api,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'generated': generated,
      'url': url,
      'title': title,
      'status': status,
      'api': api,
      'count': count,
    };
  }

  factory Metadata.fromMap(Map<String, dynamic> map) {
    return Metadata(
      generated: map['generated']?.toInt() ?? 0,
      url: map['url'] ?? '',
      title: map['title'] ?? '',
      status: map['status']?.toInt() ?? 0,
      api: map['api'] ?? '',
      count: map['count']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Metadata.fromJson(String source) => Metadata.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Metadata(generated: $generated, url: $url, title: $title, status: $status, api: $api, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Metadata &&
      other.generated == generated &&
      other.url == url &&
      other.title == title &&
      other.status == status &&
      other.api == api &&
      other.count == count;
  }

  @override
  int get hashCode {
    return generated.hashCode ^
      url.hashCode ^
      title.hashCode ^
      status.hashCode ^
      api.hashCode ^
      count.hashCode;
  }
}

class Feature {
  final String type;
  final Properties properties;
  final Geometry geometry;
  final String id;
  Feature({
    required this.type,
    required this.properties,
    required this.geometry,
    required this.id,
  });

  Feature copyWith({
    String? type,
    Properties? properties,
    Geometry? geometry,
    String? id,
  }) {
    return Feature(
      type: type ?? this.type,
      properties: properties ?? this.properties,
      geometry: geometry ?? this.geometry,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'properties': properties.toMap(),
      'geometry': geometry.toMap(),
      'id': id,
    };
  }

  factory Feature.fromMap(Map<String, dynamic> map) {
    return Feature(
      type: map['type'] ?? '',
      properties: Properties.fromMap(map['properties']),
      geometry: Geometry.fromMap(map['geometry']),
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Feature.fromJson(String source) => Feature.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Feature(type: $type, properties: $properties, geometry: $geometry, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Feature &&
      other.type == type &&
      other.properties == properties &&
      other.geometry == geometry &&
      other.id == id;
  }

  @override
  int get hashCode {
    return type.hashCode ^
      properties.hashCode ^
      geometry.hashCode ^
      id.hashCode;
  }
}

class Properties {
  final double mag;
  final String place;
  final int time;
  final int updated;
  final Tz tz;
  final String url;
  final String detail;
  final Felt felt;
  final Cdi cdi;
  final double mmi;
  final String alert;
  final String status;
  final int tsunami;
  final int sig;
  final String net;
  final String code;
  final String ids;
  final String sources;
  final String types;
  final Nst nst;
  final double dmin;
  final double rms;
  final int gap;
  final String magType;
  final String type;
  final String title;
  Properties({
    required this.mag,
    required this.place,
    required this.time,
    required this.updated,
    required this.tz,
    required this.url,
    required this.detail,
    required this.felt,
    required this.cdi,
    required this.mmi,
    required this.alert,
    required this.status,
    required this.tsunami,
    required this.sig,
    required this.net,
    required this.code,
    required this.ids,
    required this.sources,
    required this.types,
    required this.nst,
    required this.dmin,
    required this.rms,
    required this.gap,
    required this.magType,
    required this.type,
    required this.title,
  });

  Properties copyWith({
    double? mag,
    String? place,
    int? time,
    int? updated,
    Tz? tz,
    String? url,
    String? detail,
    Felt? felt,
    Cdi? cdi,
    double? mmi,
    String? alert,
    String? status,
    int? tsunami,
    int? sig,
    String? net,
    String? code,
    String? ids,
    String? sources,
    String? types,
    Nst? nst,
    double? dmin,
    double? rms,
    int? gap,
    String? magType,
    String? type,
    String? title,
  }) {
    return Properties(
      mag: mag ?? this.mag,
      place: place ?? this.place,
      time: time ?? this.time,
      updated: updated ?? this.updated,
      tz: tz ?? this.tz,
      url: url ?? this.url,
      detail: detail ?? this.detail,
      felt: felt ?? this.felt,
      cdi: cdi ?? this.cdi,
      mmi: mmi ?? this.mmi,
      alert: alert ?? this.alert,
      status: status ?? this.status,
      tsunami: tsunami ?? this.tsunami,
      sig: sig ?? this.sig,
      net: net ?? this.net,
      code: code ?? this.code,
      ids: ids ?? this.ids,
      sources: sources ?? this.sources,
      types: types ?? this.types,
      nst: nst ?? this.nst,
      dmin: dmin ?? this.dmin,
      rms: rms ?? this.rms,
      gap: gap ?? this.gap,
      magType: magType ?? this.magType,
      type: type ?? this.type,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mag': mag,
      'place': place,
      'time': time,
      'updated': updated,
      'tz': tz,
      'url': url,
      'detail': detail,
      'felt': felt,
      'cdi': cdi,
      'mmi': mmi,
      'alert': alert,
      'status': status,
      'tsunami': tsunami,
      'sig': sig,
      'net': net,
      'code': code,
      'ids': ids,
      'sources': sources,
      'types': types,
      'nst': nst,
      'dmin': dmin,
      'rms': rms,
      'gap': gap,
      'magType': magType,
      'type': type,
      'title': title,
    };
  }

  factory Properties.fromMap(Map<String, dynamic> map) {
    return Properties(
      mag: map['mag']?.toDouble() ?? 0.0,
      place: map['place'] ?? '',
      time: map['time']?.toInt() ?? 0,
      updated: map['updated']?.toInt() ?? 0,
      tz: Tz.fromMap(map['tz']),
      url: map['url'] ?? '',
      detail: map['detail'] ?? '',
      felt: Felt.fromMap(map['felt']),
      cdi: Cdi.fromMap(map['cdi']),
      mmi: map['mmi']?.toDouble() ?? 0.0,
      alert: map['alert'] ?? '',
      status: map['status'] ?? '',
      tsunami: map['tsunami']?.toInt() ?? 0,
      sig: map['sig']?.toInt() ?? 0,
      net: map['net'] ?? '',
      code: map['code'] ?? '',
      ids: map['ids'] ?? '',
      sources: map['sources'] ?? '',
      types: map['types'] ?? '',
      nst: Nst.fromMap(map['nst']),
      dmin: map['dmin']?.toDouble() ?? 0.0,
      rms: map['rms']?.toDouble() ?? 0.0,
      gap: map['gap']?.toInt() ?? 0,
      magType: map['magType'] ?? '',
      type: map['type'] ?? '',
      title: map['title'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Properties.fromJson(String source) => Properties.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Properties(mag: $mag, place: $place, time: $time, updated: $updated, tz: $tz, url: $url, detail: $detail, felt: $felt, cdi: $cdi, mmi: $mmi, alert: $alert, status: $status, tsunami: $tsunami, sig: $sig, net: $net, code: $code, ids: $ids, sources: $sources, types: $types, nst: $nst, dmin: $dmin, rms: $rms, gap: $gap, magType: $magType, type: $type, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Properties &&
      other.mag == mag &&
      other.place == place &&
      other.time == time &&
      other.updated == updated &&
      other.tz == tz &&
      other.url == url &&
      other.detail == detail &&
      other.felt == felt &&
      other.cdi == cdi &&
      other.mmi == mmi &&
      other.alert == alert &&
      other.status == status &&
      other.tsunami == tsunami &&
      other.sig == sig &&
      other.net == net &&
      other.code == code &&
      other.ids == ids &&
      other.sources == sources &&
      other.types == types &&
      other.nst == nst &&
      other.dmin == dmin &&
      other.rms == rms &&
      other.gap == gap &&
      other.magType == magType &&
      other.type == type &&
      other.title == title;
  }

  @override
  int get hashCode {
    return mag.hashCode ^
      place.hashCode ^
      time.hashCode ^
      updated.hashCode ^
      tz.hashCode ^
      url.hashCode ^
      detail.hashCode ^
      felt.hashCode ^
      cdi.hashCode ^
      mmi.hashCode ^
      alert.hashCode ^
      status.hashCode ^
      tsunami.hashCode ^
      sig.hashCode ^
      net.hashCode ^
      code.hashCode ^
      ids.hashCode ^
      sources.hashCode ^
      types.hashCode ^
      nst.hashCode ^
      dmin.hashCode ^
      rms.hashCode ^
      gap.hashCode ^
      magType.hashCode ^
      type.hashCode ^
      title.hashCode;
  }
}

// ...existing code...
class Tz {
  final int? value;
  Tz({this.value});

  factory Tz.fromMap(dynamic map) => Tz(value: map as int?);

  dynamic toMap() => value;
}
// ...existing code...

// ...existing code...
class Felt {
  final int? value;
  Felt({this.value});

  factory Felt.fromMap(dynamic map) => Felt(value: map as int?);

  dynamic toMap() => value;
}
// ...existing code...

// ...existing code...
class Cdi {
  final double? value;
  Cdi({this.value});

  factory Cdi.fromMap(dynamic map) => Cdi(
        value: map == null
            ? null
            : (map is num ? map.toDouble() : double.tryParse(map.toString())),
      );

  dynamic toMap() => value;
}
// ...existing code...

// ...existing code...
class Nst {
  final int? value;
  Nst({this.value});

  factory Nst.fromMap(dynamic map) => Nst(value: map as int?);

  dynamic toMap() => value;
}
// ...existing code...

class Geometry {
  final String type;
  final List<double> coordinates;
  Geometry({
    required this.type,
    required this.coordinates,
  });

  Geometry copyWith({
    String? type,
    List<double>? coordinates,
  }) {
    return Geometry(
      type: type ?? this.type,
      coordinates: coordinates ?? this.coordinates,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }

  factory Geometry.fromMap(Map<String, dynamic> map) {
    return Geometry(
      type: map['type'] ?? '',
      coordinates: List<double>.from(map['coordinates']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Geometry.fromJson(String source) => Geometry.fromMap(json.decode(source));

  @override
  String toString() => 'Geometry(type: $type, coordinates: $coordinates)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Geometry &&
      other.type == type &&
      listEquals(other.coordinates, coordinates);
  }

  @override
  int get hashCode => type.hashCode ^ coordinates.hashCode;
}