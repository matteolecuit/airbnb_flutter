import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tp_flutter/model/housing.dart';

class HousingsListPage extends StatefulWidget {
  final String cityId;
  const HousingsListPage(this.cityId, {Key? key}) : super(key: key);

  @override
  _HousingsListPageState createState() => _HousingsListPageState();
}

class _HousingsListPageState extends State<HousingsListPage> {
  late List<Housing> listHousings;
  late Stream<List<Housing>> _streamHousings;
  late StreamController<List<Housing>> _streamControllerHousings;
  final _scrollControlList = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: _buildListHousings()),
      ],
    ));
  }

  @override
  void initState() {
    _streamControllerHousings = StreamController<List<Housing>>();
    _streamHousings = _streamControllerHousings.stream;
    _fetchHousings(widget.cityId);
  }

  @override
  void dispose() {
    super.dispose();
    _streamControllerHousings.close();
  }

  Widget _buildListHousings() {
    return StreamBuilder<List<Housing>>(
        stream: _streamHousings,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.hasData) {
            listHousings = snapshot.data as List<Housing>;
            return ListView.builder(
                controller: _scrollControlList,
                itemCount: listHousings.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    subtitle: Row(
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.network(
                              "https://flutter-learning.mooo.com" +
                                  listHousings[index].illustrations.url),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(listHousings[index].title))
                      ],
                    ),
                  );
                });
          } else
            return Center(child: CircularProgressIndicator());
        });
  }

  Future<void> _fetchHousings(String cityId) async {
    http.Response responseMessages = await http.get(Uri.parse(
        "https://flutter-learning.mooo.com/logements?place.id=" + cityId));

    if (responseMessages.statusCode == 200) {
      List listHousingsJSON = jsonDecode(responseMessages.body) as List;
      List<Housing> listHousings =
          listHousingsJSON.map((e) => Housing.fromJson(e)).toList();
      _streamControllerHousings.add(listHousings);
    } else {
      _streamControllerHousings.addError("Retry later");
    }
  }
}
