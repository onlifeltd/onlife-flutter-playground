import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onlife_map_view/onlife_map.dart';
import 'package:onlife_map_view/widget/onlife_map_poi_layer.dart';

import 'model/poi_data.dart';
import 'state/poi_provider.dart';
import 'widget/map_my_place.dart';
import 'widget/map_poi.dart';
import 'widget/map_poi_cluster.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  var cameraOption = MapCameraCenter(
    center: melbourne,
    zoom: 14.0,
  );

  var currentLocation = melbourne;
  String? selectedPoiId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cameraOption = MapCameraCenter(
            center: melbourne,
            zoom: 14.0,
            bearing: 0,
          );
          setState(() {});
        },
        child: const Icon(Icons.navigation),
      ),
      body: Stack(
        children: [
          Consumer(
            builder: (context, ref, child) {
              final coffeeShopLocation = ref.watch(poiProvider).value;
              return OnlifeMapView(
                mapOptions: const OnlifeMapOptions(
                  mapStyle: 'mapbox://styles/obattaglet/clq4k9p5400nf01r7cno145gi',
                  defaultMapCenter: melbourne,
                  enableClusteringAnimation: true,
                ),
                mapCameraOptions: cameraOption,
                onLocationChange: (position) {
                  currentLocation = position;
                },
                poiLayers: [
                  OnlifeMapPoiLayer(
                    'coffeeShops',
                    clusterOption: const OnlifeMapPoiClusterOption(
                      radius: 40,
                      maxZoom: 15,
                      minZoom: 10,
                    ),
                    pois: coffeeShopLocation
                            ?.mapIndexed((index, e) => OnlifeMapPoi(
                                  id: 'coffeeShop$index',
                                  position: e.location,
                                  focused: 'coffeeShop$index' == selectedPoiId,
                                  data: e,
                                ))
                            .toList() ??
                        [],
                  ),
                  OnlifeMapPoiLayer(
                    'myPlacePois',
                    pois: [
                      OnlifeMapPoi(
                        id: 'myPlace',
                        position: currentLocation,
                        anchorPoint: OnlifeMapPoiAnchorPoint.center,
                      ),
                    ],
                  ),
                ],
                poiBuilder: (poiData) {
                  if (poiData.layerId == 'myPlacePois') {
                    return MapMyPlaceWidget(key: Key(poiData.id), poiData);
                  } else if (poiData.layerId == 'coffeeShops') {
                    if (!poiData.isCluster) {
                      return MapPoi(
                        key: Key(poiData.id),
                        poiData: poiData.onlifeMapPoi?.data as PoiData,
                        focused: poiData.focused,
                      );
                    } else {
                      return MapPoiClusterWidget(
                        key: Key(poiData.id),
                        poiData,
                        focused: poiData.poiId == selectedPoiId,
                      );
                    }
                  }
                  return null;
                },
                poiSizeBuilder: (_) => const Size(30, 30),
                onPoiTap: (layerId, poiId, {data}) {
                  final poiData = data as OnlifeMapPoiWidgetData;
                  String? newSelected = poiId;

                  if (data.poiId == selectedPoiId) {
                    newSelected = null;
                  }

                  if (newSelected != selectedPoiId) {
                    selectedPoiId = newSelected;
                  }

                  if (layerId == 'coffeeShops') {
                    if (!poiData.isCluster) {
                      final index = int.tryParse(poiId.substring('coffeeShop'.length));

                      if (coffeeShopLocation != null &&
                          index != null &&
                          index >= 0 &&
                          index < coffeeShopLocation.length) {
                        cameraOption = MapCameraCenter(
                          center: coffeeShopLocation[index].location,
                          zoom: 14.0,
                          durationInMilliseconds: 500,
                        );
                      } else {
                        selectedPoiId = null;
                      }
                    } else {
                      cameraOption = MapCameraCenter(
                        center: poiData.mapPosition,
                        zoom: 14.0,
                        durationInMilliseconds: 500,
                      );
                    }
                    if (mounted) {
                      setState(() {});
                    }
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
