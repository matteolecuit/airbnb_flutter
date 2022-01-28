import 'package:flutter/material.dart';
import 'package:tp_flutter/model/housing.dart';

class HousingDetailPage extends StatefulWidget {
  final Housing housing;
  const HousingDetailPage(this.housing, {Key? key}) : super(key: key);

  @override
  _HousingDetailPageState createState() => _HousingDetailPageState();
}

class _HousingDetailPageState extends State<HousingDetailPage> {
  late List<Housing> listHousings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: BottomAppBar(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(widget.housing.price.toString() + " / night"),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () => {}, child: const Text("Book now"))
                ],
              ),
            ),
          ),
        ),
        body: Column(mainAxisSize: MainAxisSize.max, children: [
          Row(
            children: [
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          "https://flutter-learning.mooo.com" +
                              widget.housing.illustrations.url,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      children: [
                        Text(widget.housing.title),
                        Text(widget.housing.price.toString() + " / night"),
                      ],
                    ),
                  )
                ],
              ),
            ],
          )
        ]));
  }
}
