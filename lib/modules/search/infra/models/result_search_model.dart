import 'dart:convert';

import 'package:clean_flutterando/modules/search/domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {
  final String login;
  final String id;
  final String img;

  ResultSearchModel({this.login, this.id, this.img});

  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'id': id,
      'avatar_url': img,
    };
  }

  factory ResultSearchModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ResultSearchModel(
      login: map['login'],
      id: map['id'].toString(),
      img: map['avatar_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultSearchModel.fromJson(String source) =>
      ResultSearchModel.fromMap(json.decode(source));
}
