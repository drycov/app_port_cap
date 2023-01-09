import 'package:app_port_cap/app/widgets/maps/zoom_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';

import 'scale_layer_plugin_option.dart';

class PolylinePage extends StatefulWidget {
  static const String route = 'polyline';

  const PolylinePage({Key? key}) : super(key: key);

  @override
  State<PolylinePage> createState() => _PolylinePageState();
}

class _PolylinePageState extends State<PolylinePage> {
  late Future<List<Polyline>> polylines;

  Future<List<Polyline>> getPolylines() async {
    final polyLines = [
      Polyline(
        points: [
          LatLng(50.00541, 82.56837),
          LatLng(50.431610, 80.267485),
          LatLng(52.296721, 76.973457),
        ],
        strokeWidth: 4,
        color: Colors.amber,
      ),
    ];
    await Future<void>.delayed(const Duration(seconds: 3));
    return polyLines;
  }

  @override
  void initState() {
    polylines = getPolylines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final points = <LatLng>[
      LatLng(50.00541, 82.56837),
      LatLng(50.431610, 80.267485),
      LatLng(52.296721, 76.973457),
      LatLng(53.280937, 69.387052),
      LatLng(51.167052, 71.407989),
    ];

    final pointsGradient = <LatLng>[
      LatLng(50.00541, 82.56837),
      LatLng(50.431610, 80.267485),
      LatLng(52.296721, 76.973457),
      LatLng(53.280937, 69.387052),
      LatLng(51.167052, 71.407989),
    ];

    return Padding(
      padding: const EdgeInsets.all(8),
      child: FutureBuilder<List<Polyline>>(
        future: polylines,
        builder:
            (BuildContext context, AsyncSnapshot<List<Polyline>> snapshot) {
          debugPrint('snapshot: ${snapshot.hasData}');
          if (snapshot.hasData) {
            return Column(
              children: [
                Flexible(
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(50.556157, 69.682821),
                      zoom: 5,
                      onTap: (tapPosition, point) {
                        setState(() {
                          debugPrint('onTap');
                          polylines = getPolylines();
                        });
                      },
                    ),
                    nonRotatedChildren: [
                      const FlutterMapZoomButtons(
                        minZoom: 4,
                        maxZoom: 19,
                        mini: true,
                        padding: 10,
                        alignment: Alignment.bottomRight,
                      ),
                      ScaleLayerWidget(
                          options: ScaleLayerPluginOption(
                        lineColor: Colors.blue,
                        lineWidth: 2,
                        textStyle:
                            const TextStyle(color: Colors.blue, fontSize: 12),
                        padding: const EdgeInsets.all(10),
                      )),
                    ],
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName:
                            'dev.fleaflet.flutter_map.example',
                      ),
                      PolylineLayer(
                        polylines: [
                          Polyline(
                              points: points,
                              strokeWidth: 4,
                              color: Colors.purple),
                        ],
                      ),
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: pointsGradient,
                            strokeWidth: 2,
                            gradientColors: [
                              const Color(0xff007E2D),
                              const Color(0xff007E2D),
                            ],
                          ),
                        ],
                      ),
                      PolylineLayer(
                        polylines: snapshot.data!,
                        polylineCulling: true,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return const Text(
              'Getting map data...\n\nTap on map when complete to refresh map data.');
        },
      ),
    );
  }
}
