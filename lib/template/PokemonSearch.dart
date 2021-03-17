import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/api/Pokemon.dart';
import 'package:pokemon_app/bloc/PokemonBloc.dart';
import 'package:pokemon_app/event/PokemonEvent.dart';

class PokemonSearch extends SearchDelegate<Pokemon> {
  final List<dynamic> pokemonlist;

  PokemonSearch(this.pokemonlist);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final myList = query.isEmpty
        ? pokemonlist
        : pokemonlist
            .where((element) => element.name.startsWith(query))
            .toList();

    return myList.isEmpty
        ? Center(child: Text('fail'))
        : ListView.builder(
            itemCount: myList.length,
            itemBuilder: (context, i) {
              return ListTile(
                onTap: () async {
                  BlocProvider.of<PokemonBloc>(context)
                      .add(PokemonInfo(name: myList[i].name));
                  await Navigator.pushNamed(context, '/pokemonDetail');
                },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${myList[i].name}',
                      style: TextStyle(
                        fontFeatures: [FontFeature.enable('smcp')],
                      ),
                    ),
                    Divider(),
                  ],
                ),
              );
            },
          );
  }
}
