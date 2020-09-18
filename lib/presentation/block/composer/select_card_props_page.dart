import 'package:doce_blocks/data/models/block.dart';
import 'package:doce_blocks/domain/bloc/blocks/blocks_bloc.dart';
import 'package:doce_blocks/domain/bloc/card_size/card_size_bloc.dart';
import 'package:doce_blocks/presentation/utils/dimens.dart';
import 'package:doce_blocks/presentation/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SelectCardPropsPage extends StatefulWidget {
  @override
  _SelectCardPropsPageState createState() => _SelectCardPropsPageState();
}

class _SelectCardPropsPageState extends State<SelectCardPropsPage> {
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

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          SMALL PAGE
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildSmallPage(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: Theme.of(context).accentIconTheme,
          title: Text(DBString.add_block_choose_size_title,
              style: Theme.of(context).textTheme.headline6),
          elevation: 0.0,
        ),
        body: _buildContent(context));
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          CONTENT
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildContent(BuildContext context) {
    return BlocProvider<CardSizeBloc>(
        create: (_) => CardSizeBloc()..add(GetCardSizeEvent()),
        child:
            BlocBuilder<CardSizeBloc, CardSizeState>(builder: (context, state) {
          if (state is GetCardSizeInitial) {
            final values = state.values;

            return ListView.builder(
                itemCount: values.length,
                itemBuilder: (context, index) {
                  final value = values[index];

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
                                  Text(value.tag,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                ],
                              ),
                            ),
                            onTap: () {
                              BlocProvider.of<CardSizeBloc>(context)
                                  .add(SelectCardSizeEvent(cardSize: value));
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ));
                });
          }
          return Container();
        }));
  }
}
