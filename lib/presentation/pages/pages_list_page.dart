import 'dart:developer';

import 'package:doce_blocks/data/models/models.dart';
import 'package:doce_blocks/domain/bloc/pages/pages_bloc.dart';
import 'package:doce_blocks/presentation/pages/add_page_page.dart';
import 'package:doce_blocks/presentation/utils/dimens.dart';
import 'package:doce_blocks/presentation/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PagesListPage extends StatefulWidget {
  @override
  _PagesListPageState createState() => _PagesListPageState();
}

class _PagesListPageState extends State<PagesListPage> {

  PagesBloc _pagesBloc;

  @override
  void initState() {
    _pagesBloc = new PagesBloc();
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
  Widget _buildSmallPage(BuildContext context){
    return Container(
        child:new StreamBuilder(stream: _pagesBloc.getCachedPageStream(), builder: (context, AsyncSnapshot<List<CustomPage>> snapshot){
          if(snapshot.hasData){

            var pagesList = snapshot.data;

            return ListView.builder(
                itemCount: pagesList.length + 1,
                itemBuilder: (context, index) {
                  if(index == pagesList.length){
                    return _buildAddPageItem(context, true);
                  } else {
                    return _buildSmallPageItem(context, pagesList[index]);
                  }
                });
          }
          return Container();
        })
    );
  }


  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          LARGE PAGE
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildLargePage(BuildContext context){
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
  Widget _buildSmallPageItem(BuildContext context , CustomPage page){
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
        key: Key(page.uid),
        onDismissed: (direction) {
          _pagesBloc..add(DeletePageEvent(id: page.uid));
        },
        child: Container(
          margin: EdgeInsets.all(DBDimens.PaddingHalf),
          decoration: BoxDecoration(
            color: page.isSelected ? Theme.of(context).selectedRowColor : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(DBDimens.CornerDefault)),
          ),
          child: new InkWell(
              borderRadius: BorderRadius.all(Radius.circular(DBDimens.CornerDefault)),
              onTap: () {
                _pagesBloc.add(SelectPageEvent(id: page.uid));
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(DBDimens.PaddingDefault),
                child: Row(
                  children: [
                    Icon(page.materialIcon, color: Theme.of(context).primaryIconTheme.color),
                    SizedBox(width: DBDimens.PaddingHalf),
                    Expanded(child: Text(page.name, style: Theme.of(context).textTheme.bodyText1)),
                  ],
                ),
              )
          ),
        ),
    );
  }

   Widget _buildLargePageItem(BuildContext context , CustomPage page){
    return  Container(
        margin: EdgeInsets.only( left: DBDimens.PaddingDefault),
        child: Column(
          children: [
            Container(
              height: 8,
              color: page.isSelected ? Theme.of(context).backgroundColor : Colors.transparent,
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
                color: page.isSelected ? Theme.of(context).backgroundColor : Colors.transparent,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(DBDimens.CornerDefault), topLeft: Radius.circular(DBDimens.CornerDefault)),
              ),
              child: new InkWell(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(DBDimens.CornerDefault), topLeft: Radius.circular(DBDimens.CornerDefault)),
                  onTap: () {
                    BlocProvider.of<PagesBloc>(context).add(SelectPageEvent(id: page.uid));
                  },
                  child: Container(
                      constraints: BoxConstraints.expand(),
                      child: Row(
                        children: [
                          Expanded(child: Text(page.name, style: page.isSelected ? Theme.of(context).textTheme.bodyText1 : Theme.of(context).accentTextTheme.bodyText1)),
                          IconButton(
                            icon: Icon(Icons.close, color:  page.isSelected ? Theme.of(context).primaryIconTheme.color : Theme.of(context).iconTheme.color),
                            onPressed: (){
                              BlocProvider.of<PagesBloc>(context).add(DeletePageEvent(id: page.uid));
                            },
                          ),
                        ],
                      ),
                  )
              ),
            ),
            Container(
              height: 8,
              color: page.isSelected ? Theme.of(context).backgroundColor : Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(DBDimens.CornerDefault)),
                ),
              ),
            ),
          ],
        )
    );
  }


  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          ADD_PAGE_ITEM
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildAddPageItem(BuildContext context, bool lightBackground){
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddPagePage()),);
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
              )
          ),
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
