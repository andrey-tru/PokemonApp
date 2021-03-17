import 'package:equatable/equatable.dart';
import 'package:pokemon_app/api/Pokemon.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object> get props => [];
}

class PokemonInitial extends PokemonState {}

class PokemonLoadInProgress extends PokemonState {}

class PokemonLoadSuccess extends PokemonState {
  final List<dynamic> pokemon;

  const PokemonLoadSuccess(this.pokemon) : assert(pokemon != null);

  @override
  List<Object> get props => [pokemon];
}

class PokemonInfoLoadSuccess extends PokemonState {
  final Pokemon pokemonDetail;

  const PokemonInfoLoadSuccess(this.pokemonDetail) : assert(pokemonDetail != null);

  @override
  List<Object> get props => [pokemonDetail];
}

class PokemonLoadFail extends PokemonState {}
