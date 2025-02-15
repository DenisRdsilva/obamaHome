// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:obamahome/app/views/search/searchOA_view.dart';
import 'package:obamahome/templates/template_basic_col.dart';

import '../../../../utils/app_padding.dart';

class SearchTablet extends StatefulWidget {
  String termSearched;
  int selectedPageIndex;
  Function(void) updateData;
  void Function(int) selectedPage;
  TextStyle titleStyle;

  SearchTablet(
      {Key? key,
      required this.termSearched,
      required this.selectedPageIndex,
      required this.updateData,
      required this.selectedPage,
      required this.titleStyle})
      : super(key: key);

  @override
  State<SearchTablet> createState() => _SearchTabletState();
}

class _SearchTabletState extends State<SearchTablet> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    return TemplateColumn(children: [
      Container(
        margin: paddingValues("sectionPadding", context),
        padding: paddingValues("sideMainPadding", context),
        child: ExpansionTile(title: Text("Busca Avançada"), children: [
          // Padding(
          //   padding: paddingValues("fullGrid", context),
          //   child: OAFilters(
          //     swidth: swidth,
          //     data: widget.termSearched,
          //     updateData: widget.updateData,
          //     titleStyle: widget.titleStyle,
          //   ),
          // ),
        ]),
      ),
      SearchPageView(widget.termSearched, swidth, widget.selectedPageIndex,
          widget.selectedPage, null),
      SizedBox(
        height: 65,
      ),
    ]);
  }
}
