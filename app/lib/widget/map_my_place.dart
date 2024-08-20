import 'package:flutter/material.dart';
import 'package:onlife_map_view/widget/onlife_map_poi_layer.dart';

class MapMyPlaceWidget extends StatelessWidget {
  const MapMyPlaceWidget(
    this.data, {
    super.key,
  });

  final OnlifeMapPoiWidgetData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.pets_outlined,
        color: Colors.white,
      ),
    );
  }
}
