import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:warsaw_public_transport/data/core/bus_client.dart';
import 'package:warsaw_public_transport/data/timetables/models/busroute.dart';
import 'package:warsaw_public_transport/pages/stop_departures_page.dart';

import 'data/busstops/models/busstopsinfo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Komunikacja WAW',
      theme: ThemeData(colorSchemeSeed: Colors.green, useMaterial3: true),
      home: const StopsPage(),
    );
  }
}

class StopsPage extends StatefulWidget {
  const StopsPage({super.key});

  @override
  State<StopsPage> createState() => _StopsPageState();
}

class _StopsPageState extends State<StopsPage> {
  late final Future<BusstopsInfo> _stopsFuture;
  String _query = '';
  @override
  void initState() {
    super.initState();
    _stopsFuture = _loadStops();
    // BusClient().getBusstopLines('7009', '01').then(
    //       (result) => print(result.lines.map((l) => l.number).toList()),
    //     );
    // BusClient().getBusRoutes('7009', '01', '182').then(print);
    BusClient().getBusRoutes('7009', '01', '182').then((r) {
      print('Wszystkich odjazdów dziś: ${r.routes.length}');
      final next = BusRoute.sortBusRoutesByTime(r.routes).take(5);
      for (final d in next) {
        print(
            '${d.time.hour}:${d.time.minute.toString().padLeft(2, '0')} → ${d.destination}');
      }
    });
  }

  Future<BusstopsInfo> _loadStops() async {
    final text = await rootBundle.loadString('assets/all_busstops_info.json');
    return BusstopsInfo.fromJson(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Przystanki')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Szukaj przystanku',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() => _query = value);
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<BusstopsInfo>(
                future: _stopsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Błąd: ${snapshot.error}'));
                  }
                  final stops = snapshot.data!.getBusstopsInfoByName(_query);
                  return ListView.builder(
                      itemCount: stops.length,
                      itemBuilder: (context, i) {
                        final s = stops[i];
                        return ListTile(
                          title: Text('${s.name} ${s.smallid}'),
                          subtitle: Text(s.destination),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      StopDeparturesPage(stop: s),
                                ));
                          },
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}
