import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokemon_app/api/PokemonList.dart';
import 'package:pokemon_app/api/Pokemon.dart';

class PokemonApi {
  static Future<List<PokemonList>> getListPokemon() async {
    var url = 'https://pokeapi.co/api/v2/ability/?limit=327';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<PokemonList> data = (jsonData['results'] as List<dynamic>)
          .map((e) => PokemonList.fromJson(e))
          .toList();
      return data;
    } else {
      throw Exception('${response.reasonPhrase}');
    }
  }

  static Future<Pokemon> getPokemon(name) async {
    var url = 'https://pokeapi.co/api/v2/ability/$name';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Pokemon.fromJson(json.decode(response.body));
    } else {
      throw Exception('${response.reasonPhrase}');
    }
  }
}
