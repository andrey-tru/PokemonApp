class Pokemon {
  final String name;
  final String effect;
  final String shortEffect;
  final String generation;

  Pokemon({this.name, this.effect, this.shortEffect, this.generation});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'] as String,
      effect: json['effect_entries'][1]['effect'] as String,
      shortEffect: json['effect_entries'][1]['short_effect'] as String,
      generation: json['generation']['name'] as String,
    );
  }
}
