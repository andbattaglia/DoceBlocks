import 'package:doce_blocks/data/models/models.dart';
import 'package:doce_blocks/domain/bloc/blocks/blocks_bloc.dart';
import 'package:doce_blocks/domain/bloc/sections/sections_bloc.dart';
import 'package:doce_blocks/presentation/pages/add_section_page.dart';
import 'package:doce_blocks/presentation/utils/dimens.dart';
import 'package:doce_blocks/presentation/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SectionsListPage extends StatefulWidget {
  @override
  _SectionsListPageState createState() => _SectionsListPageState();
}

class _SectionsListPageState extends State<SectionsListPage> {
  SectionsBloc _sectionsBloc;
  BlockBloc _blockBloc;

  @override
  void initState() {
    _sectionsBloc = new SectionsBloc();
    _blockBloc = new BlockBloc();
  }

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
  //          LARGE PAGE
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildLargePage(BuildContext context) {
//    return BlocBuilder<PagesBloc, PagesState>(
//        builder: (context, state) {
//
//          if(state is GetPagesSuccess){
//
//            var pagesList = state.pages;
//
//            return ListView.builder(
//                itemCount: pagesList.length + 2,
//                itemBuilder: (context, index) {
//                  if(index == 0){
//                    return ProfilePage();
//                  } else if(index == pagesList.length + 1){
//                    return _buildAddPageItem(context, false);
//                  } else {
//                    var customPage = pagesList[index-1];
//                    return _buildLargePageItem(context, customPage);
//                  }
//                });
//          }
//
//          return ListView(
//            children: <Widget>[
//              ProfilePage()
//            ],
//          );
//        }
//    );
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
            Text(DBString.standard_remove, style: Theme.of(context).accentTextTheme.bodyText1),
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
        margin: EdgeInsets.all(DBDimens.PaddingHalf),
        decoration: BoxDecoration(
          color: section.isSelected ? Theme.of(context).selectedRowColor : Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(DBDimens.CornerDefault)),
        ),
        child: new InkWell(
            borderRadius: BorderRadius.all(Radius.circular(DBDimens.CornerDefault)),
            onTap: () {
              _sectionsBloc.add(SelectSectionEvent(id: section.uid));
              _blockBloc.add(GetBlocksEvent(pageId: section.uid));
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(DBDimens.PaddingDefault),
              child: Row(
                children: [
                  Icon(section.materialIcon, color: Theme.of(context).primaryIconTheme.color),
                  SizedBox(width: DBDimens.PaddingHalf),
                  Expanded(child: Text(section.name, style: Theme.of(context).textTheme.bodyText1)),
                ],
              ),
            )),
      ),
    );
  }

  Widget _buildLargePageItem(BuildContext context, Section section) {
    return Container(
        margin: EdgeInsets.only(left: DBDimens.PaddingDefault),
        child: Column(
          children: [
            Container(
              height: 8,
              color: section.isSelected ? Theme.of(context).backgroundColor : Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(DBDimens.CornerDefault)),
                ),
              ),
            ),
            Container(
              height: 56,
              padding: EdgeInsets.only(left: DBDimens.PaddingDefault),
              decoration: BoxDecoration(
                color: section.isSelected ? Theme.of(context).backgroundColor : Colors.transparent,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(DBDimens.CornerDefault), topLeft: Radius.circular(DBDimens.CornerDefault)),
              ),
              child: new InkWell(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(DBDimens.CornerDefault), topLeft: Radius.circular(DBDimens.CornerDefault)),
                  onTap: () {
                    BlocProvider.of<SectionsBloc>(context).add(SelectSectionEvent(id: section.uid));
                  },
                  child: Container(
                    constraints: BoxConstraints.expand(),
                    child: Row(
                      children: [
                        Expanded(child: Text(section.name, style: section.isSelected ? Theme.of(context).textTheme.bodyText1 : Theme.of(context).accentTextTheme.bodyText1)),
                        IconButton(
                          icon: Icon(Icons.close, color: section.isSelected ? Theme.of(context).primaryIconTheme.color : Theme.of(context).iconTheme.color),
                          onPressed: () {
                            BlocProvider.of<SectionsBloc>(context).add(DeleteSectionEvent(id: section.uid));
                          },
                        ),
                      ],
                    ),
                  )),
            ),
            Container(
              height: 8,
              color: section.isSelected ? Theme.of(context).backgroundColor : Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(DBDimens.CornerDefault)),
                ),
              ),
            ),
          ],
        ));
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
            borderRadius: BorderRadius.all(Radius.circular(DBDimens.CornerDefault)),
          ),
          child: new InkWell(
              borderRadius: BorderRadius.all(Radius.circular(DBDimens.CornerDefault)),
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
                    Text(DBString.standard_add.toUpperCase(), style: lightBackground ? Theme.of(context).primaryTextTheme.button : Theme.of(context).primaryTextTheme.button),
                    SizedBox(width: DBDimens.PaddingHalf),
                    Icon(Icons.add, size: DBDimens.IconSizeSmall, color: lightBackground ? Theme.of(context).primaryIconTheme.color : Theme.of(context).primaryIconTheme.color)
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
