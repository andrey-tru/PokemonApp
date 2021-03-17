import 'package:bloc/bloc.dart';
import 'package:pokemon_app/api/PokemonApi.dart';
import 'package:pokemon_app/api/PokemonList.dart';
import 'package:pokemon_app/api/Pokemon.dart';
import 'package:pokemon_app/event/PokemonEvent.dart';
import 'package:pokemon_app/models/TodoItem.dart';
import 'package:pokemon_app/services/db.dart';
import 'package:pokemon_app/state/PokemonState.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc() : super(null) {
    add(PokemonRequested());
  }

  List<TodoItem> pokemon = [];

  void _save(name) async {
    TodoItem item = TodoItem(name: name);
    await DB.insert(TodoItem.table, item);
    refresh();
  }

  void refresh() async {
    List<Map<String, dynamic>> _results = await DB.query(TodoItem.table);
    pokemon = _results.map((item) => TodoItem.fromMap(item)).toList();
  }

  Stream<PokemonState> mapEventToState(PokemonEvent event) async* {
    if (event is PokemonRequested) {
      yield PokemonLoadInProgress();
      refresh();
      try {
        final List<PokemonList> pokemonList = await PokemonApi.getListPokemon();
        if (pokemon.isEmpty) {
          for (int i = 0; i < pokemonList.length; i++) {
            _save(pokemonList[i].name);
          }
          yield PokemonLoadSuccess(pokemonList);
        } else {
          yield PokemonLoadSuccess(pokemon);
        }
      } catch (_) {
        yield PokemonLoadFail();
      }
    }

    if (event is PokemonInfo) {
      yield PokemonLoadInProgress();
      try {
        final Pokemon pokemonDetail = await PokemonApi.getPokemon(event.name);
        yield PokemonInfoLoadSuccess(pokemonDetail);
      } catch (_) {
        yield PokemonLoadFail();
      }
    }
  }
}
