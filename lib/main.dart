import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/bloc/PokemonBloc.dart';
import 'package:pokemon_app/services/db.dart';
import 'package:pokemon_app/template/HomePage.dart';
import 'package:pokemon_app/template/PokemonDetail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        routes: {
          '/pokemonDetail': (context) => PokemonDetail(),
        },
      ),
    );
  }
}
