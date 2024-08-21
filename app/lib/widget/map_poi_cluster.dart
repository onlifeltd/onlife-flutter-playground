import 'package:flutter/material.dart';
import 'package:onlife_map_view/widget/onlife_map_poi_layer.dart';

import '../model/poi_data.dart';
import 'map_poi.dart';

class MapPoiClusterWidget extends StatelessWidget {
  const MapPoiClusterWidget(
    this.data, {
    super.key,
    required this.focused,
  });

  final OnlifeMapPoiWidgetData data;
  final bool focused;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: focused ? data.pois.length * 40 : 30,
      width: focused ? 40 + 4 : 30,
      child: focused
          ? OverflowBox(
              child: Column(
                children: [
                  ...data.pois.map((e) => Expanded(
                        child: MapPoi(
                          poiData: e.data as PoiData,
                        ),
                      ))
                ],
              ),
            )
          : NumberCircleWidget(data.poiCount),
    );
  }
}

class NumberCircleWidget extends StatelessWidget {
  const NumberCircleWidget(
    this.number, {
    super.key,
  });

  final int number;

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
        '$number',
        style: const TextStyle(color: Colors.white),
      )),
    );
  }
}
