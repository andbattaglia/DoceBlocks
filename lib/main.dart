import 'package:doce_blocks/domain/bloc/bloc.dart';
import 'package:doce_blocks/domain/bloc/theme/settings_theme_bloc.dart';
import 'package:doce_blocks/presentation/home/home_page.dart';
import 'package:doce_blocks/presentation/login/login_page.dart';
import 'package:doce_blocks/presentation/splash/splash_page.dart';
import 'package:doce_blocks/presentation/utils/themes.dart';
import 'package:doce_blocks/presentation/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  runApp(
//    BlocProvider(
//      create: (context) => AuthenticationBloc()..add(AuthenticationStarted()),
//      child: App(),
//    ),
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) => AuthenticationBloc()..add(AuthenticationStarted()),
        ),
        BlocProvider<SettingsThemeBloc>(
          create: (BuildContext context) => SettingsThemeBloc(),
        ),
      ],
      child: App(),
    )
  );
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsThemeBloc, SettingsThemeState>(
      builder: (context, state){

        return new MaterialApp(
          title: DBString.title,
          theme: kLightTheme,
          darkTheme: kDarkTheme,
          themeMode: state.themeState.themeMode,
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
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
      },
    );

  }
}

