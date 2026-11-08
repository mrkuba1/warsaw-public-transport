import 'dart:convert';

import 'package:warsaw_public_transport/data/lines/models/busline.dart';

class BusRoute {
  final String team;
  final String destination;
  final String route;
  final DateTime time;
  BusLine? line;

  BusRoute(
      {required this.team,
      required this.destination,
      required this.route,
      required this.time});

  BusRoute copyWith({
    String? team,
    String? destination,
    String? route,
    DateTime? time,
  }) {
    return BusRoute(
        team: team ?? this.team,
        destination: destination ?? this.destination,
        route: route ?? this.route,
        time: time ?? this.time);
  }

  Map<String, dynamic> toMap() {
    return {
      'team': team,
      'destination': destination,
      'route': route,
      'time': time
    };
  }

  factory BusRoute.fromList(List<dynamic> pairs) {
    final m = <String, String>{};
    for (final p in pairs) {
      m[p['key']] = p['value']?.toString() ?? '';
    }
    return BusRoute(
      team: m['brygada'] ?? '',
      destination: m['kierunek'] ?? '',
      route: m['trasa'] ?? '',
      time: parseTime(m['czas'] ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory BusRoute.fromJson(String source) =>
      BusRoute.fromList(json.decode(source));

  @override
  String toString() {
    return 'BusRoute(team: $team, destination: $destination, route: $route, time $time, line $line)';
  }

  static DateTime parseTime(String timeString) {
    List<String> parts = timeString.split(':');
    if (parts.length == 3) {
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);
      int second = int.parse(parts[2]);

      return DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, hour, minute, second);
    } else {
      throw FormatException('Invalid time format: $timeString');
    }
  }

  String formatTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedTime =
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

    return formattedTime;
  }

  void setBusLine(BusLine line) {
    this.line = line;
  }

  static List<BusRoute> sortBusRoutesByTime(List<BusRoute> busRoutes) {
    DateTime now = DateTime.now();
    List<BusRoute> futureRoutes =
        busRoutes.where((busRoute) => busRoute.time.isAfter(now)).toList();
    futureRoutes.sort((a, b) => a.time.compareTo(b.time));
    return futureRoutes;
  }
}
