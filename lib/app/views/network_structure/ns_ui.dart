import 'dart:convert';
import 'dart:math';

import 'package:app_port_cap/app/models/index.dart';
import 'package:app_port_cap/app/resources/resources.dart';
import 'package:app_port_cap/app/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graphview/GraphView.dart';

class NetworkStructure extends StatefulWidget {
  const NetworkStructure({super.key});

  @override
  _NetworkStructureState createState() => _NetworkStructureState();
}

class _NetworkStructureState extends State<NetworkStructure> {
  late final UserModel userData;
  final datastore = GetStorage();

  int n = 8;
  Random r = Random();

  @override
  void initState() {
    var result = datastore.read('user');
    // print(result);
    final a = Node.Id(1);
    final b = Node.Id(2);
    final c = Node.Id(3);
    final d = Node.Id(4);
    final e = Node.Id(5);
    final f = Node.Id(6);
    final g = Node.Id(7);
    final h = Node.Id(8);

    graph.addEdge(a, b, paint: Paint()..color = Colors.red);
    graph.addEdge(a, c);
    graph.addEdge(a, d);
    graph.addEdge(c, e);
    graph.addEdge(d, f);
    graph.addEdge(f, c);
    graph.addEdge(g, c);
    graph.addEdge(h, g);

    builder = FruchtermanReingoldAlgorithm(iterations: 1000);
    dynamic jsonData = jsonDecode(result);
    userData = UserModel.fromMap(jsonData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: TTCCorpColors.Gray,
        appBar: buildAppBar(context, userData.name, leadingEnable: true),
        body: Column(
          children: [
            Expanded(
              child: InteractiveViewer(
                  constrained: false,
                  boundaryMargin: const EdgeInsets.all(8),
                  minScale: 0.001,
                  maxScale: 100,
                  child: GraphView(
                      graph: graph,
                      algorithm: builder,
                      paint: Paint()
                        ..color = Colors.green
                        ..strokeWidth = 1
                        ..style = PaintingStyle.fill,
                      builder: (Node node) {
                        // I can decide what widget should be shown here based on the id
                        var a = node.key!.value as int?;
                        if (a == 2) {
                          return rectangWidget(a);
                        }
                        return rectangWidget(a);
                      })),
            ),
          ],
        ),
      ),
    );
  }

  Widget rectangWidget(int? i) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(color: Colors.blue, spreadRadius: 1),
          ],
        ),
        child: Text('devixe $i'));
  }

  final Graph graph = Graph();
  late Algorithm builder;
}
