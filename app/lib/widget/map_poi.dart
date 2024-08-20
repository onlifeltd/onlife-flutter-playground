import 'package:flutter/material.dart';

import '../model/poi_data.dart';

class MapPoi extends StatefulWidget {
  const MapPoi({super.key, this.focused = false, required this.poiData});

  final PoiData poiData;
  final bool focused;

  @override
  State<MapPoi> createState() => _MapPoiState();
}

class _MapPoiState extends State<MapPoi> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      clipBehavior: Clip.hardEdge,
      height: 40,
      width: widget.focused ? 80 : 40,
      decoration: BoxDecoration(
        color: switch (widget.poiData.type) {
          PoiType.shop => Colors.green,
          PoiType.restaurant => Colors.red,
          PoiType.bar => Colors.orange,
          _ => Colors.blue,
        },
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: OverflowBox(
        maxWidth: 80,
        maxHeight: 40,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              child: Icon(
                switch (widget.poiData.type) {
                  PoiType.shop => Icons.local_mall,
                  PoiType.restaurant => Icons.restaurant,
                  PoiType.bar => Icons.local_bar,
                  _ => Icons.coffee,
                },
                // Icons.coffee,
                color: Colors.white,
              ),
            ),
            if (widget.focused)
              Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
