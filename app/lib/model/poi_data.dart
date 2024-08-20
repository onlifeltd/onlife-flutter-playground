import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:onlife_map_view/onlife_map.dart';

const melbourne = Position(-37.810107889595514, 144.96966113831883);

enum PoiType {
  shop,
  restaurant,
  bar,
  coffee;

  static PoiType randomType() {
    final random = Random();
    const values = PoiType.values;
    return values[random.nextInt(values.length)];
  }
}

class PoiData extends Equatable {
  final String id;
  final Position location;
  final PoiType type;

  const PoiData(this.id, this.location, this.type);

  @override
  List<Object?> get props => [id, location, type];
}
