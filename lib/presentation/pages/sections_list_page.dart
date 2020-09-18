import 'dart:developer';

import 'package:doce_blocks/data/models/models.dart';
import 'package:doce_blocks/domain/bloc/blocks/blocks_bloc.dart';
import 'package:doce_blocks/domain/bloc/sections/sections_bloc.dart';
import 'package:doce_blocks/presentation/pages/add_section_page.dart';
import 'package:doce_blocks/presentation/utils/dimens.dart';
import 'package:doce_blocks/presentation/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SectionsListPage extends StatefulWidget {
  @override
  _SectionsListPageState createState() => _SectionsListPageState();
}

class _SectionsListPageState extends State<SectionsListPage> {
  SectionsBloc _sectionsBloc;
  BlocksBloc _blocksBloc;

  @override
  void initState() {
    _sectionsBloc = new SectionsBloc();
    _blocksBloc = new BlocksBloc();
  }

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
    return Container(
        child: new StreamBuilder(
            stream: _sectionsBloc.getCachedSectionsStream(),
            builder: (context, AsyncSnapshot<List<Section>> snapshot) {
              if (snapshot.hasData) {
                var pagesList = snapshot.data;

                return ListView.builder(
                    itemCount: pagesList.length + 1,
                    itemBuilder: (context, index) {
                      if (index == pagesList.length) {
                        return _buildAddPageItem(context, true);
                      } else {
                        return _buildSmallPageItem(context, pagesList[index]);
                      }
                    });
              }
              return Container();
            }));
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          PAGE_ITEM
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildSmallPageItem(BuildContext context, Section section) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(DBString.standard_remove,
                style: Theme.of(context).accentTextTheme.bodyText1),
            SizedBox(width: DBDimens.PaddingHalf),
            Icon(Icons.delete, color: Theme.of(context).iconTheme.color),
            SizedBox(width: DBDimens.PaddingHalf),
          ],
        ),
      ),
      key: Key(section.uid),
      onDismissed: (direction) {
        _sectionsBloc..add(DeleteSectionEvent(id: section.uid));
      },
      child: Container(
        margin: EdgeInsets.only(
            top: DBDimens.PaddingHalf,
            right: DBDimens.PaddingHalf,
            bottom: DBDimens.PaddingHalf),
        decoration: BoxDecoration(
          color: section.isSelected
              ? Theme.of(context).selectedRowColor
              : Colors.transparent,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(DBDimens.CornerDefault),
              bottomRight: Radius.circular(DBDimens.CornerDefault)),
        ),
        child: new InkWell(
            borderRadius:
                BorderRadius.all(Radius.circular(DBDimens.CornerDefault)),
            onTap: () {
              _sectionsBloc.add(SelectSectionEvent(id: section.uid));
              _blocksBloc.add(GetBlocksEvent(sectionId: section.uid));

              var deviceType = getDeviceType(MediaQuery.of(context).size);
              if (deviceType == DeviceScreenType.mobile) {
                Navigator.pop(context);
              }
            },
            child: Container(
              padding: EdgeInsets.all(DBDimens.PaddingDefault),
              child: Row(
                children: [
                  Icon(section.materialIcon, color: Colors.grey),
                  SizedBox(width: DBDimens.PaddingHalf),
                  Expanded(
                      child: Text(section.name,
                          style: Theme.of(context).textTheme.bodyText1)),
                ],
              ),
            )),
      ),
    );
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          ADD_PAGE_ITEM
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildAddPageItem(BuildContext context, bool lightBackground) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: DBDimens.PaddingDefault),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius:
                BorderRadius.all(Radius.circular(DBDimens.CornerDefault)),
          ),
          child: new InkWell(
              borderRadius:
                  BorderRadius.all(Radius.circular(DBDimens.CornerDefault)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddSectionPage()),
                );
              },
              child: Container(
                padding: EdgeInsets.all(DBDimens.PaddingDefault),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(DBString.standard_add.toUpperCase(),
                        style: lightBackground
                            ? Theme.of(context).primaryTextTheme.button
                            : Theme.of(context).primaryTextTheme.button),
                    SizedBox(width: DBDimens.PaddingHalf),
                    Icon(Icons.add,
                        size: DBDimens.IconSizeSmall,
                        color: lightBackground
                            ? Theme.of(context).primaryIconTheme.color
                            : Theme.of(context).primaryIconTheme.color)
                  ],
                ),
              )),
        )
      ],
    );
  }

//  Widget _buildAddPageDialog(BuildContext context){
//
//    var _inputController = TextEditingController();
//
//    return Dialog(
//      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.circular(DBDimens.PaddingDefault),
//      ),
//      elevation: 0.0,
//      backgroundColor: Colors.transparent,
//      child: Card(
//          elevation: 4.0,
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.circular(DBDimens.CornerDefault),
//          ),
//          child: Container(
//            constraints: BoxConstraints(maxWidth: 400),
//            padding: EdgeInsets.all(DBDimens.PaddingDouble),
//            child:
//            Column(
//              mainAxisSize: MainAxisSize.min,
//              children: [
//                Text(DBString.new_page_title, style: Theme.of(context).textTheme.bodyText1),
//                SizedBox(height: DBDimens.PaddingDefault),
//                TextFormField(
//                  controller: _inputController,
//                  decoration: InputDecoration(
//                    labelStyle: new TextStyle(),
//                    enabledBorder: OutlineInputBorder(
//                      borderSide: BorderSide(color: Theme.of(context).disabledColor),
//                    ),
//                    focusedBorder: OutlineInputBorder(
//                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                    ),
//                  ),
//                  textInputAction: TextInputAction.go,
//                  onFieldSubmitted: (value) {
//                    if(value.trim().isNotEmpty){
//                      Navigator.of(context, rootNavigator: true).pop();
//                      BlocProvider.of<PagesBloc>(context).add(AddPageEvent(name: value.trim()));
//                    }
//                  },
//                ),
//              ],
//            ),
//          )
//      ),
//    );
//  }

}
