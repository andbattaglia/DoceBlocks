import 'package:doce_blocks/data/models/models.dart';
import 'package:doce_blocks/domain/bloc/bloc.dart';
import 'package:doce_blocks/domain/bloc/theme/settings_theme_bloc.dart';
import 'package:doce_blocks/presentation/utils/dimens.dart';
import 'package:doce_blocks/presentation/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DBDimens.PaddingDefault),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state){
        if(state is AuthenticationSuccess){
          return _authSuccess(state.user);
        }
        return Container();
      },
    );
  }

  Widget _authSuccess(User user){
    return Stack(
      children: <Widget>[
        Container(
          constraints: BoxConstraints(maxWidth: 400),
          padding: EdgeInsets.only(
            top: DBDimens.RadiusAvatar + DBDimens.PaddingDefault,
            bottom: DBDimens.PaddingDefault,
            left: DBDimens.PaddingDefault,
            right: DBDimens.PaddingDefault,
          ),
          margin: EdgeInsets.only(top: DBDimens.RadiusAvatar),
          decoration: new BoxDecoration(
            color: Theme.of(context).backgroundColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(DBDimens.PaddingDefault),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text('${user.name} ${user.lastName}', style: Theme.of(context).textTheme.headline5),
              SizedBox(height: DBDimens.PaddingHalf),
              Text(user.email, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline6),
              SizedBox(height: DBDimens.PaddingDefault),
              _buildColorSwitch(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // To close the dialog
                    },
                    child: Text(DBString.standard_cancel),
                  ),
                  FlatButton(
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                        AuthenticationLoggedOut(),
                      );
                      Navigator.of(context).pop();
                    },
                    child: Text(DBString.standard_signout),
                  ),
                ],
              )
            ],
          ),
        ),
        _buildProfileAvatar(context, '${user.name[0]}${user.lastName[0]}')
      ],
    );
  }

  Widget _buildProfileAvatar(BuildContext context, String name){
    return Positioned(
        left: DBDimens.PaddingDefault,
        right: DBDimens.PaddingDefault,
        child: Container(
          child:CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: DBDimens.RadiusAvatar,
            child: Text(name, style: Theme.of(context).textTheme.headline4,),
          ),
        )
    );
  }

  Widget _buildColorSwitch(BuildContext context) {
    return BlocBuilder<SettingsThemeBloc, SettingsThemeState>(
      builder: (context, state) {
        return Row (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text( DBString.setting_switch_theme, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText2 ),
            Switch(
              value: state.themeState.isDarkMode,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (value) {
                BlocProvider.of<SettingsThemeBloc>(context).add(OnSettingsThemeChangedEvent(value));
              },
            )
          ],
        );
      }
    );
  }
}