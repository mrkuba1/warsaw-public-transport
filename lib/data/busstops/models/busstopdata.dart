import 'dart:convert';

class BusstopInfo {
  final String id;
  final String smallid;
  final String name;
  final String streetid;
  final double latitude;
  final double altitude;
  final String destination;

  BusstopInfo({
    required this.id,
    required this.smallid,
    required this.name,
    required this.streetid,
    required this.latitude,
    required this.altitude,
    required this.destination,
  });

  BusstopInfo copyWith(
      {String? id,
      String? smallid,
      String? name,
      String? streetid,
      double? latitude,
      double? altitude,
      String? destination}) {
    return BusstopInfo(
      id: id ?? this.id,
      smallid: smallid ?? this.smallid,
      name: name ?? this.name,
      streetid: streetid ?? this.streetid,
      latitude: latitude ?? this.latitude,
      altitude: altitude ?? this.altitude,
      destination: destination ?? this.destination,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'smallid': smallid,
      'name': name,
      'streetid': streetid,
      'latitude': latitude,
      'alitude': altitude,
      'destination': destination
    };
  }

  factory BusstopInfo.fromMap(Map<String, dynamic> map) {
    return BusstopInfo(
      id: map['values'][0]['value']?.toString() ?? '',
      smallid: map['values'][1]['value']?.toString() ?? '',
      name: map['values'][2]['value']?.toString() ?? '',
      streetid: map['values'][3]['value']?.toString() ?? '',
      latitude:
          double.tryParse(map['values'][4]['value']?.toString() ?? '') ?? 0,
      altitude:
          double.tryParse(map['values'][5]['value']?.toString() ?? '') ?? 0,
      destination: map['values'][6]['value']?.toString() ?? '',
    );
  }
  String toJson() => json.encode(toMap());

  factory BusstopInfo.fromJson(String source) =>
      BusstopInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusstopInfo(id: $id, smallid: $smallid, name: $name, streetid:$streetid, latitude: $latitude, alitude: $altitude, destitation: $destination)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is BusstopInfo &&
        other.id == id &&
        other.smallid == smallid &&
        other.name == name &&
        other.streetid == streetid &&
        other.altitude == altitude &&
        other.latitude == latitude &&
        other.destination == destination;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        smallid.hashCode ^
        name.hashCode ^
        streetid.hashCode ^
        altitude.hashCode ^
        latitude.hashCode ^
        destination.hashCode;
  }
}
