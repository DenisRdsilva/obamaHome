import 'package:flutter/material.dart';
import 'package:obamahome/components/navMenu.dart';
import 'package:obamahome/components/topbar.dart';
import 'package:obamahome/utils/cores_personalizadas.dart';

import '../../../utils/app_theme.dart';
import 'components/pageViewElements.dart';
import 'components/textEditorClass.dart';

class NewLessonPlan extends StatefulWidget {
  const NewLessonPlan({super.key});

  @override
  State<NewLessonPlan> createState() => _NewLessonPlanState();
}

class _NewLessonPlanState extends State<NewLessonPlan> {
  late PageController _pageViewController;
  // late TabController _tabController;
  int stepSelected = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    // _initController(_controller);
    // print(_controller.document.toDelta().toHtml());
  }

  void _updateCurrentPageIndex(int index) {
    // _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    // _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double logoWidth = 250;

    if (swidth < 700) {
      logoWidth = 180;
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          TopBar(swidth),
          Container(
            margin: EdgeInsets.symmetric(horizontal: swidth * .1),
            padding: const EdgeInsets.only(top: 35, bottom: 15),
            constraints: BoxConstraints(maxWidth: 1200),
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/images/logo.png", width: logoWidth),
                  NavMenu(
                    swidth: swidth,
                    heightBtn: 50,
                    itemValues: editorValues,
                    searchAvailable: false,
                  )
                ]),
          ),
          Container(
            width: swidth,
            padding: EdgeInsets.only(top: 15),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              for (var i = 0; i < 3; i++) ...{
                Material(
                  child: InkWell(
                    child: Container(
                      width: swidth > 1200 ? 1200 * .33 : swidth * .33,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 2,
                                  color: stepSelected == i
                                      ? CoresPersonalizadas.azulObama
                                      : onPrimary))),
                      // padding: EdgeInsets.only(bottom: 10),
                      child: Center(
                          child: Text("Passo ${i + 1}",
                              style: TextStyle(
                                  fontWeight: stepSelected == i
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: stepSelected == i
                                      ? CoresPersonalizadas.azulObama
                                      : onPrimary))),
                    ),
                    onTap: () {
                      setState(() {
                        stepSelected = i;
                      });
                      if (_pageViewController.hasClients) {
                        _pageViewController.animateToPage(
                          i,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  ),
                )
              }
            ]),
          ),
          Container(
            width: swidth,
            height: 1500,
            padding: EdgeInsets.only(top: 25),
            child: PageView.builder(
              controller: _pageViewController,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                // for (var i = 1; i<=3; i++) {
                return Material(
                    child: Column(children: [paveViewContent[index]]));
                // }
              },
            ),
          ),
        ],
      ),
    );
  }
}
