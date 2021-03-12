import 'package:equatable/equatable.dart';
import 'package:pokemon_app/api/PokemonList.dart';
import 'package:pokemon_app/api/Pokemon.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object> get props => [];
}

class PokemonInitial extends PokemonState {}

class PokemonLoadInProgress extends PokemonState {}

class PokemonLoadSuccess extends PokemonState {
  final List<PokemonList> pokemonList;

  const PokemonLoadSuccess(this.pokemonList) : assert(pokemonList != null);

  @override
  List<Object> get props => [pokemonList];
}

class PokemonInfoLoadSuccess extends PokemonState {
  final Pokemon pokemon;

  const PokemonInfoLoadSuccess(this.pokemon) : assert(pokemon != null);

  @override
  List<Object> get props => [pokemon];
}

class PokemonLoadFail extends PokemonState {}
