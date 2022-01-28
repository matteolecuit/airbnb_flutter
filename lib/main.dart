import 'package:flutter/material.dart';
import 'package:tp_flutter/page/cities_list_page.dart';
import 'package:tp_flutter/page/home_page.dart';
import 'package:tp_flutter/page/housing_list_page.dart';
import 'package:tp_flutter/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //Sélectionne le thème à utiliser
      themeMode: ThemeMode.light,
      //On spécifie les particularités du thème dark
      darkTheme: ThemeData(brightness: Brightness.dark),
      initialRoute: ROUTE_HOME,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case ROUTE_HOME:
                  return HomePage();
                case ROUTE_CITIES_LIST:
                  return CitiesListPage();
                case ROUTE_HOUSINGS_LIST:
                  return HousingsListPage((settings.arguments as List)[0]);
                case ROUTE_HOUSING_DETAIL:
                  return CitiesListPage();
                default:
                  return const Center(child: Text("404 : Page Not Found"));
              }
            });
      },
    );
  }
}
