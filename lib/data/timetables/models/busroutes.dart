import 'dart:convert';

import 'package:warsaw_public_transport/data/lines/models/busline.dart';
import 'package:warsaw_public_transport/data/timetables/models/busroute.dart';

class Busroutes {
  List<BusRoute> routes;
  BusLine? line;

  Busroutes({
    required this.routes,
  });

  Map<String, dynamic> toMap() {
    return {
      'routes': routes.map((route) => route.toMap()).toList(),
    };
  }

  factory Busroutes.fromMap(Map<String, dynamic> map) {
    return Busroutes(
      routes: (map['result'] as List<dynamic>?)
              ?.map((x) => BusRoute.fromList(x))
              .whereType<BusRoute>()
              .toList() ??
          [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Busroutes.fromJson(String source) {
    final list = json.decode(source) as List<dynamic>;
    return Busroutes(
      routes: list.map((x) => BusRoute.fromList(x)).toList(),
    );
  }

  @override
  String toString() {
    return 'Busroutes(routes: $routes)';
  }

  void setBusLine(BusLine line) {
    this.line = line;
  }
}
