import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/bloc/PokemonBloc.dart';
import 'package:pokemon_app/event/PokemonEvent.dart';
import 'package:pokemon_app/models/TodoItem.dart';
import 'package:pokemon_app/services/db.dart';
import 'package:pokemon_app/state/PokemonState.dart';
import 'package:pokemon_app/template/PokemonSearch.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  List<TodoItem> pokemon = [];

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void _save(a) async {
    TodoItem item = TodoItem(name: a);
    await DB.insert(TodoItem.table, item);
    refresh();
  }

  void refresh() async {
    List<Map<String, dynamic>> _results = await DB.query(TodoItem.table);
    pokemon = _results.map((item) => TodoItem.fromMap(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        if (state is PokemonLoadSuccess) {
          if (pokemon.isEmpty) {
            for (int i = 0; i < state.pokemonList.length; i++) {
              _save(state.pokemonList[i].name);
            }
          }
        }
        if (pokemon.isNotEmpty) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Pokemon App'),
              backgroundColor: Colors.amber[700],
            ),
            body: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/pokemon.jpg',
                  fit: BoxFit.cover,
                ),
              ],
            ),
            drawer: Drawer(
              child: ListView(
                children: [
                  Container(
                    height: 70,
                    child: DrawerHeader(
                      child: Text(
                        "Menu",
                        style: TextStyle(fontSize: 30),
                      ),
                      decoration: BoxDecoration(color: Colors.amber[700]),
                    ),
                  ),
                  ListTile(
                    title: Text('Search for pokemon'),
                    leading: Icon(Icons.search),
                    onTap: () {
                      showSearch(
                        context: context,
                        delegate: PokemonSearch(pokemon),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Random pokemon'),
                    leading: Icon(Icons.autorenew),
                    onTap: () async {
                      var rand = Random();
                      BlocProvider.of<PokemonBloc>(context).add(PokemonInfo(
                          name: pokemon[rand.nextInt(pokemon.last.id)].name));
                      await Navigator.pushNamed(context, '/pokemonDetail');
                    },
                  ),
                  Divider(),
                ],
              ),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.amber[700],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.amber[700]),
            ),
          ),
        );
      },
    );
  }
}
