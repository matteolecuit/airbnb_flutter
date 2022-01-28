import 'package:tp_flutter/model/picture.dart';

class Housing {
  String title, id;
  num price;
  Picture illustrations;

  Housing(this.title, this.id, this.price, this.illustrations);

  Housing.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        title = json['title'],
        price = json['price'],
        illustrations = Picture.fromJson(json['illustrations']);

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'title': title,
        'price': price.toString(),
        'illustrations': illustrations.toJson(),
      };
}
