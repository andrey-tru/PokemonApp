import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/bloc/PokemonBloc.dart';
import 'package:pokemon_app/state/PokemonState.dart';

class PokemonDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        if (state is PokemonInfoLoadSuccess) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                '${state.pokemonDetail.name}',
                style: TextStyle(
                  fontFeatures: [FontFeature.enable('smcp')],
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.amber[700],
            ),
            body: Container(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  textDirection: TextDirection.ltr,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name:',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${state.pokemonDetail.name}',
                      style: TextStyle(
                        fontSize: 13,
                        fontFeatures: [
                          FontFeature.enable('smcp'),
                        ],
                      ),
                    ),
                    Divider(),
                    Text(
                      'Effect:',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${state.pokemonDetail.effect}',
                      style: TextStyle(fontSize: 13),
                    ),
                    Divider(),
                    Text(
                      'Short Effect:',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${state.pokemonDetail.shortEffect}',
                      style: TextStyle(fontSize: 13),
                    ),
                    Divider(),
                    Text(
                      'Generation:',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${state.pokemonDetail.generation}',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
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
