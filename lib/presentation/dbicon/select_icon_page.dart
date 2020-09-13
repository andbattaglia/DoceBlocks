import 'package:doce_blocks/domain/bloc/dbicon/db_icon_bloc.dart';
import 'package:doce_blocks/presentation/utils/dimens.dart';
import 'package:doce_blocks/presentation/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SelectIconPage extends StatefulWidget {
  @override
  _SelectIconPageState createState() => _SelectIconPageState();
}

class _SelectIconPageState extends State<SelectIconPage> {

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

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          SMALL PAGE
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildSmallPage(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: Theme.of(context).accentIconTheme,
        title: Text(DBString.add_section_choose_icon_title, style: Theme.of(context).textTheme.headline6),
        elevation: 0.0,
      ),
      body: _buildContent(context)
    );
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          LARGE PAGE
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildLargePage(BuildContext context){
    return Container();
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          CONTENT
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildContent(BuildContext context){

    return BlocProvider<IconBloc>(
        create: (_) => IconBloc()..add(GetIconsEvent()),
        child: BlocBuilder<IconBloc, IconState>(
            builder: (context, state) {

              if(state is GetIconSuccess){

                var icons = state.icons;

                return ListView.builder(
                    itemCount: icons.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Theme.of(context).backgroundColor,
                        child: Column(
                          children: [
                            Divider(color: Colors.grey, height: 1),
                            InkWell(
                              child: Container(
                                padding: EdgeInsets.all(DBDimens.PaddingDefault),
                                child: Row(
                                  children: [
                                    Icon(icons[index].mapToIcon, color: Theme.of(context).accentIconTheme.color),
                                    SizedBox(width: DBDimens.PaddingDefault),
                                    Expanded(child: Text(icons[index].name, style: Theme.of(context).textTheme.bodyText1)),
                                  ],
                                ),
                              ),
                              onTap: () {
                                BlocProvider.of<IconBloc>(context).add(SelectIconEvent(iconId: icons[index].id));
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        )
                      );
                    });
              }
              return Container();
            }
        )
    );
  }
}
