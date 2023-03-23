import 'package:http/http.dart' as http;
import 'dart:convert';

class YGOcard {
  int id;
  String cardName;
  String cardType;
  String? attribute;
  String description;
  String? archetype;
  int? atk;
  int? def;
  int? cardLevel;
  String race;
  int? linkval;
  List? linkmarkers;
  int? cardScale;
  String imageUrl;

  YGOcard({
    required this.id,
    required this.cardName,
    required this.cardType,
    this.attribute,
    required this.description,
    this.archetype,
    this.atk,
    this.def,
    this.cardLevel,
    required this.race,
    this.linkval,
    this.linkmarkers,
    this.cardScale,
    required this.imageUrl,
  });

  Map toJson() => {
        'id': id,
        'cardName': cardName,
        'cardType': cardType,
        'attribute': attribute,
        'description': description,
        'archetype': archetype,
        'atk': atk,
        'def': def,
        'cardLevel': cardLevel,
        'race': race,
        'linkval': linkval,
        'linkmarkers': linkmarkers,
        'cardScale': cardScale,
        'imageUrl': imageUrl,
      };

  static Future<List> getAllCards(String str) async {
    var url = str;
    final response = await http
        .get(Uri.parse(url), headers: {"Access-Control-Allow-Origin": "*"});
    final body = json.decode(response.body);
    if (body['data'] == null) return [];
    List data = (body['data']);
    List cards = [];

    for (var i = 0; i < data.length; i++) {
      cards.add((YGOcard(
        id: data[i]['id'],
        cardName: data[i]['name'],
        attribute: data[i]['attribute'],
        cardType: data[i]['type'],
        description: data[i]['desc'],
        archetype: data[i]['archetype'],
        atk: data[i]['atk'],
        def: data[i]['def'],
        cardLevel: data[i]['level'],
        race: data[i]['race'],
        linkval: data[i]['linkval'],
        linkmarkers: data[i]['linkmarkers'],
        cardScale: data[i]['scale'],
        imageUrl: data[i]['card_images'][0]['image_url'],
      )));
    }

    return cards;
  }
}
