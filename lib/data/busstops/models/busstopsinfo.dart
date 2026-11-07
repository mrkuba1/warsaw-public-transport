import 'dart:convert';

import 'package:warsaw_public_transport/data/busstops/models/busstopdata.dart';

class BusstopsInfo {
  List<BusstopInfo> stops;

  BusstopsInfo({
    required this.stops,
  });

  BusstopsInfo copyWith({
    List<BusstopInfo>? stops,
  }) {
    return BusstopsInfo(
      stops: stops ?? this.stops,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'stops': stops.map((stop) => stop.toMap()).toList(),
    };
  }

  factory BusstopsInfo.fromMap(Map<String, dynamic> map) {
    return BusstopsInfo(
      stops: (map['result'] as List<dynamic>?)
              ?.map((x) => BusstopInfo.fromMap(x))
              .toList() ??
          [],
    );
  }

  factory BusstopsInfo.fromJson(String source) =>
      BusstopsInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusstopsInfo(stops:$stops)';
  }

  BusstopInfo getBusstopInfoByIdAndIdSmall(String id, String idSmall) {
    return stops.firstWhere(
      (busstopInfo) => busstopInfo.id == id && busstopInfo.smallid == idSmall,
      orElse: () =>
          throw Exception('BusstopInfo not found for the given id and idSmall'),
    );
  }

  List<BusstopInfo> getBusstopsInfoByName(String name) {
    return stops
        .where(
          (busstopInfo) =>
              busstopInfo.name.toLowerCase().contains(name.toLowerCase()),
        )
        .toList();
  }
}
