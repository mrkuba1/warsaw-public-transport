import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  @override
  void initState() {
    super.initState();
    _stopsFuture = _loadStops();
  }

  Future<BusstopsInfo> _loadStops() async {
    final text = await rootBundle.loadString('assets/all_busstops_info.json');
    return BusstopsInfo.fromJson(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Przystanki')),
      body: FutureBuilder<BusstopsInfo>(
        future: _stopsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Błąd: ${snapshot.error}'));
          }
          final stops = snapshot.data!.stops;
          return ListView.builder(
            itemCount: stops.length,
            itemBuilder: (context, i) {
              final s = stops[i];
              return ListTile(
                title: Text('${s.name} ${s.smallid}'),
                subtitle: Text(s.destination),
              );
            },
          );
        },
      ),
    );
  }
}
