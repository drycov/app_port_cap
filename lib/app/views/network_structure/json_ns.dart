// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, avoid_print

import 'dart:convert';

import 'package:app_port_cap/app/models/index.dart';
import 'package:app_port_cap/app/resources/resources.dart';
import 'package:app_port_cap/app/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphview/GraphView.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LayerGraphPageFromJson extends StatefulWidget {
  const LayerGraphPageFromJson({super.key});

  @override
  _LayerGraphPageFromJsonState createState() => _LayerGraphPageFromJsonState();
}

class _LayerGraphPageFromJsonState extends State<LayerGraphPageFromJson> {
  final List<String> items = [
    'Серебрянск',
    'Селезневка',
    'Бухтарма',
    'Заводинка',
  ];
  final TextEditingController textEditingController = TextEditingController();

  String? selectedValue;

  var json = {
    "nodes": [
      {
        "id": '7fzalkInXQcto6uhIKv4',
        "label": 'Adsl1-SRB-OSK',
        "ip_a": '10.145.2.6'
      },
      {
        "id": 'NTSFsDFKZekQqdmRoCPI',
        "label": 'Adsl2-SRB-OSK',
        "ip_a": '10.145.2.7'
      },
      {
        "id": '7i96D6ZlPopIvaQH3RPi',
        "label": 'Adsl3-SRB-OSK',
        "ip_a": '10.145.2.160'
      }
    ],
    "edges": [
      {"from": "7fzalkInXQcto6uhIKv4", "to": 'NTSFsDFKZekQqdmRoCPI'},
      {"from": "7fzalkInXQcto6uhIKv4", "to": '7i96D6ZlPopIvaQH3RPi'}
    ]
  };

  var DeviceInfo = {
    "devices": [
      {
        "id": 'NTSFsDFKZekQqdmRoCPI',
        "name": 'Adsl2-SRB-OSK',
        "ip": '10.145.2.7',
        "vendor": 'Zyxel',
        "model": 'IES516',
        "location": 'srb',
        "ports": '12',
        "run_ports": '10'
      },
      {
        "id": '7fzalkInXQcto6uhIKv4',
        "name": 'Adsl1-SRB-OSK',
        "ip": '10.145.2.6',
        "vendor": 'Zyxel',
        "model": 'IES516',
        "location": 'srb',
        "ports": '12',
        "run_ports": '12'
      },
      {
        "id": '7i96D6ZlPopIvaQH3RPi',
        "name": 'Adsl3-SRB-OSK',
        "ip": '10.145.2.160',
        "vendor": 'Huawei',
        "model": 'SMA5116',
        "location": 'srb',
        "ports": '64',
        "run_ports": '48'
      }
    ]
  };
  late final UserModel userData;
  final datastore = GetStorage();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context, userData.name, leadingEnable: true),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildSelectableLocation(context),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: TTCCorpColors.White,
                  ),
                  child: InteractiveViewer(
                      constrained: false,
                      boundaryMargin: const EdgeInsets.all(100),
                      minScale: 0.01,
                      maxScale: 5.6,
                      child: GraphView(
                        graph: graph,
                        algorithm: BuchheimWalkerAlgorithm(
                            builder, TreeEdgeRenderer(builder)),
                        paint: Paint()
                          ..color = Colors.green
                          ..strokeWidth = 2
                          ..style = PaintingStyle.stroke,
                        builder: (Node node) {
                          // I can decide what widget should be shown here based on the id
                          var a = node.key?.value;
                          var nodes = json['nodes'];
                          var devices = DeviceInfo['devices'];
                          var nodeValue = nodes
                              ?.firstWhere((element) => element['id'] == a);
                          // return rectangleWidget(nodeValue['label'] as String);
                          return rectangleWidget(nodeValue!['label'] as String,
                              nodeValue['ip_a'] as String, devices, node);
                        },
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rectangleWidget(String? label, String? ip,
      List<Map<String, String>>? devices, Node node) {
    return Container(
      color: Colors.amber,
      child: InkWell(
        onTap: () {
          var a = node.key?.value;
          var devValue = devices!.firstWhere((element) => element['id'] == a);
          var free = int.parse(devValue['ports'] as String) -
              int.parse(devValue['run_ports'] as String);

          // toastmessage(devValue.toString(), TTCCorpColors.Gray);
          showMaterialModalBottomSheet(
              context: context,
              builder: (context) => Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: TTCCorpColors.Apple,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                '${devValue['name'] as String} / (${devValue['ip'] as String})',
                                style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                      color: TTCCorpColors.White,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Device Vendor/(model)',
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: TTCCorpColors.Apple,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              '${devValue['vendor'] as String} / (${devValue['model'] as String})',
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: TTCCorpColors.Apple,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Device location',
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: TTCCorpColors.Apple,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              devValue['location'] as String,
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: TTCCorpColors.Apple,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Device port capacity',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    color: free == 0
                                        ? TTCCorpColors.Red
                                        : TTCCorpColors.ForestGreen,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              '${devValue['ports'] as String} / ${devValue['run_ports'] as String} / free: ${free}',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    color: free == 0
                                        ? TTCCorpColors.Red
                                        : TTCCorpColors.ForestGreen,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ));
          print('clicked: ${devValue}');
        },
        child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(color: Colors.blue[100]!, spreadRadius: 1),
              ],
            ),
            child: Text('${label}\n${ip}')),
      ),
    );
  }

  final Graph graph = Graph()..isTree = true;
  @override
  void initState() {
    super.initState();
    var result = datastore.read('user');
    dynamic jsonData = jsonDecode(result);
    userData = UserModel.fromMap(jsonData);
    var edges = json['edges']!;
    for (var element in edges) {
      var fromNodeId = element['from'];
      var toNodeId = element['to'];
      graph.addEdge(Node.Id(fromNodeId), Node.Id(toNodeId));
    }
    builder
      ..siblingSeparation = (50)
      ..levelSeparation = (50)
      ..subtreeSeparation = (25)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  Widget _buildSelectableLocation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: TTCCorpColors.Apple, width: 4),
            color: TTCCorpColors.White,
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // const SizedBox(
                //   height: 8,
                // ),
                // const SizedBox(height: 4),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    // style: TextStyle(color: TTCCorpColors.White),
                    // selectedItemHighlightColor: TTCCorpColors.White,
                    // buttonHighlightColor: TTCCorpColors.White,
                    isExpanded: true,
                    hint: const Text(
                      'Select Item',
                      style: TextStyle(
                        fontSize: 14,
                        color: TTCCorpColors.Black,
                      ),
                    ),
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                    fontSize: 14, color: TTCCorpColors.Black),
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as String;
                      });
                    },
                    buttonHeight: 40,
                    buttonWidth: 300,
                    itemHeight: 40,
                    dropdownMaxHeight: 300,
                    searchController: textEditingController,
                    searchInnerWidget: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 4,
                        right: 8,
                        left: 8,
                      ),
                      child: TextFormField(
                        controller: textEditingController,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          hintText: 'Поиск по участку ...',
                          hintStyle: const TextStyle(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      return (item.value.toString().contains(searchValue));
                    },
                    //This to clear the search value when you close the menu
                    onMenuStateChange: (isOpen) {
                      if (!isOpen) {
                        textEditingController.clear();
                      }
                    },
                  ),
                ),
                // const SizedBox(
                //   height: 8,
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

var builder = BuchheimWalkerConfiguration();
