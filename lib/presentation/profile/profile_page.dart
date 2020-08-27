import 'package:doce_blocks/data/models/models.dart';
import 'package:doce_blocks/domain/bloc/bloc.dart';
import 'package:doce_blocks/domain/bloc/theme/theme_bloc.dart';
import 'package:doce_blocks/presentation/utils/dimens.dart';
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
            padding: EdgeInsets.only(left: DBDimens.PaddingDefault, right: DBDimens.PaddingDefault, top: DBDimens.PaddingDefault, bottom: DBDimens.PaddingHalf),
            child: _buildContent(state.user),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildContent(User user){
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
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
        child: Text(name, style: Theme.of(context).accentTextTheme.headline4),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context){
    return _buildInk(context, Icons.logout, () {
      var deviceType = getDeviceType(MediaQuery.of(context).size);
      if(deviceType == DeviceScreenType.mobile) {
        Navigator.of(context).pop();
      }

      BlocProvider.of<AuthenticationBloc>(context).add(
        AuthenticationLoggedOut(),
      );

    });
  }

  Widget _buildThemeSwitchButton(BuildContext context) {
    return BlocBuilder<SettingsThemeBloc, SettingsThemeState>(
        builder: (context, state) {

          if(state is ChangeThemeLight){
            return _buildInk(context, Icons.brightness_5, () {
              BlocProvider.of<SettingsThemeBloc>(context).add(OnSettingsThemeChangedEvent(true));
            });
          }

          if(state is ChangeThemeDark) {
            return _buildInk(context, Icons.bedtime, () {
              BlocProvider.of<SettingsThemeBloc>(context).add(OnSettingsThemeChangedEvent(false));
            });
          }

          return Container();
        }
    );
  }

  Widget _buildInk(BuildContext context, IconData iconData, Function onPressed){
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 0.0,
      fillColor: Theme.of(context).selectedRowColor,
      child: Icon(iconData, color: Theme.of(context).primaryIconTheme.color),
      padding: EdgeInsets.all(15.0),
      shape: CircleBorder(),
    );
  }
}