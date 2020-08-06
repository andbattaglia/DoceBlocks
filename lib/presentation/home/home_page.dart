import 'package:doce_blocks/domain/bloc/bloc.dart';
import 'package:doce_blocks/presentation/drawer/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    if(kIsWeb){
      return Scaffold(
          appBar: AppBar(
            title: Text('WEB'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(
                    AuthenticationLoggedOut(),
                  );
                },
              )
            ],
          ),
          body: Container()
      );
    } else {
      return Scaffold(
          drawer: DrawerMenu(),
          appBar: AppBar(
            title: Text('MOBILE'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(
                    AuthenticationLoggedOut(),
                  );
                },
              )
            ],
          ),
          body: Container()
      );
    }
  }
}