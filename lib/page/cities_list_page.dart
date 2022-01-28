import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tp_flutter/model/city.dart';

class CitiesListPage extends StatefulWidget {
  const CitiesListPage({Key? key}) : super(key: key);

  @override
  _CitiesListPageState createState() => _CitiesListPageState();
}

class _CitiesListPageState extends State<CitiesListPage> {
  late List<City> listCities;
  late Stream<List<City>> _streamCities;
  late StreamController<List<City>> _streamControllerCities;
  final _scrollControlList = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: _buildListCities()),
      ],
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _streamControllerCities.close();
  }

  Widget _buildListCities() {
    return StreamBuilder<List<City>>(
        stream: _streamCities,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.hasData) {
            listCities = snapshot.data as List<City>;
            return ListView.builder(
                controller: _scrollControlList,
                itemCount: listCities.length,
                itemBuilder: (context, index) {
                  print(listCities[index].pic.url);
                  return ListTile(
                    subtitle: Row(
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.network(
                              "https://flutter-learning.mooo.com" +
                                  listCities[index].pic.url),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(listCities[index].name))
                      ],
                    ),
                  );
                });
          } else
            return Center(child: CircularProgressIndicator());
        });
  }

  @override
  void initState() {
    _streamControllerCities = StreamController<List<City>>();
    _streamCities = _streamControllerCities.stream;
    _fetchCities();
  }

  Future<void> _fetchCities() async {
    print('fetching');
    http.Response responseMessages =
        await http.get(Uri.parse("https://flutter-learning.mooo.com/villes"));

    //TODO check 200
    print(responseMessages.statusCode);
    if (responseMessages.statusCode == 200) {
      List listCitiesJSON = jsonDecode(responseMessages.body) as List;
      List<City> listCities =
          listCitiesJSON.map((e) => City.fromJson(e)).toList();
      _streamControllerCities.add(listCities);
    } else {
      _streamControllerCities.addError("Retry later");
    }
  }
}
