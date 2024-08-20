import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onlife_map_view/onlife_map.dart';

import '../model/poi_data.dart';

double generateRandomDouble(double from, double to) {
  final random = Random();
  return from + random.nextDouble() * (to - from);
}

final poiProvider = FutureProvider.autoDispose((ref) async {
  final coffeeShopLocation = List.generate(20, (index) {
    return PoiData(
        'poi $index',
        Position(
          melbourne.latitude + generateRandomDouble(-0.01, 0.01),
          melbourne.longitude + generateRandomDouble(-0.01, 0.01),
        ),
        PoiType.randomType());
  });

  return coffeeShopLocation;
});
