import 'package:tp_flutter/model/picture.dart';

class City {
  String name, id;
  Picture pic;

  City(this.name, this.id, this.pic);

  City.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        name = json['name'],
        pic = Picture.fromJson(json['pic']);

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'name': name,
        'picture': pic.toJson(),
      };
}
