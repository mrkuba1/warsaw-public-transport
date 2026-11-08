import 'dart:convert';
import 'package:warsaw_public_transport/data/lines/models/busline.dart';

class BusstopLines {
  final List<BusLine> lines;

  BusstopLines({required this.lines});

  factory BusstopLines.fromJson(String source) {
    final list = json.decode(source) as List<dynamic>;
    return BusstopLines(
      lines: list.map((x) => BusLine.fromMap(x)).toList(),
    );
  }

  BusLine getBuslinebyLine(String line) {
    return lines.firstWhere(
      (busline) => busline.number == line,
      orElse: () => throw Exception('Busline not found for the given line'),
    );
  }
}
