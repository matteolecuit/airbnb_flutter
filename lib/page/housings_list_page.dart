import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tp_flutter/model/housing.dart';
import 'package:tp_flutter/routes.dart';

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
                    onTap: () => _navigateToHousingDetails(listHousings[index]),
                    subtitle: Column(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    "https://flutter-learning.mooo.com" +
                                        listHousings[index].illustrations.url),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Column(
                            children: [
                              Text(listHousings[index].title),
                              Text(listHousings[index].price.toString())
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                });
          } else
            return Center(child: CircularProgressIndicator());
        });
  }

  @override
  void _navigateToHousingDetails(Housing housing) {
    Navigator.of(context).pushNamed(ROUTE_HOUSING_DETAIL, arguments: [housing]);
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
