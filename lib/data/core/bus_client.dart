import 'dart:convert';

import 'package:warsaw_public_transport/data/core/base_client.dart';
import 'package:warsaw_public_transport/data/core/bus_client_path.dart';

class BusClient extends BABaseClient {
  Future<String> getBusstopLines(
      String busstopID, String busstopIDsmall) async {
    final response = await post(
      BusClientPath.busstopsline.baseUri,
      {'busstopId': busstopID, 'busstopNr': busstopIDsmall},
    );
    print('Status: ${response.statusCode}');
    return utf8.decode(response.bodyBytes);
  }
}
