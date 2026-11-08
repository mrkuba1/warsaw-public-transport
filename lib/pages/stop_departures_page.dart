import 'package:flutter/material.dart';
import 'package:warsaw_public_transport/data/busstops/models/busstopdata.dart';
import 'package:warsaw_public_transport/data/core/bus_client.dart';
import 'package:warsaw_public_transport/data/timetables/models/busroute.dart';

class StopDeparturesPage extends StatefulWidget {
  final BusstopInfo stop;
  const StopDeparturesPage({super.key, required this.stop});

  @override
  State<StopDeparturesPage> createState() => _StopDeparturesPageState();
}

class _StopDeparturesPageState extends State<StopDeparturesPage> {
  final _client = BusClient();
  late final Future<List<BusRoute>> _departuresFuture;

  @override
  void initState() {
    super.initState();
    _departuresFuture = _loadDepartures();
  }

  Future<List<BusRoute>> _loadDepartures() async {
    final s = widget.stop;

    final busstopLines = await _client.getBusstopLines(s.id, s.smallid);
    final lines = busstopLines.lines;

    final results = await Future.wait(
      lines.map((l) => _client.getBusRoutes(s.id, s.smallid, l.number)),
    );

    final all = <BusRoute>[];
    for (var i = 0; i < lines.length; i++) {
      for (final route in results[i].routes) {
        route.setBusLine(lines[i]);
        all.add(route);
      }
    }

    return BusRoute.sortBusRoutesByTime(all);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.stop.name} ${widget.stop.smallid}')),
      body: FutureBuilder<List<BusRoute>>(
        future: _departuresFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Błąd: ${snapshot.error}'));
          }
          final departures = snapshot.data!;
          if (departures.isEmpty) {
            return const Center(child: Text('Brak odjazdów do końca dnia'));
          }
          return ListView.builder(
            itemCount: departures.length,
            itemBuilder: (context, i) {
              final d = departures[i];
              final time =
                  '${d.time.hour.toString().padLeft(2, '0')}:${d.time.minute.toString().padLeft(2, '0')}';
              return ListTile(
                leading: Text(d.line?.number ?? '?',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                title: Text('→ ${d.destination}'),
                trailing: Text(time, style: const TextStyle(fontSize: 16)),
              );
            },
          );
        },
      ),
    );
  }
}
