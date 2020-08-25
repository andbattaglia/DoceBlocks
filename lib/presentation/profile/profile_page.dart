import 'package:doce_blocks/data/models/models.dart';
import 'package:doce_blocks/domain/bloc/bloc.dart';
import 'package:doce_blocks/domain/bloc/theme/theme_bloc.dart';
import 'package:doce_blocks/presentation/utils/dimens.dart';
import 'package:doce_blocks/presentation/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: _buildSmallPage(context),
      tablet: OrientationLayoutBuilder(
        portrait: (context) => _buildSmallPage(context),
        landscape: (context) => _buildLargePage(context),
      ),
      desktop: _buildLargePage(context),
    );
  }

  Widget _buildSmallPage(BuildContext context){
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DBDimens.PaddingDefault),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state){
          if(state is AuthenticationSuccess){
            return _buildContent(state.user);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildLargePage(BuildContext context){
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state){
        if(state is AuthenticationSuccess){
          return Container(
            padding: EdgeInsets.only(right: DBDimens.PaddingHalf),
            child: _buildContent(state.user),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildContent(User user){
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DBDimens.CornerDefault),
      ),
      child: Container(
        constraints: BoxConstraints(maxWidth: 400),
        padding: EdgeInsets.all(DBDimens.PaddingDouble),
        child:
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAvatar(context, user.getInitials()),
              SizedBox(height: DBDimens.PaddingDefault),
              Text('${user.name} ${user.lastName}', style: Theme.of(context).textTheme.headline6),
              SizedBox(height: DBDimens.PaddingHalf),
              Text(user.email, textAlign: TextAlign.center, style: Theme.of(context).textTheme.subtitle1),
              SizedBox(height: DBDimens.PaddingDefault),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildThemeSwitchButton(context),
                  SizedBox(width: DBDimens.PaddingDefault),
                  _buildLogoutButton(context),
                ],
              )
            ],
        ),
      )
    );
  }

  Widget _buildAvatar(BuildContext context, String name){
    return Container(
      child:CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        radius: DBDimens.RadiusAvatar,
        child: Text(name, style: Theme.of(context).textTheme.headline4),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context){
    return _buildInk(Icons.logout, () {
      BlocProvider.of<AuthenticationBloc>(context).add(
        AuthenticationLoggedOut(),
      );
      Navigator.of(context).pop();
    });
  }

  Widget _buildThemeSwitchButton(BuildContext context) {
    return BlocBuilder<SettingsThemeBloc, SettingsThemeState>(
        builder: (context, state) {

          if(state is ChangeThemeLight){
            return _buildInk(Icons.brightness_5, () {
              BlocProvider.of<SettingsThemeBloc>(context).add(OnSettingsThemeChangedEvent(true));
            });
          }

          if(state is ChangeThemeDark) {
            return _buildInk(Icons.bedtime, () {
              BlocProvider.of<SettingsThemeBloc>(context).add(OnSettingsThemeChangedEvent(false));
            });
          }

          return Container();
        }
    );
  }

  Widget _buildInk(IconData iconData, Function onPressed){
    return Ink(
      decoration: ShapeDecoration(
        color: Theme.of(context).toggleButtonsTheme.color,
        shape: CircleBorder(),
      ),
      child: IconButton(
        icon: Icon(iconData),
        iconSize: DBDimens.PaddingDefault,
        onPressed: onPressed,
      ),
    );
  }
}