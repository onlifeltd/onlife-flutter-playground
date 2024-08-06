import 'package:app/coffee_shop_poi.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:onlife_map_view/onlife_map.dart';

const melbourne = Position(-37.81410937028515, 144.9633945897505);

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
  var coffeeShopLocation = [
    const Position(-37.813884259248766, 144.96599704001218),
    const Position(-37.81100241411018, 144.96436625695327),
    const Position(-37.81768134226083, 144.968014061164),
  ];
  int? selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cameraOption = MapCameraCenter(
            center: currentLocation,
            zoom: 14.0,
          );
          setState(() {});
        },
        child: const Icon(Icons.navigation),
      ),
      body: Stack(
        children: [
          OnlifeMapView(
            mapOptions: const OnlifeMapOptions(
              mapStyle: 'mapbox://styles/obattaglet/clq4k9p5400nf01r7cno145gi',
              defaultMapCenter: melbourne,
            ),
            mapCameraOptions: cameraOption,
            onLocationChange: (position) {
              currentLocation = position;
            },
            poiLayers: [
              OnlifeMapPoiLayer(
                'coffeeShops',
                pois: coffeeShopLocation
                    .mapIndexed((index, e) => OnlifeMapPoi(
                          id: 'coffeeShop$index',
                          position: e,
                          focused: index == selected,
                        ))
                    .toList(),
              ),
              OnlifeMapPoiLayer(
                'myPlacePois',
                pois: [
                  OnlifeMapPoi(
                    id: 'myPlace',
                    position: currentLocation,
                  ),
                ],
              ),
            ],
            poiBuilder: (poiData) {
              if (poiData.layerId == 'myPlacePois') {
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
              } else if (poiData.layerId == 'coffeeShops') {
                return CoffeeShopPoi(focused: poiData.focused);
              }
              return null;
            },
            onPoiTap: (layerId, poiId) {
              if (layerId == 'coffeeShops') {
                int? newSelected = int.parse(poiId.replaceAll('coffeeShop', ''));
                if (newSelected == selected) {
                  newSelected = null;
                }

                if (newSelected != selected) {
                  selected = newSelected;
                  if (selected != null) {
                    cameraOption = MapCameraCenter(
                      center: coffeeShopLocation[selected!],
                      zoom: 14.0,
                      durationInMilliseconds: 1000,
                    );
                  }
                  setState(() {});
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
