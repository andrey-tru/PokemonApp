import 'package:equatable/equatable.dart';

abstract class PokemonEvent extends Equatable {
  const PokemonEvent();

  @override
  List<Object> get props => [];
}

class PokemonRequested extends PokemonEvent {}

class PokemonInfo extends PokemonEvent {
  final String name;

  const PokemonInfo({this.name}) : assert(name != null);

  @override
  List<Object> get props => [name];
}