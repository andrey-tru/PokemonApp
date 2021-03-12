class PokemonList {
  final String name;
  final String url;

  PokemonList({this.name, this.url});

  factory PokemonList.fromJson(Map<String, dynamic> json) {
    return PokemonList(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }
}