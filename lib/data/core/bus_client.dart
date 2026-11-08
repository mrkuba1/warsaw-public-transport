import 'dart:convert';
import 'package:warsaw_public_transport/data/core/base_client.dart';
import 'package:warsaw_public_transport/data/core/bus_client_path.dart';
import 'package:warsaw_public_transport/data/lines/models/busstoplines.dart';
import 'package:warsaw_public_transport/data/timetables/models/busroutes.dart';

class BusClient extends BABaseClient {
  Future<BusstopLines> getBusstopLines(
      String busstopID, String busstopIDsmall) async {
    final response = await post(
      BusClientPath.busstopsline.baseUri,
      {'busstopId': busstopID, 'busstopNr': busstopIDsmall},
    );
    return BusstopLines.fromJson(utf8.decode(response.bodyBytes));
  }

  Future<Busroutes> getBusRoutes(
      String busstopID, String busstopIDsmall, String line) async {
    final response = await post(
      BusClientPath.timetables.baseUri,
      {'busstopId': busstopID, 'busstopNr': busstopIDsmall, 'line': line},
    );
    return Busroutes.fromJson(utf8.decode(response.bodyBytes));
    // print('Status: ${response.statusCode}');
    // return utf8.decode(response.bodyBytes);
  }
}
