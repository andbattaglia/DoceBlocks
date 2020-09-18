import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:doce_blocks/data/models/models.dart';

abstract class DoceboDataSource {
  Future<List<Block>> getCatalog();
}

class DoceboDataSourceImpl extends DoceboDataSource {
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          SINGLETON
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  static final DoceboDataSourceImpl _singleton = DoceboDataSourceImpl._internal();

  factory DoceboDataSourceImpl() {
    return _singleton;
  }

  DoceboDataSourceImpl._internal();

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          AUTH METHOD
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  Future<List<Block>> getCatalog() async {
    final String url = 'https://demomobile.docebosaas.com/learn/v1/catalog';
    final http.Response response = await http.get(url);

    final Map<String, dynamic> body = json.decode(response.body);
    final Map<String, dynamic> data = body["data"];
    final List<dynamic> items = data["items"];
    final List<Block> blocks = items.asMap().entries.map((entry) {
      final int index = entry.key;
      final dynamic value = entry.value;

      return Block.fromDoceboApi(value, index == 0 ? CardSize.BIG : CardSize.SMALL);
    }).toList();

    return blocks;
  }
}
