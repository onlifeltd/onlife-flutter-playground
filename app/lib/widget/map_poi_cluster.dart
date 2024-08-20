import 'package:flutter/material.dart';
import 'package:onlife_map_view/widget/onlife_map_poi_layer.dart';

class MapPoiClusterWidget extends StatelessWidget {
  const MapPoiClusterWidget(
    this.data, {
    super.key,
  });

  final OnlifeMapPoiWidgetData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Center(
          child: Text(
        '${data.poiCount}',
        style: const TextStyle(color: Colors.white),
      )),
    );
  }
}
