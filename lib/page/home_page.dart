import 'package:flutter/material.dart';
import 'package:tp_flutter/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: _onClick,
                  child: const Text("Where are you going?")),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }

  void _onClick() {
    Navigator.of(context).pushNamed(ROUTE_CITIES_LIST);
  }
}
