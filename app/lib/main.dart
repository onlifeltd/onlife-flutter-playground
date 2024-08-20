import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import 'config.dart';
import 'map_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  MapboxOptions.setAccessToken(Config.mapboxAccessToken);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MapPage(),
    );
  }
}
