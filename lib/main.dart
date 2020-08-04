import 'package:doce_blocks/presentation/auth/authentication_bloc.dart';
import 'package:doce_blocks/presentation/home/home_page.dart';
import 'package:doce_blocks/presentation/login/login_page.dart';
import 'package:doce_blocks/presentation/utils/simple_bloc_observer.dart';
import 'package:doce_blocks/presentation/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


//void main() => runApp(new App());

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc()
        ..add(AuthenticationStarted()),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      title: 'DoceBlocks',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          print(state.toString());
          if (state is AuthenticationInitial) {
            return SplashPage();
          }
          if (state is AuthenticationSuccess) {
            return HomePage();
          }
          if (state is AuthenticationFailure) {
            return LoginPage();
          }
          return Container();
        },
      ),
    );
  }
}

