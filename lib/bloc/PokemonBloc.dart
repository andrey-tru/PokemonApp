import 'package:bloc/bloc.dart';
import 'package:pokemon_app/api/PokemonApi.dart';
import 'package:pokemon_app/api/PokemonList.dart';
import 'package:pokemon_app/api/Pokemon.dart';
import 'package:pokemon_app/event/PokemonEvent.dart';
import 'package:pokemon_app/state/PokemonState.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc() : super(null) {
    add(PokemonRequested());
  }

  Stream<PokemonState> mapEventToState(PokemonEvent event) async* {
    if (event is PokemonRequested) {
      yield PokemonLoadInProgress();
      try {
        final List<PokemonList> pokemonList = await PokemonApi.getListPokemon();
        yield PokemonLoadSuccess(pokemonList);
      } catch (_) {
        yield PokemonLoadFail();
      }
    }

    if (event is PokemonInfo) {
      yield PokemonLoadInProgress();
      try {
        print(event.name);
        final Pokemon pokemon = await PokemonApi.getPokemon(event.name);
        yield PokemonInfoLoadSuccess(pokemon);
      } catch(_) {
        yield PokemonLoadFail();
      }
    }
  }
}
