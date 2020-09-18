import 'package:doce_blocks/data/models/models.dart';
import 'package:doce_blocks/domain/bloc/bloc.dart';
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
        landscape: (context) => _buildSmallPage(context),
      ),
      desktop: _buildSmallPage(context),
    );
  }

  Widget _buildSmallPage(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
          iconTheme: Theme.of(context).accentIconTheme,
          title: Text(DBString.profile_title, style: Theme.of(context).textTheme.headline6),
          elevation: 0.0,
        ),
        body: SafeArea(
          child: _buildContent(),
        ),);
  }

  Widget _buildContent(){
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state){
        if(state is AuthenticationSuccess){

          User user = state.user;

          return Container(
            padding: EdgeInsets.all(DBDimens.PaddingDefault),
            color: Theme.of(context).backgroundColor,
            child:
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [

                SizedBox(height: DBDimens.PaddingDouble),

                Container(
                  margin: EdgeInsets.all(DBDimens.PaddingHalf),
                  padding: EdgeInsets.all(DBDimens.PaddingQuarter),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 3, color: Theme.of(context).primaryColor)),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: DBDimens.RadiusAvatar,
                    child: Text(user.getInitials(), style: Theme.of(context).accentTextTheme.headline4),
                  ),
                ),



                SizedBox(height: DBDimens.PaddingDefault),
                Text('${user.name} ${user.lastName}', style: Theme.of(context).textTheme.headline4),
                SizedBox(height: DBDimens.PaddingHalf),
                Text(user.email, textAlign: TextAlign.center, style: Theme.of(context).textTheme.subtitle1),
                SizedBox(height: DBDimens.PaddingDouble),
                Divider(color: Colors.grey, height: 1),

                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: new InkWell(
                      onTap: () {
                        BlocProvider.of<AuthenticationBloc>(context).add(
                          AuthenticationLoggedOut(),
                        );
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.logout, color: Theme.of(context).accentIconTheme.color),
                            SizedBox(width: DBDimens.PaddingHalf),
                            Text(DBString.profile_signout, style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                      ),
                  ),
                )


              ],
            )
          );
        }

        return Container(
          color: Theme.of(context).backgroundColor,
        );
      },
    );
  }
}