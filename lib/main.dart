import 'package:files_and_storage/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home/bloc/files_bloc.dart';

void main() => runApp(
      BlocProvider(
        create: (context) => FilesBloc(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: ColorScheme.dark()),
      home: HomePage(),
    );
  }
}
