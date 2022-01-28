import 'package:tp_flutter/model/picture.dart';

class Housing {
  String title, id;
  Picture illustrations;

  Housing(this.title, this.id, this.illustrations);

  Housing.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        title = json['title'],
        illustrations = Picture.fromJson(json['illustrations']);

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'title': title,
        'illustrations': illustrations.toJson(),
      };
}
